# NVDB tools - import

## Windows

### Krav

Kräver Docker CE som kan hämtas från https://hub.docker.com/editions/community/docker-ce-desktop-windows/

### Installera och köra

Kör följande i ett PowerShell.

```shell
cd \
mkdir Code
cd Code
git clone https://github.com/cyklaiskane/nvdb-tools.git
cd nvdb-tools\import
docker run --rm -it --name pgr -p 5432:5432 -e POSTGRES_PASSWORD=foobar -e POSTGRES_DB=gis -v "C:\Code\nvdb-tools\import":/data pgrouting/pgrouting:11-3.0-3.0.1
```

Detta startar en temporär PostgreSQL-instans som hålls igång så länge PowerShell-fönstret är öppet. Vill man ha en bestående instans så kan man ta bort parametern `--rm`. För att köra instansen i "bakgrunden" kan man lägga till `-d` när Docker-instansen skapas. Ex:

```shell
docker run -itd --name pgr -p 5432:5432 -e POSTGRES_PASSWORD=foobar -e POSTGRES_DB=gis -v "C:\Code\nvdb-tools\import":/data pgrouting/pgrouting:11-3.0-3.0.1
```

Kontrollera att PostgreSQL är igång genom att köra `docker ps` i ett PowerShell-fönster. Har du tidigare skapat/startat en bestående instans som är avstängd kan denna startas med `docker start pgr`.

Ladda ner Skåne GeoDB länsfil från Lastkajen. Hitta på Fillager -> Vägdata -> Län File GeoDb. Hämta ner 12_Skåne_län.zip. Packa upp zip filen och flytta katalogen `12_Skåne_län.gdb` till `C:\Code\nvdb-tools\import`.

Öppna ett till PowerShell fönster och kör följande:

```shell
docker exec -it pgr bash
cd /data
PGUSER=postgres psql gis
create extension postgis;
create extension pgrouting;
exit
```

Databasen är nu förberedd för att hantera geodata. Nu kan följande kommandon köras.

```shell
apt update
apt install -y gdal-bin
PGUSER=postgres ./import_stage0.sh
PGUSER=postgres ./import.sh
```

Data från GeoDB-filen bör nu vara importerad till databasen och förberedd för att exporteras till OSM-format m.h.a. _pgr2osm_.
