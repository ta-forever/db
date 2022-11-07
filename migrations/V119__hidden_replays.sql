ALTER TABLE game_stats ADD COLUMN replay_hidden BOOLEAN DEFAULT FALSE;

DROP TRIGGER IF EXISTS faf.map_play_count;
DELIMITER $$
$$
CREATE DEFINER=`root`@`localhost` TRIGGER map_play_count AFTER INSERT ON faf.game_stats FOR EACH ROW
BEGIN
	IF NEW.mapId IS NOT NULL THEN
		INSERT INTO table_map_features(map_id,voters,times_played)
		VALUES (NEW.mapId, '', 1)
		ON DUPLICATE KEY UPDATE times_played = (times_played +1);
	END IF;
END$$
DELIMITER ;
