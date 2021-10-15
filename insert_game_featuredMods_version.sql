INSERT INTO game_featuredMods_version (game_featuredMods_id, version, ta_hash, confirmed)
VALUES
((select id from game_featuredMods where gamemod = 'tavmod'), '4.3', '4.3', 1),
((select id from game_featuredMods where gamemod = 'tavmod'), '4.3', '022871225a7fd5e3b97bda2ad73899a9', 1),
((select id from game_featuredMods where gamemod = 'taesc'), '9.86', '9.86', 1),
((select id from game_featuredMods where gamemod = 'taesc'), '9.86', 'e882ee9fc9d2e361612aa8e4cf53a52b', 1);