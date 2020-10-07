set work_mem=16777216;
set max_parallel_workers_per_gather=2;

DROP TABLE IF EXISTS nvdb_skane_network;
DROP SEQUENCE IF EXISTS nvdb_skane_network_objectid_seq;

CREATE SEQUENCE nvdb_skane_network_objectid_seq;

CREATE TABLE nvdb_skane_network (
  objectid integer NOT NULL DEFAULT nextval('nvdb_skane_network_objectid_seq'),
  route_id character varying(38) COLLATE pg_catalog."default",
  from_measure double precision,
  to_measure double precision,
  road_type smallint,
  operator_type smallint,
  operator_name character varying,
  width double precision,
  flow integer,
  flow_id integer,
  surface smallint,
  max_speed smallint,
  gcm_type smallint,
  road_name character varying,
  road_class smallint,
  ts_class smallint,
  grade_type smallint,
  subsidy boolean DEFAULT FALSE,
  subsidy_from_date integer,
  subsidy_to_date integer,
  road_access jsonb,
  bicycle_restrict integer,
  bicycle_route character varying,
  oneway smallint,
  motorway boolean DEFAULT FALSE,
  motorroad boolean DEFAULT FALSE,
  bicycleroad boolean DEFAULT FALSE,
  residential boolean DEFAULT FALSE,
  from_vertex integer,
  to_vertex integer,
  geom geometry(LineString, 3006),
  CONSTRAINT nvdb_skane_network_pkey PRIMARY KEY (objectid)
);

ALTER SEQUENCE nvdb_skane_network_objectid_seq OWNED BY nvdb_skane_network.objectid;
SELECT setval('nvdb_skane_network_objectid_seq', (SELECT max(objectid) + 1 FROM nvdb_skane_tne_reflinkpart));

INSERT INTO nvdb_skane_network (geom, objectid, route_id, from_measure, to_measure)
SELECT
  ST_Transform(ST_LineMerge(ST_Force2D(net.wkb_geometry)), 3006) as geom,
  net.objectid,
  net.reflink_oid,
  net.from_measure,
  net.to_measure
FROM nvdb_skane_tne_reflinkpart net;
--LIMIT 10000;
--WHERE net.reflink_oid NOT IN (SELECT DISTINCT route_id FROM "nvdb_skane_tne_ft_farjeled_1");

CREATE INDEX nvdb_skane_network_route_id_idx ON nvdb_skane_network (route_id);
