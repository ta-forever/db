CREATE TABLE IF NOT EXISTS `gw_game_stats` (
    `game_id` INT UNSIGNED NOT NULL,
    `galaxy` VARCHAR(64) NOT NULL,
    `iteration` INT UNSIGNED NOT NULL DEFAULT 1,
    `planet_id` INT NOT NULL,
    PRIMARY KEY (`game_id`),
    CONSTRAINT `fk_gw_game_stats_game_id` FOREIGN KEY (`game_id`) REFERENCES `game_stats` (`id`) ON DELETE CASCADE,
    INDEX `idx_gw_game_stats_planet` (`galaxy`, `iteration`, `planet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `gw_game_player_stats` (
    `game_player_stats_id` BIGINT UNSIGNED NOT NULL,
    `gw_faction` VARCHAR(16) NOT NULL,
    `gw_rank` TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (`game_player_stats_id`),
    CONSTRAINT `fk_gw_game_player_stats_id` FOREIGN KEY (`game_player_stats_id`) REFERENCES `game_player_stats` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
