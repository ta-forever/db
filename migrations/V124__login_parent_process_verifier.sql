-- 1. Create login_verifier if it doesn't exist
CREATE TABLE IF NOT EXISTS login_verifier (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  login_id MEDIUMINT(8) UNSIGNED NOT NULL,
  verification_result VARCHAR(255),
  data TEXT,
  create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (login_id) REFERENCES login(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Add trueskill_env column to game_featuredMods if it doesn't exist
-- (MySQL 5.7 doesn't support IF NOT EXISTS for ADD COLUMN, so use conditional logic)
SET @column_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE table_name = 'game_featuredMods'
    AND table_schema = DATABASE()
    AND column_name = 'trueskill_env'
);
SET @sql := IF(@column_exists = 0,
  'ALTER TABLE game_featuredMods ADD COLUMN trueskill_env VARCHAR(127) DEFAULT ''{\"mu\":1500, \"sigma\":500, \"beta\":240, \"tau\":10, \"draw_probability\":0.1}'';',
  'SELECT "Column already exists"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 3. Create game_launch_verifier if it doesn't exist
CREATE TABLE IF NOT EXISTS game_launch_verifier (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  login_id MEDIUMINT(8) UNSIGNED NOT NULL,
  game_id INT(10) UNSIGNED NOT NULL,
  data TEXT,
  create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (login_id) REFERENCES login(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
