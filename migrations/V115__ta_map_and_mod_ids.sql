ALTER TABLE map_version
    ADD COLUMN ta_hash VARCHAR(8) COMMENT 'Hash code assigned by TotalA.exe',
    ADD INDEX (ta_hash);

CREATE TABLE `game_featuredMods_version` (
    id MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    game_featuredMods_id TINYINT(3) UNSIGNED NOT NULL,
    version VARCHAR(10) NOT NULL,
    ta_hash VARCHAR(32) COMMENT 'Hash code based on units CRCs assigned by TotalA.exe',
    confirmed BOOLEAN DEFAULT FALSE COMMENT 'Set if the mod/version/ta_hash combination is considered a confirmed fact',
    observation_count INTEGER UNSIGNED DEFAULT 0 COMMENT 'Number of games observed with this mod/version/ta_hash combination',
    INDEX (`game_featuredMods_id`,`ta_hash`),
    UNIQUE (game_featuredMods_id, version, ta_hash),
    CONSTRAINT FOREIGN KEY (`game_featuredMods_id`) REFERENCES `game_featuredMods` (`id`)
);

INSERT INTO game_featuredMods_version (game_featuredMods_id, version, ta_hash, confirmed)
VALUES
((select id from game_featuredMods where gamemod = 'tavmod'), '4.3', '4.3', 1),
((select id from game_featuredMods where gamemod = 'tavmod'), '4.3', '022871225a7fd5e3b97bda2ad73899a9', 1),
((select id from game_featuredMods where gamemod = 'taesc'), '9.86', '9.86', 1),
((select id from game_featuredMods where gamemod = 'taesc'), '9.86', 'e882ee9fc9d2e361612aa8e4cf53a52b', 1);

CREATE TEMPORARY TABLE sorted_lrj
SELECT
    IF(@prev_lid = c.lid AND @prev_pid = c.pid AND (@cumstreak*c.score >= 0),
        @cumstreak := @cumstreak + c.score,
        @cumstreak := c.score
        ) AS streak,
    IF(@prev_lid = c.lid AND @prev_pid = c.pid,
        @cumlast10 := SUBSTR(CONCAT(CONVERT(c.score+1,CHAR),@cumlast10),1,10),
        @cumlast10 := CONVERT(c.score+1,CHAR)
        ) AS recent_scores,
    c.id,
    @prev_lid := c.lid  AS `lid`,
    @prev_pid := c.pid AS `pid`,
    @prev_score := c.score AS `score`
FROM (
    SELECT
        @prev_lid  := NULL,
        @prev_pid := NULL,
        @prev_score := NULL,
        @cumstreak := 0,
        @cumlast10 := ''
) i
JOIN (
    SELECT lrj.id id, lrj.leaderboard_id lid, gps.playerId pid, gps.score score
    FROM leaderboard_rating_journal lrj
    JOIN game_player_stats gps on gps.id = lrj.game_player_stats_id
    ORDER BY lrj.leaderboard_id, gps.playerId, lrj.update_time ASC
) c;

CREATE TEMPORARY TABLE id_max
SELECT MAX(id)
FROM sorted_lrj
GROUP BY lid, pid;

ALTER TABLE leaderboard_rating
    ADD COLUMN streak SMALLINT,
    ADD COLUMN recent_scores VARCHAR(10) COMMENT '0=loss, 1=draw, 2=win.  most recent first',
    ADD COLUMN recent_mod VARCHAR(10);

UPDATE leaderboard_rating lr
INNER JOIN (
	SELECT *
	FROM sorted_lrj
	WHERE id IN (SELECT * FROM id_max)
) upd on upd.lid = lr.leaderboard_id AND upd.pid = lr.login_id
SET
	lr.streak = upd.streak,
	lr.recent_scores = upd.recent_scores;

DROP TEMPORARY TABLE sorted_lrj;
DROP TEMPORARY TABLE id_max;