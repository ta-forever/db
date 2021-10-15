delete from map_pool_map_version;
delete from matchmaker_queue_map_pool;
delete from matchmaker_queue;
delete from leaderboard where id > 2;

update leaderboard set technical_name="ladder1v1", name_key="leaderboard.ladder1v1_tacc.name", description_key="leaderboard.ladder1v1_tacc.desc" where technical_name="ladder1v1";

insert into leaderboard (id, technical_name, name_key, description_key)
values (3, "ladder1v1_tavmod", "leaderboard.ladder1v1_tavmod.name", "leaderboard.ladder1v1_tavmod.desc"),
       (4, "ladder1v1_taesc", "leaderboard.ladder1v1_taesc.name", "leaderboard.ladder1v1_taesc.desc"),
       (5, "ladder1v1_tatw", "leaderboard.ladder1v1_tatw.name", "leaderboard.ladder1v1_tatw.desc"),
       (6, "ladder1v1_tazero", "leaderboard.ladder1v1_tazero.name", "leaderboard.ladder1v1_tazero.desc"),
       (7, "ladder1v1_tamayhem", "leaderboard.ladder1v1_tamayhem.name", "leaderboard.ladder1v1_tamayhem.desc"),
       (8, "ladder2v2_tacc", "leaderboard.ladder2v2_tacc.name", "leaderboard.ladder2v2_tacc.desc"),
       (9, "ladder2v2_tavmod", "leaderboard.ladder2v2_tavmod.name", "leaderboard.ladder2v2_tavmod.desc"),
       (10, "ladder2v2_taesc", "leaderboard.ladder2v2_taesc.name", "leaderboard.ladder2v2_taesc.desc");

insert into matchmaker_queue (id, technical_name, featured_mod_id, leaderboard_id, name_key, team_size)
values (1, "ladder1v1_tacc", 1, 2, "matchmaker.ladder1v1", 1),
       (2, "ladder1v1_tavmod", 6, 3, "matchmaker.ladder1v1_tavmod", 1),
       (3, "ladder1v1_taesc", 3, 4, "matchmaker.ladder1v1_taesc", 1),
       (4, "ladder1v1_tatw", 7, 5, "matchmaker.ladder1v1_tatw", 1),
       (5, "ladder1v1_tazero", 4, 6, "matchmaker.ladder1v1_tazero", 1),
       (6, "ladder1v1_tamayhem", 5, 7, "matchmaker.ladder1v1_tamayhem", 1),
       (7, "ladder2v2_tacc", 1, 8, "matchmaker.ladder2v2_tacc", 2),
       (8, "ladder2v2_tavmod", 6, 9, "matchmaker.ladder2v2_tavmod", 2),
       (9, "ladder2v2_taesc", 3, 10, "matchmaker.ladder2v2_taesc", 2);

update map_pool set name = "tacc 1v1" where id=1;
insert into map_pool (id, name)
values
(2, "tavmod 1v1"),
(3, "taesc 1v1"),
(4, "tatw 1v1"),
(5, "tazero 1v1"),
(6, "tamayhem 1v1"),
(7, "tacc 2v2"),
(8, "tavmod 2v2"),
(9, "taesc 2v2");

insert into matchmaker_queue_map_pool (matchmaker_queue_id, map_pool_id, min_rating, max_rating)
values
(1, 1, NULL, NULL),
(2, 2, NULL, NULL),
(3, 3, NULL, NULL),
(4, 4, NULL, NULL),
(5, 5, NULL, NULL),
(6, 6, NULL, NULL),
(7, 7, NULL, NULL),
(8, 8, NULL, NULL),
(9, 9, NULL, NULL);

insert into oauth_clients (id,name,client_secret, client_type,redirect_uris,default_redirect_uri,default_scope)
values(
"05209670-36c5-40ad-b581-e71b7b49bd1a",
"TAF Moderator Client",
"{noop}370965a5-e7f2-4fe1-9225-e4517476b6a5",
"public",
"http://localhost https://www.getpostman.com/oauth2/callback",
"https://www.getpostman.com/oauth2/callback",
"read_events read_achievements upload_map upload_mod write_account_data administrative_actions"
);
 