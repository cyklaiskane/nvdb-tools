# NVDB tools

This repository contains various scripts, templates, and styles to process and classify NVDB data.

## Prerequisites

- NVDB homogenized GDB file for Skåne county from Lastkajen (Trafikverket), including all data products listed in the FME workspace cyklaiskane.fmw.
- NVDB shapefile with data product Traffic from Lastkajen (Trafikverket,see FME workspace for more details).
- SCB "Tätorter" Shapefile, including population information for each city.
- "Sommar dygnstrafik XLSX" file from Trafikverket with information to convert ÅDT (årsdygnstrafik) to SDT (sommardygnstrafik).
- GDAL tools
  - ogrinfo
  - ogr2ogr
- PostgreSQL 11+ / PostGIS 3
- FME
- SQLite3

## Usage


### Import

Import script and templates can be found in the `import/` directory. The scripts assumes that you have a local PostgreSQL database named `gis` with the PostGIS 3.0 extension. First import the NVDB GDB file by running `./import_stage0.sh`. This copies all features into the PostGIS database and applies an index to the `route_id` column.

Run `./import.sh` to modify the geometries and apply the required attributes.


### Classify

The classifier is implemented as a FME script. The input data to the FME script must first be exported from the PostGIS database using the `export/export.sh` shell script which produces a GeoPackage file named `nvdb_skane_network.gpkg` with two tables: `network` and `network_vertices`.

To classify the road network point the GPKG reader to the exported network file and run. The result will be saved as `cyklaiskane.gpkg`. This file can be viewed in QGIS. The supplied SLD file `styles/cyklaiskane_simple.sld` can be used to see the different road safety classes and other attributes.
