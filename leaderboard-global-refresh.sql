CREATE TEMPORARY TABLE active_global_players ENGINE=MEMORY AS
            (
                SELECT DISTINCT gps.playerId AS player_id
                FROM game_player_stats gps
                INNER JOIN game_stats gs on gps.gameId = gs.id
                WHERE gs.endTime > now() - INTERVAL 1 YEAR
                  AND gs.gameMod <> 2 -- global
                  AND gs.validity = 0
            );

        DELETE FROM active_global_players
        WHERE player_id IN (
            SELECT player_id FROM ban
            WHERE level = 'GLOBAL' AND
                (expires_at IS NULL OR expires_at > NOW()) AND
                revoke_time IS NULL
        );

        START TRANSACTION;
        DELETE FROM global_rating_rank_view WHERE true;
        ALTER TABLE global_rating_rank_view AUTO_INCREMENT = 1;
        INSERT INTO global_rating_rank_view(`id`, `mean`, `deviation`, `num_games`, `rating`)
        SELECT leaderboard_rating.login_id,
               mean,
               deviation,
               total_games,
               rating
        FROM leaderboard_rating
         INNER JOIN active_global_players ON (
                leaderboard_rating.login_id = active_global_players.player_id
            AND leaderboard_rating.leaderboard_id = 1 -- global
        )
        ORDER BY rating DESC;

        DROP TABLE active_global_players;

        COMMIT;