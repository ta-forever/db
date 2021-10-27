ALTER TABLE leaderboard_rating
    ADD COLUMN best_streak SMALLINT;

ALTER TABLE game_stats
    ADD COLUMN replay_meta JSON DEFAULT NULL,
    ADD COLUMN tada_available TINYINT DEFAULT 0;

CREATE TEMPORARY TABLE sorted_lrj
SELECT
    IF(@prev_lid = c.lid AND @prev_pid = c.pid AND (@cumstreak*c.score >= 0),
        @cumstreak := @cumstreak + c.score,
        @cumstreak := c.score
        ) AS streak,
    IF(@prev_lid = c.lid AND @prev_pid = c.pid,
        @beststreak := IF(@cumstreak > @beststreak, @cumstreak, @beststreak),
        @beststreak := @cumstreak
        ) AS best_streak,
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
        @beststreak := 0
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

UPDATE leaderboard_rating lr
INNER JOIN (
    SELECT *
    FROM sorted_lrj
    WHERE id IN (SELECT * FROM id_max)
) upd ON upd.lid = lr.leaderboard_id AND upd.pid = lr.login_id
SET lr.best_streak = upd.best_streak;

DROP TEMPORARY TABLE sorted_lrj;
DROP TEMPORARY TABLE id_max;
