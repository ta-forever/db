CREATE TABLE `ban` (
  `id`          MEDIUMINT(8) UNSIGNED   NOT NULL AUTO_INCREMENT,
  `player_id`   MEDIUMINT(8) UNSIGNED   NOT NULL,
  `author_id`   MEDIUMINT(8) UNSIGNED   NOT NULL,
  `reason`      VARCHAR(255)            NOT NULL,
  `expires_at`  TIMESTAMP               NULL     DEFAULT NULL
  COMMENT 'if null the ban is permanent',
  `level`       ENUM ('CHAT', 'GLOBAL') NOT NULL,
  `create_time` TIMESTAMP               NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP               NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`player_id`) REFERENCES `login` (`id`),
  FOREIGN KEY (`author_id`) REFERENCES `login` (`id`)
)
  COMMENT = 'ban can be revoked, see ban_revoke';

CREATE TABLE `ban_revoke` (
  `ban_id`      MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `reason`      VARCHAR(255)          NOT NULL,
  `author_id`   MEDIUMINT(8) UNSIGNED NOT NULL,
  `create_time` TIMESTAMP             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP             NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ban_id`),
  FOREIGN KEY (`ban_id`) REFERENCES `ban` (`id`),
  FOREIGN KEY (`author_id`) REFERENCES `login` (`id`)
)
  COMMENT = 'If an entry exists to a ban the ban is revoked';

DELETE FROM lobby_ban
WHERE idUser NOT IN (SELECT id
                     FROM login);

INSERT INTO `ban` (`player_id`, `author_id`, `reason`, `expires_at`, `level`)
  SELECT
    `idUser`,
    `idUser`,
    `reason`,
    FROM_UNIXTIME(`expires_at`),
    'GLOBAL'
  FROM `lobby_ban`;

DROP TABLE `lobby_ban`;

CREATE VIEW `lobby_ban` AS
  SELECT
    ban.player_id                          AS idUser,
    ban.reason                             AS reason,
    COALESCE(ban.expires_at, '2999-12-31') AS expires_at
  FROM ban
    LEFT JOIN ban_revoke ON ban.id = ban_revoke.ban_id
  WHERE level != 'CHAT'
        AND ban_revoke.ban_id IS NULL
        AND (ban.expires_at IS NULL OR ban.expires_at > NOW());
