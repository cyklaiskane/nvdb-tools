set work_mem=16777216;
set max_parallel_workers_per_gather=2;

/*
varchar pgr_analyzeGraph(text edge_table, double precision tolerance,
                   text the_geom:='the_geom', text id:='id',
                   text source:='source',text target:='target',text rows_where:='true')

varchar pgr_createTopology(text edge_table, double precision tolerance,
                      text the_geom:='the_geom', text id:='id',
                      text source:='source',text target:='target',
                      text rows_where:='true', boolean clean:=false)
*/


SELECT pgr_createTopology('nvdb_skane_network', 0.1, 'geom', 'objectid', 'from_vertex', 'to_vertex', 'true', true);
