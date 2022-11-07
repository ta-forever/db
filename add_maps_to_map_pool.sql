select * from map_pool;
tavmod_1v1 = 2;
tavmod_2v2 = 8;
tamayhem 1v1 = 6;
tamayhem 2v2 = 12;

select * from map_version where filename like '[Pro] %';

select * from map_pool_map_version;

insert into map_pool_map_version (map_pool_id, map_version_id, weight)
select 12, id, 1 from map_version where filename like '[Pro] %';
