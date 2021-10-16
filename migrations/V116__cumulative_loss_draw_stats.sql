CREATE TEMPORARY TABLE sorted_lrj
SELECT
	CASE 
		WHEN @prev_lid = c.lid AND @prev_pid = c.pid AND c.score = -1 THEN @cumlost := @cumlost + 1
		WHEN @prev_lid = c.lid AND @prev_pid = c.pid AND c.score <> -1 THEN @cumlost
		WHEN (@prev_lid <> c.lid OR @prev_pid <> c.pid) AND c.score = -1 THEN @cumlost := 1
		ELSE @cumlost := 0
	END AS lost_games,
    CASE 
		WHEN @prev_lid = c.lid AND @prev_pid = c.pid AND c.score = 0 THEN @cumdrawn := @cumdrawn + 1
		WHEN @prev_lid = c.lid AND @prev_pid = c.pid AND c.score <> 0 THEN @cumdrawn
		WHEN (@prev_lid <> c.lid OR @prev_pid <> c.pid) AND c.score = 0 THEN @cumdrawn := 1
		ELSE @cumdrawn := 0
	END AS drawn_games,
    c.id,
    if (c.ts = NULL, CURRENT_TIMESTAMP, c.ts) ts,
    @prev_lid := c.lid AS `lid`,
    @prev_pid := c.pid AS `pid`,
    @prev_score := c.score AS `score`
FROM (
    SELECT
        @prev_lid  := NULL,
        @prev_pid := NULL,
        @cumdrawn := 0,
        @cumlost := 0
) i
JOIN (
    SELECT lrj.id id, lrj.leaderboard_id lid, gps.playerId pid, gps.score score, lrj.update_time ts
    FROM leaderboard_rating_journal lrj
    JOIN game_player_stats gps on gps.id = lrj.game_player_stats_id
    ORDER BY lrj.leaderboard_id, gps.playerId, lrj.update_time ASC
) c;

CREATE TEMPORARY TABLE id_max
SELECT MAX(id)
FROM sorted_lrj
GROUP BY lid, pid;

ALTER TABLE leaderboard_rating
    ADD COLUMN drawn_games INT DEFAULT 0,
    ADD COLUMN lost_games INT DEFAULT 0;

UPDATE leaderboard_rating lr
INNER JOIN (
	SELECT *
	FROM sorted_lrj
	WHERE id IN (SELECT * FROM id_max)
) upd on upd.lid = lr.leaderboard_id AND upd.pid = lr.login_id
SET
	lr.drawn_games = upd.drawn_games,
	lr.lost_games = upd.lost_games,
	lr.update_time = upd.ts;

DROP TEMPORARY TABLE sorted_lrj;
DROP TEMPORARY TABLE id_max;
