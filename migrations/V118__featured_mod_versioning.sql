-- ALTER TABLE game_featuredMods_version DROP COLUMN git_branch;
ALTER TABLE game_featuredMods_version ADD COLUMN git_branch VARCHAR(40);

-- ALTER TABLE game_featuredMods_version DROP COLUMN display_name;
ALTER TABLE game_featuredMods_version ADD COLUMN display_name VARCHAR(40);

-- ALTER TABLE game_featuredMods DROP COLUMN install_package;
ALTER TABLE game_featuredMods ADD COLUMN install_package JSON;

-- ALTER TABLE game_featuredMods DROP COLUMN website;
ALTER TABLE game_featuredMods ADD COLUMN website VARCHAR(256);

-- UPDATE game_featuredMods SET install_package = '{}';

UPDATE game_featuredMods SET 
website = 'https://www.tauniverse.com/forum/showthread.php?t=46455',
git_branch = 'tacc',
install_package = '{"url":"https://www.tauniverse.com/forum/attachment.php?attachmentid=37173&d=1623362752"}' 
WHERE id = 1;

UPDATE game_featuredMods SET 
website = 'https://taesc.tauniverse.com',
git_branch = 'taesc',
install_package = '{
"url":"http://taesc.tauniverse.com/downloads/TAESC_GOLD_9_9_1.rar",
"folders": [
  {"regex":"Step_2[^/]*/(.*)"},
  {"regex":"Step_3.*/Windows 8 or 10/(.*)", "platforms":["win8", "win10"]},
  {"regex":"Step_3.*/Linux or Mac/(.*)", "platforms":["linux", "mac"]}
]}'
WHERE id = 3;

UPDATE game_featuredMods SET
website = 'https://zero.tauniverse.com',
git_branch = 'tazero',
install_package = '{
"url": "http://zero.tauniverse.com/downloads/TA_Zero_Base.zip;http://zero.tauniverse.com/downloads/TA_Zero_Alpha_4d.zip", 
"folders": [
  {"regex": "TA Zero/(.*)"}, 
  {"regex": "([^/]+)"}, 
  {"regex": "TA Zero Alpha 4d Fixes/Fix 10/(.*)", "platforms": ["win8", "win10"]}
]}' WHERE id = 4;

UPDATE game_featuredMods SET website = 'https://mayhem.tauniverse.com', git_branch = 'tamayhem', install_package = '{"url":"https://mayhem.tauniverse.com/totalm/TotalM824e.zip"}' WHERE id = 5;
UPDATE game_featuredMods SET website = 'https://www.tauniverse.com/forum/showthread.php?t=46670', git_branch = 'tavmod', install_package = '{"url":"https://prota.tauniverse.com/ProTA4.4.zip"}' WHERE id = 6;
UPDATE game_featuredMods SET website = 'https://twilight.tauniverse.com', git_branch = 'tatw', install_package = '{"url":"https://www.tauniverse.com/forum/attachment.php?attachmentid=37173&d=1623362752"}' WHERE id = 7;

UPDATE game_featuredMods_version SET git_branch = 'taesc-9.86', display_name = '9.8.6' WHERE id = 4;
UPDATE game_featuredMods_version SET git_branch = 'taesc-9.90', display_name = '9.9.0' WHERE id = 625;
UPDATE game_featuredMods_version SET git_branch = 'taesc-9.91', display_name = '9.9.1' WHERE id = 1731;
UPDATE game_featuredMods_version SET git_branch = 'tavmod-4.3', display_name = '4.3' WHERE id = 2;
UPDATE game_featuredMods_version SET git_branch = 'tavmod-4.4', display_name = '4.4' WHERE id = 2508;
UPDATE game_featuredMods_version SET git_branch = 'tacc-3.9.02', display_name = '3.9.02', comment = 'CC+flea+scarab+hhog+immo+fark+necro' WHERE id = 8;
UPDATE game_featuredMods_version SET git_branch = 'tacc-3.9.02', display_name = '3.9.02', comment = 'CC+flea+scarab+hhog+immo+fark+necro+QFluxor' WHERE id = 20;
UPDATE game_featuredMods_version SET git_branch = 'tamayhem-8.1.5', display_name = '8.1.5' WHERE id = 57;
UPDATE game_featuredMods_version SET git_branch = 'tatw-2.0b52', display_name = '2.0 beta 52' WHERE id = 36;
