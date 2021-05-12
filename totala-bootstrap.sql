-- DUMMY DATA ONLY, FOR USE IN UNIT TESTS

GRANT ALL PRIVILEGES ON `postal-%` . * to `faf-postal`  IDENTIFIED BY "banana";
GRANT ALL ON `faf-postal` . * to `faf-postal`  IDENTIFIED BY "banana";

SET FOREIGN_KEY_CHECKS=0;

DELETE FROM player_events;
DELETE FROM reported_user;
DELETE FROM moderation_report;
DELETE FROM teamkills;
DELETE FROM unique_id_users;
DELETE FROM uniqueid;
DELETE FROM global_rating;
DELETE FROM ladder1v1_rating;
DELETE FROM uniqueid_exempt;
DELETE FROM version_lobby;
DELETE FROM friends_and_foes;
DELETE FROM ladder_map;
DELETE FROM tutorial;
DELETE FROM map_version_review;
DELETE FROM map_version_reviews_summary;
DELETE FROM map_version;
DELETE FROM `map`;
DELETE FROM coop_map;
DELETE FROM mod_version_review;
DELETE FROM mod_version_reviews_summary;
DELETE FROM mod_version;
DELETE FROM `mod`;
DELETE FROM mod_stats;
DELETE FROM oauth_clients;
DELETE FROM updates_faf;
DELETE FROM updates_faf_files;
DELETE FROM avatars;
DELETE FROM avatars_list;
DELETE FROM ban;
DELETE FROM clan_membership;
DELETE FROM clan;
DELETE FROM game_player_stats;
DELETE FROM game_review;
DELETE FROM game_reviews_summary;
DELETE FROM game_stats;
DELETE FROM game_featuredMods;
DELETE FROM ladder_division_score;
DELETE FROM ladder_division;
DELETE FROM lobby_admin;
DELETE FROM name_history;
DELETE FROM user_group_assignment;
DELETE FROM login;
DELETE FROM email_domain_blacklist;
DELETE FROM leaderboard;
DELETE FROM matchmaker_queue;
DELETE FROM matchmaker_queue_map_pool;
DELETE FROM map_pool;
DELETE FROM map_pool_map_version;

SET FOREIGN_KEY_CHECKS=1;

-- Login table
-- Most accounts get a creation time in the past so that they pass account
-- age check.
insert into login (id, login, email, password, create_time) values (1, 'TheCoreCommander', 'me@here.com', SHA2('ananab', 256), '2000-01-01 00:00:00');
insert into login (id, login, email, password, create_time) values (2, 'TheArmCommander', 'you@there.com', SHA2('ananab', 256), '2000-01-01 00:00:00');


-- Permissions
insert into lobby_admin (user_id, `group`) values (1,2);
insert into user_group_assignment(user_id, group_id)  values (1, (SELECT id from user_group WHERE technical_name = 'faf_server_administrators'));
insert into user_group_assignment(user_id, group_id)  values (2, (SELECT id from user_group WHERE technical_name = 'faf_moderators_global'));

-- UniqueID_exempt
insert into uniqueid_exempt (user_id, reason) values (1, 'Because test');
insert into uniqueid_exempt (user_id, reason) values (2, 'Because test');

-- Sample maps
insert into map (id, display_name, map_type, battle_type, author)
values
(1, 'Full Moon', 'FFA', 'skirmish', 1),
(2, 'Gods of War', 'FFA', 'skirmish', 1),
(3, 'Hundred Isles', 'FFA', 'skirmish', 1),
(4, 'Painted Desert', 'FFA', 'skirmish', 1),
(5, 'Red Hot Lava', 'FFA', 'skirmish', 1),
(6, 'Red Planet', 'FFA', 'skirmish', 2),
(7, 'SHERWOOD', 'FFA', 'skirmish', 2),
(8, 'The Cold Place', 'FFA', 'skirmish', 2),
(9, 'The Desert Triad', 'FFA', 'skirmish', 2),
(10, 'Acid Foursome', 'FFA', 'skirmish', 1),
(11, 'Cluster Freak', 'FFA', 'skirmish', 1),
(12, 'Comet Catcher', 'FFA', 'skirmish', 1),
(13, 'Crystal Maze', 'FFA', 'skirmish', 2),
(14, 'Gasplant Plain', 'FFA', 'skirmish', 2),
(15, 'Show Down', 'FFA', 'skirmish', 2);

insert into map_version (id, description, max_players, width, height, version, filename, hidden, map_id)
values
(1, 'Full Moon', 8, 1024, 1024, 1, 'totala2.hpi/Full Moon/541fdd03', 0, 1),
(2, 'Gods of War', 8, 1024, 1024, 1, 'totala2.hpi/Gods of War/5a282a18', 0, 2),
(3, 'Hundred Isles', 8, 1024, 1024, 1, 'totala2.hpi/Hundred Isles/96664f75', 0, 3),
(4, 'Painted Desert', 8, 1024, 1024, 1, 'totala2.hpi/Painted Desert/694141de', 0, 4),
(5, 'Red Hot Lava', 8, 2048, 2048, 1, 'totala2.hpi/Red Hot Lava/338dce04', 0, 5),
(6, 'Red Planet', 8, 2048, 2048, 1, 'totala2.hpi/Red Planet/2d831ef0', 0, 6),
(7, 'SHERWOOD', 8, 1024, 1024, 1, 'totala2.hpi/SHERWOOD/ead82fc5', 0, 7),
(8, 'The Cold Place', 8, 512, 512, 1, 'totala2.hpi/The Cold Place/6686cdb3', 0, 8),
(9, 'The Desert Triad', 8, 1024, 1024, 1, 'totala2.hpi/The Desert Triad/82444122', 0, 9),
(10, 'Acid Foursome', 8, 1024, 1024, 1, 'ccmaps.ccx/Acid Foursome/56ae733e', 0, 10),
(11, 'Cluster Freak', 8, 1024, 1024, 1, 'ccmaps.ccx/Cluster Freak/0c83e43a', 0, 11),
(12, 'Comet Catcher', 8, 1024, 1024, 1, 'ccmaps.ccx/Comet Catcher/40ca6cb3', 0, 12),
(13, 'Crystal Maze', 8, 2048, 2048, 1, 'ccmaps.ccx/Crystal Maze/ca7321f7', 0, 13),
(14, 'Gasplant Plain', 8, 256, 256, 1, 'ccmaps.ccx/Gasplant Plain/55bcc5a6', 0, 14),
(15, 'Show Down', 8, 256, 256, 1, 'ccmaps.ccx/Show Down/5a2bed13', 0, 15);

insert into ladder_map (id, idmap) values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(13,13),
(14,14),
(15,15);

INSERT INTO `coop_map` (`type`, `name`, `description`, `version`, `filename`)
VALUES (0, 'Arm OTA Campaign map', 'A map from the OTA Arm campaign', 0, 'maps/ota_coop_arm.ufo'),
       (1, 'Core OTA Campaign map', 'A map from the OTA Arm campaign', 0, 'maps/ota_coop_core.ufo'),
       (0, 'Arm CC Campaign map', 'A map from the CC Arm campaign', 0, 'maps/cc_coop_arm.ufo'),
       (1, 'Core CC Campaign map', 'A map from the CC Core campaign', 0, 'maps/cc_coop_core.ufo'),
       (0, 'Arm BT Campaign map', 'A map from the BT Arm campaign', 0, 'maps/bt_coop_arm.ufo'),
       (1, 'Core BT Campaign map', 'A map from the BT Core campaign', 0, 'maps/bt_coop_core.ufo');


insert into game_featuredMods (id, gamemod, name, description, publish, git_url, git_branch, file_extension, allow_override)
values (1, 'tacc', 'TA:Core Contingency', 'Total Annihilation: Core Contingency', 1, 'https://github.com/TAForever/tacc.git', 'deploy/taf', 'hpi', FALSE),
       (2, 'ladder1v1', 'ladder1v1', 'Total Annihilation: Core Contingency (Ladder 1v1)', 0, 'https://github.com/TAForever/tacc.git', 'deploy/taf', 'hpi', TRUE),
       (3, 'taesc', 'TA:Escalation', 'Total Annihilation: Escalation', 1, 'https://github.com/TAForever/esc.git', 'deploy/taf', 'hpi', FALSE),
       (4, 'tazero', 'TA:Zero', 'Total Annihilation: Zero', 1, 'https://github.com/TAForever/zero.git', 'deploy/taf', 'hpi', FALSE),
       (5, 'tamayhem', 'TA:Mayhem', 'Total Annihilation: Mayhem', 1, 'https://github.com/TAForever/mayhem.git', 'deploy/taf', 'hpi', FALSE),
       (6, 'tavmod', 'VMod', 'Total Annihilation: VMod', 1, 'https://github.com/TAForever/vmod.git', 'deploy/taf', 'hpi', FALSE),
       (7, 'twilight', 'TA:Twilight', 'Total Annihilation: VMod', 1, 'https://github.com/TAForever/vmod.git', 'deploy/taf', 'hpi', FALSE);

insert into leaderboard (id, technical_name, name_key, description_key)
values (1, "global", "leaderboard.global.name", "leaderboard.global.desc"),
       (2, "ladder1v1_tacc", "leaderboard.ladder1v1_tacc.name", "leaderboard.ladder1v1_tacc.desc"),
       (3, "ladder1v1_taesc", "leaderboard.ladder1v1_taesc.name", "leaderboard.ladder1v1_taesc.desc"),
       (4, "ladder1v1_tazero", "leaderboard.ladder1v1_tazero.name", "leaderboard.ladder1v1_tazero.desc"),
       (5, "ladder1v1_tamayhem", "leaderboard.ladder1v1_tamayhem.name", "leaderboard.ladder1v1_tamayhem.desc"),
       (6, "ladder1v1_tavmod", "leaderboard.ladder1v1_tavmod.name", "leaderboard.ladder1v1_tavmod.desc"),
       (7, "ladder1v1_twilight", "leaderboard.ladder1v1_twilight.name", "leaderboard.ladder1v1_twilight.desc");

insert into matchmaker_queue (id, technical_name, featured_mod_id, leaderboard_id, name_key)
values (1, "ladder1v1_tacc", 1, 2, "matchmaker.queue.ladder1v1_tacc"),
       (2, "ladder1v1_taesc", 3, 3, "matchmaker.queue.ladder1v1_taesc"),
       (3, "ladder1v1_tazero", 4, 4, "matchmaker.queue.ladder1v1_tazero"),
       (4, "ladder1v1_tamayhem", 5, 5, "matchmaker.queue.ladder1v1_tamayhem"),
       (5, "ladder1v1_tavmod", 6, 6, "matchmaker.queue.ladder1v1_tavmod"),
       (6, "ladder1v1_twilight", 7, 7, "matchmaker.queue.ladder1v1_twilight");

insert into map_pool (id, name)
values (1, "Ladder1v1 season 1");

insert into map_pool_map_version (map_pool_id, map_version_id)
values
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(1,8),
(1,9),
(1,10),
(1,11),
(1,12),
(1,13),
(1,14),
(1,15);


insert into matchmaker_queue_map_pool (matchmaker_queue_id, map_pool_id, min_rating, max_rating)
values
(1, 1, NULL, NULL),
(2, 1, NULL, NULL);


-- sample avatars
insert into avatars_list (id, filename, tooltip) values
  (1, 'core.png', 'CORE'),
  (2, 'arm.png', 'ARM');

insert into avatars (idUser, idAvatar, selected) values (1, 1, 1), (2, 2, 1);


-- sample oauth_client for Postman
insert into oauth_clients (id, name, client_secret, redirect_uris, default_redirect_uri, default_scope) VALUES
  ('3bc8282c-7730-11e5-8bcf-feff819cdc9f ', 'Downlord''s TAF Client', '{noop}6035bd78-7730-11e5-8bcf-feff819cdc9f', '', '', 'read_events read_achievements upload_map'),
  ('faf-website', 'faf-website', '{noop}banana', 'http://localhost:8020 https://www.taforever.com/callback', 'http://localhost:8020 https://www.taforever.com/callback', 'public_profile write_account_data create_user'),
  ('postman', 'postman', '{noop}postman', 'http://localhost https://www.getpostman.com/oauth2/callback', 'https://www.getpostman.com/oauth2/callback', 'read_events read_achievements upload_map upload_mod write_account_data');

insert into updates_faf (id, filename, path) values
    (1, 'totala.exe', '.'),
    (2, 'taf.hpi', '.');

insert into updates_faf_files (id, fileId, version, name, md5, obselete) values
    (1, 1, 392, 'totala_3.9.02.exe', 'df08c41ea3e508a0debb6bfb16af1e5e', 0),
    (2, 1, 931, 'totala_esc_9.3.1.exe', '86dffdc0f69359d4027d9c2e74668210', 0);

INSERT INTO ladder_division VALUES
(1, 'League 1 - Division A', 1, 10.0),
(2, 'League 1 - Division B', 1, 30.0),
(3, 'League 1 - Division C', 1, 50.0),
(4, 'League 2 - Division D', 2, 20.0),
(5, 'League 2 - Division E', 2, 60.0),
(6, 'League 2 - Division F', 2, 100.0),
(7, 'League 3 - Division D', 3, 100.0),
(8, 'League 3 - Division E', 3, 200.0),
(9, 'League 3 - Division F', 3, 9999.0);
