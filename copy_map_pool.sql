insert into map_pool_map_version (map_pool_id, map_version_id, weight, map_params)
select 8, t.map_version_id, t.weight, t.map_params
from map_pool_map_version t
where t.map_pool_id = 2;