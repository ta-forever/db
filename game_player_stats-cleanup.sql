delete from leaderboard_rating where login_id in (1,2,6);
delete from leaderboard_rating_journal where game_player_stats_id in (select id from faf.game_player_stats where playerId in (1,2,6));
delete from matchmaker_queue_game where game_stats_id in (select gameId from game_player_stats where playerId in (1,2,6));
delete from game_player_stats where playerId in (1,2,6);
delete from game_stats where id not in (
  select distinct(gameId)
  from game_player_stats
  where playerId not in (1,2,6)
);
