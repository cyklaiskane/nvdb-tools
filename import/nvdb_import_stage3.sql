set work_mem=16777216;
set max_parallel_workers_per_gather=2;


-- Vägtrafiknät
UPDATE nvdb_skane_network net
SET
  road_type = src.vagtr_474
FROM nvdb_skane_tne_ft_vagtrafiknat_1 src
WHERE
  net.route_id = src.route_id AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8);


-- Tätort
UPDATE nvdb_skane_network net
SET
  residential = TRUE
FROM nvdb_skane_tne_ft_tattbebyggtomrade_1 src
WHERE
  net.route_id = src.route_id AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8);



-- Väghållare
UPDATE nvdb_skane_network net
SET
  operator_type = src.vagha_6,
  operator_name = src.vagha_7
FROM nvdb_skane_tne_ft_vaghallare_1 src
WHERE
  net.route_id = src.route_id AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8);



-- Vägbredd
UPDATE nvdb_skane_network net
SET
  width = src.bredd_156
FROM nvdb_skane_tne_ft_vagbredd_1 src
WHERE
  net.route_id = src.route_id AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8);



-- Trafik
UPDATE nvdb_skane_network net
SET
  flow = src.adt_f_117,
  flow_id = src.avsni_119
FROM nvdb_skane_tne_ft_trafik_4 src
WHERE
  net.route_id = src.route_id AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8);



-- Slitlager
UPDATE nvdb_skane_network net
SET
  surface = src.slitl_152
FROM nvdb_skane_tne_ft_slitlager_1 src
WHERE
  net.route_id = src.route_id AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8);



-- Hastighetsgräns
UPDATE nvdb_skane_network net
SET
  max_speed = src.hogst_225
FROM nvdb_skane_tne_ft_hastighetsgrans_1 src
WHERE
  net.route_id = src.route_id AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8);

UPDATE nvdb_skane_network net
SET
  max_speed = CASE residential WHEN TRUE THEN 50 ELSE 70 END
WHERE
  road_type = 1 AND max_speed IS NULL




-- GCM typ
UPDATE nvdb_skane_network net
SET
  gcm_type = src.gcm_t_502
FROM nvdb_skane_tne_ft_gcm_vagtyp_1 src
WHERE
  net.route_id = src.route_id AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8);



-- Gatunamn
UPDATE nvdb_skane_network net
SET
  road_name = src.namn_130
FROM nvdb_skane_tne_ft_gatunamn_1 src
WHERE
  net.route_id = src.route_id AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8);



-- Trafik
UPDATE nvdb_skane_network net
SET
  road_class = src.klass_181
FROM nvdb_skane_tne_ft_funkvagklass_1 src
WHERE
  net.route_id = src.route_id AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8);



-- Bro och tunnel
UPDATE nvdb_skane_network net
SET
  grade_type = src.konst_190
FROM nvdb_skane_tne_ft_bro_och_tunnel_1 src
WHERE
  net.route_id = src.route_id AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8);


-- Driftsbidrag
UPDATE nvdb_skane_network net
SET
  subsidy = TRUE,
  subsidy_from_date = src.from_date,
  subsidy_to_date = src.to_date
FROM nvdb_skane_tne_ft_driftbidrag_statlig_116 src
WHERE
  net.route_id = src.route_id AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8);


-- Förbjuden färdriktning
UPDATE nvdb_skane_network net
SET
  oneway = src.direction
FROM nvdb_skane_tne_ft_forbjudenfardriktning_1 src
WHERE
  net.route_id = src.route_id AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8);


-- Förbud trafik
UPDATE nvdb_skane_network net
SET
  road_access = src.road_access
FROM (
  SELECT
    net.objectid,
    jsonb_agg(jsonb_build_object(
      'vehicle_deny', galle_447,
      'dest_allow', galle_453 = 10, -- 10: sant, 20: falskt
      'vehicle_allow', fordo_455_837,
      'activity_allow', verks_455_838,
      'direction', direction
    )) as road_access
  FROM nvdb_skane_tne_ft_forbudtrafik_1 src
  JOIN nvdb_skane_network net USING (route_id)
  WHERE round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8)
  GROUP BY net.objectid
) src
WHERE
  net.objectid = src.objectid;


-- Förbud cykel
UPDATE nvdb_skane_network net
SET
  bicycle_restrict = src.direction
FROM (
  SELECT
    net.objectid,
    max(src.direction) AS direction
  FROM nvdb_skane_tne_ft_forbudtrafik_1 src
  JOIN nvdb_skane_network net USING (route_id)
  WHERE
        src.galle_447 IN (30, 40)
    AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8)
  GROUP BY net.objectid
  HAVING 30 <> ALL(array_agg(src.fordo_455_837))
) src
WHERE
  net.objectid = src.objectid;


-- Motorväg
UPDATE nvdb_skane_network net
SET
  motorway = TRUE
FROM nvdb_skane_tne_ft_motorvag_1 src
WHERE
  net.route_id = src.route_id AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8);


-- Motortrafikled
UPDATE nvdb_skane_network net
SET
  motorroad = TRUE
FROM nvdb_skane_tne_ft_motortrafikled_1 src
WHERE
  net.route_id = src.route_id AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8);


-- Rekommenderad väg för cykel
UPDATE nvdb_skane_network net
SET
  bicycleroad = TRUE
FROM nvdb_skane_tne_ft_c_rekbilvagcykeltrafi_1 src
WHERE
  net.route_id = src.route_id AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8);


-- Cykelled
UPDATE nvdb_skane_network net
SET
  bicycle_route = src.namn_457
FROM nvdb_skane_tne_ft_c_cykelled_1 src
WHERE
  net.route_id = src.route_id AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8);


-- Färjeled
UPDATE nvdb_skane_network net
SET
  road_type = 8
FROM nvdb_skane_tne_ft_farjeled_1 src
WHERE
  net.route_id = src.route_id AND round(net.from_measure::numeric, 8) < round(src.to_measure::numeric, 8) AND round(net.to_measure::numeric, 8) > round(src.from_measure::numeric, 8);
