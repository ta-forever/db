DELIMITER $$

-- Drop and create the first trigger
DROP TRIGGER IF EXISTS after_login_insert_auto_foe$$
CREATE TRIGGER after_login_insert_auto_foe
AFTER INSERT ON login
FOR EACH ROW
BEGIN
    INSERT INTO friends_and_foes (user_id, subject_id, status)
    SELECT 
        NEW.id AS user_id, 
        faf.subject_id AS subject_id, 
        'FOE' AS status
    FROM 
        friends_and_foes faf
    WHERE 
        faf.status = 'FOE'
    GROUP BY 
        faf.subject_id
    HAVING 
        COUNT(*) > 7;
END$$

-- Reset delimiter
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
