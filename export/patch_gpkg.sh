#!/bin/bash

[ ! -r "$1" ] && echo "GPKG file $1 not readable" >&2 && exit 1


sqlite3 "$1" <<EOF
create view bike_network as select * from network where road_type = 2;
insert into gpkg_contents (table_name, identifier, data_type, srs_id) values ('bike_network', 'bike_network', 'features', 3006);
insert into gpkg_geometry_columns (table_name, column_name, geometry_type_name, srs_id, z, m) values ('bike_network', 'geom', 'GEOMETRY', 3006, 0, 0);

create view road_network as select * from network where road_type = 1;
insert into gpkg_contents (table_name, identifier, data_type, srs_id) values ('road_network', 'road_network', 'features', 3006);
insert into gpkg_geometry_columns (table_name, column_name, geometry_type_name, srs_id, z, m) values ('road_network', 'geom', 'GEOMETRY', 3006, 0, 0);

create view bridges_tunnels as select * from network where grade_type is not null;
insert into gpkg_contents (table_name, identifier, data_type, srs_id) values ('bridges_tunnels', 'bridges_tunnels', 'features', 3006);
insert into gpkg_geometry_columns (table_name, column_name, geometry_type_name, srs_id, z, m) values ('bridges_tunnels', 'geom', 'GEOMETRY', 3006, 0, 0);

CREATE TABLE IF NOT EXISTS "layer_styles" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "f_table_catalog" TEXT(256),
  "f_table_schema" TEXT(256),
  "f_table_name" TEXT(256),
  "f_geometry_column" TEXT(256),
  "styleName" TEXT(30),
  "styleQML" TEXT,
  "styleSLD" TEXT,
  "useAsDefault" BOOLEAN,
  "description" TEXT,
  "owner" TEXT(30),
  "ui" TEXT(30),
  "update_time" DATETIME DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ','now'))
);
