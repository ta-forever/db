ALTER TABLE friends_and_foes ADD COLUMN auto_foe TINYINT(1) DEFAULT 0;

DELIMITER $$

-- Drop and create the first trigger
DROP TRIGGER IF EXISTS after_login_insert_auto_foe$$
CREATE TRIGGER after_login_insert_auto_foe
AFTER INSERT ON login
FOR EACH ROW
BEGIN
    INSERT INTO friends_and_foes (user_id, subject_id, status, auto_foe)
    SELECT 
        NEW.id AS user_id, 
        faf.subject_id AS subject_id, 
        'FOE' AS status,
        1 AS auto_foe
    FROM 
        friends_and_foes faf
	JOIN
		login k ON k.id = faf.user_id
    WHERE 
        faf.status = 'FOE'
        AND faf.auto_foe=0
        AND k.update_time > NOW() - INTERVAL 100 DAY
    GROUP BY 
        faf.subject_id
    HAVING 
        COUNT(*) >= 8;
END$$

-- Reset delimiter
DELIMITER ;

DELIMITER $$

-- Drop and create the second trigger
DROP TRIGGER IF EXISTS after_login_insert_avatars$$
CREATE TRIGGER after_login_insert_avatars
AFTER INSERT ON login
FOR EACH ROW
BEGIN
    INSERT INTO avatars (idUser, idAvatar)
    VALUES 
        (NEW.id, 1),
        (NEW.id, 2);
END$$

-- Reset delimiter to default
DELIMITER ;
