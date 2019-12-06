#!/bin/bash

ogr2ogr -f GPKG nvdb_skane_network.gpkg PG:"dbname=gis" nvdb_skane_network -nln network -overwrite -progress
ogr2ogr -f GPKG nvdb_skane_network.gpkg PG:"dbname=gis" nvdb_skane_network_vertices_pgr -nln vertices -overwrite -progress
