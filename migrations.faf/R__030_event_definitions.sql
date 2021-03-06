-- Repeatable migration: Flyway will replay this SQL every time this file (checksum) has changed!
-- You can not delete items by removing them from this file! Also make sure never to edit or reuse existing ids!

-- If you want to edit an existing or add a new event, just append it to the SQL command and run flyway migrate.
-- Matching achievement definitions and their logic need to be hardcoded into the lobby server.
-- A list of all events is held here: https://github.com/FAForever/server/blob/develop/server/stats/event_service.py

INSERT INTO `event_definitions` (id, name_key, image_url, type) VALUES
('15b6c19a-6084-4e82-ada9-6c30e282191f','event.seraphimWins',NULL,'NUMERIC'),
('1b900d26-90d2-43d0-a64e-ed90b74c3704','event.uefPlays',NULL,'NUMERIC'),
('225e9b2e-ae09-4ae1-a198-eca8780b0fcd','event.lostAirUnits',NULL,'NUMERIC'),
('3a7b3667-0f79-4ac7-be63-ba841fd5ef05','event.lostNavalUnits',NULL,'NUMERIC'),
('3dd3ed78-ce78-4006-81fd-10926738fbf3','event.lostTech1Units',NULL,'NUMERIC'),
('3ebb0c4d-5e92-4446-bf52-d17ba9c5cd3c','event.builtAirUnits',NULL,'NUMERIC'),
('4a929def-e347-45b4-b26d-4325a3115859','event.ranked1v1GamesPlayed',NULL,'NUMERIC'),
('56b06197-1890-42d0-8b59-25e1add8dc9a','event.cybranWins',NULL,'NUMERIC'),
('60bb1fc0-601b-45cd-bd26-83b1a1ac979b','event.builtEngineers',NULL,'NUMERIC'),
('701ca426-0943-4931-85af-6a08d36d9aaa','event.lostExperimentals',NULL,'NUMERIC'),
('7be6fdc5-7867-4467-98ce-f7244a66625a','event.uefWins',NULL,'NUMERIC'),
('7f15c2be-80b7-4573-8f41-135f84773e0f','event.lostTech3Units',NULL,'NUMERIC'),
('89d4f391-ed2d-4beb-a1ca-6b93db623c04','event.builtTech2Units',NULL,'NUMERIC'),
('92617974-8c1f-494d-ab86-65c2a95d1486','event.builtTech3Units',NULL,'NUMERIC'),
('96ccc66a-c5a0-4f48-acaa-888b00778b57','event.aeonPlays',NULL,'NUMERIC'),
('a1a3fd33-abe2-4e56-800a-b72f4c925825','event.lostLandUnits',NULL,'NUMERIC'),
('a6b51c26-64e6-4e7a-bda7-ea1cfe771ebb','event.aeonWins',NULL,'NUMERIC'),
('a8ee4f40-1e30-447b-bc2c-b03065219795','event.builtTech1Units',NULL,'NUMERIC'),
('ad193982-e7ca-465c-80b0-5493f9739559','event.cybranPlays',NULL,'NUMERIC'),
('aebd750b-770b-4869-8e37-4d4cfdc480d0','event.lostTech2Units',NULL,'NUMERIC'),
('b5265b42-1747-4ba1-936c-292202637ce6','event.builtNavalUnits',NULL,'NUMERIC'),
('cc791f00-343c-48d4-b5b3-8900b83209c0','event.secondsPlayed',NULL,'TIME'),
('cfa449a6-655b-48d5-9a27-6044804fe35c','event.customGamesPlayed',NULL,'NUMERIC'),
('d6a699b7-99bc-4a7f-b128-15e1e289a7b3','event.lostAcus',NULL,'NUMERIC'),
('e8e99a68-de1b-4676-860d-056ad2207119','event.lostEngineers',NULL,'NUMERIC'),
('ea123d7f-bb2e-4a71-bd31-88859f0c3c00','event.builtLandUnits',NULL,'NUMERIC'),
('ed9fd79d-5ec7-4243-9ccf-f18c4f5baef1','event.builtExperimentals',NULL,'NUMERIC'),
('fefcb392-848f-4836-9683-300b283bc308','event.seraphimPlays',NULL,'NUMERIC')
-- add new row above this comment (don't forget to append the comma to the previous one)
ON DUPLICATE KEY UPDATE
    name_key=VALUES(name_key),
    image_url=VALUES(image_url),
    type=VALUES(type);
