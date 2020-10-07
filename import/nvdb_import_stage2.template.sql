set work_mem=16777216;
set max_parallel_workers_per_gather=2;


WITH segments AS (
  -- Create from/to pairs that are later used to extract substrings from the
  -- original line.
  SELECT
    objectid,
    split AS _from,
    lead(split) OVER (PARTITION BY objectid ORDER BY split) AS _to
  FROM (
    -- Filter out similar points. This extra level with DISTINCT ON (...) is
    -- used instead of UNION DISTINCT as the from/to values are float and as
    -- such not immediately comparable. Casting to numeric and rounding to a
    -- sane value allows us to reject duplicates. The query optimizer actually
    -- applies the cast to the level below.
    SELECT DISTINCT ON (objectid, round(split::numeric,8))
      *
    FROM (
      -- Gather all potential split points for each line, including its own
      -- end points.
      SELECT
        net1.objectid,
        unnest(array[net1.from_measure, net2.from_measure, net1.to_measure]) AS split
      FROM
        {{net_table}} net1
      JOIN
        {{src_table}} net2 USING (route_id)
      WHERE
            round(net2.from_measure::numeric, 8) > round(net1.from_measure::numeric, 8)
        AND round(net2.from_measure::numeric, 8) < round(net1.to_measure::numeric, 8)
      UNION ALL
      SELECT
        net1.objectid,
        unnest(array[net1.from_measure, net2.to_measure, net1.to_measure]) AS split
      FROM
        {{net_table}} net1
      JOIN
        {{src_table}} net2 USING (route_id)
      WHERE
            round(net2.to_measure::numeric, 8) > round(net1.from_measure::numeric, 8)
        AND round(net2.to_measure::numeric, 8) < round(net1.to_measure::numeric, 8)
    ) split_candidates
  ) split_points
),
del AS (
  -- Delete parent lines and return the data necessary to create the new
  -- segments.
  DELETE FROM
    {{net_table}} a
  USING
    segments b
  WHERE
    a.objectid = b.objectid
  RETURNING
    a.geom, a.objectid, a.route_id, a.from_measure, a.to_measure
)
-- Finally, use segment endpoint data combined with geometry and route_id from
-- the original object to creat new line strings.
INSERT INTO
  {{net_table}} (route_id, from_measure, to_measure, geom)
SELECT
  route_id,
  _from,
  _to,
  -- Calculate relative offset as the original line can already be a substring.
  ST_LineSubstring(geom, (_from - from_measure) / (to_measure - from_measure), (_to - from_measure) / (to_measure - from_measure)) AS geom
FROM
  segments
JOIN
  del USING (objectid)
WHERE
  _to IS NOT NULL
