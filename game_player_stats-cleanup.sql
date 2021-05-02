delete from leaderboard_rating_journal where game_player_stats_id in (select id from game_player_stats where playerId <= 6);
delete from leaderboard_rating where login_id <= 6;
delete from game_player_stats where playerId <= 6;
