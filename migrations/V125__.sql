ALTER TABLE game_launch_verifier ADD INDEX idx_create_time (create_time);
ALTER TABLE login_verifier ADD INDEX idx_create_time (create_time);

CREATE TABLE login_verifier_datas (
  hash CHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL PRIMARY KEY,
  data TEXT NOT NULL
);

ALTER TABLE login_verifier
  ADD COLUMN data_hash CHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
 
ALTER TABLE login_verifier
  ADD CONSTRAINT fk_login_verifier_data_hash
  FOREIGN KEY (data_hash)
  REFERENCES login_verifier_datas(hash);

 -- Populate login_verifier_datas with unique data from login_verifier
INSERT IGNORE INTO login_verifier_datas (hash, `data`)
SELECT
  SHA2(`data`, 256) AS hash,
  data
FROM login_verifier;

-- Update login_verifier to reference data by hash
UPDATE login_verifier
SET data_hash = SHA2(data, 256);

ALTER TABLE login_verifier
  DROP COLUMN `data`;

OPTIMIZE TABLE login_verifier;

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `chat_ban` AS
select
    `ban`.`player_id` AS `idUser`,
    `ban`.`reason` AS `reason`,
    coalesce(`ban`.`revoke_time`, `ban`.`expires_at`, cast('2999-12-31' as date)) AS `expires_at`
from
    `ban`
where
    (`ban`.`level` = 'CHAT');
