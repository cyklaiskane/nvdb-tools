#!/bin/bash

set -euxo pipefail

ogrinfo -ro -q 12_Skåne_län.gdb | while read i l t; do
  ogr2ogr -f PostgreSQL PG:"dbname=gis" 12_Skåne_län.gdb -nlt PROMOTE_TO_MULTI -nln nvdb_skane_$l $l -progress -overwrite --config PG_USE_COPY YES
done

for tbl in $(psql gis -qtc "select tablename from pg_catalog.pg_tables where schemaname = 'public' and tablename like 'nvdb_skane_tne_ft%';"); do
  echo $tbl
  psql gis -c "CREATE INDEX ${tbl}_route_id_index ON ${tbl} (route_id);"
done
