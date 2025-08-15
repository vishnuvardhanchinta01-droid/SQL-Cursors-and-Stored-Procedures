DELIMITER $$

CREATE PROCEDURE ListAllSubscribers()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE sub_name VARCHAR(100);

    DECLARE cur CURSOR FOR 
        SELECT SubscriberName FROM Subscribers;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    CREATE TEMPORARY TABLE IF NOT EXISTS TempNames (name VARCHAR(100));
    TRUNCATE TABLE TempNames;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO sub_name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        INSERT INTO TempNames VALUES (sub_name);
    END LOOP;

    CLOSE cur;

    SELECT * FROM TempNames;
END$$

DELIMITER ;

CALL ListAllSubscribers();