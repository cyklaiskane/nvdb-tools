#!/bin/bash

set -euxo pipefail

psql gis < nvdb_import_stage1.sql

for tbl in $(sed -n 's/.*\(nvdb_skane_tne_ft_\w*\).*/\1/p' nvdb_import_stage3.sql); do
  echo $tbl
  ./templater.sh nvdb_import_stage2.template.sql  net_table=nvdb_skane_network src_table=${tbl} | psql gis
done

psql gis < nvdb_import_stage3.sql
psql gis < nvdb_import_stage4.sql
