insert into map_pool_map_version (map_pool_id, map_version_id, weight, map_params)
select (select id from map_pool where name = 'tamayhem 2v2'), t.map_version_id, t.weight, t.map_params
from map_pool_map_version t
where t.map_pool_id = (select id from map_pool where name = 'tavmod 2v2');