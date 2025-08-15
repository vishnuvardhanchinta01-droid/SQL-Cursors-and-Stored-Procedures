
DELIMITER $$

CREATE PROCEDURE SendWatchTimeReport()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE sub_id INT;
    DECLARE sub_name VARCHAR(100);

    -- Cursor to iterate through all subscribers
    DECLARE cur CURSOR FOR 
        SELECT SubscriberID, SubscriberName FROM Subscribers;

    -- Handler when no more rows
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO sub_id, sub_name;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Check if subscriber has any watch history
        IF (SELECT COUNT(*) FROM WatchHistory WHERE SubscriberID = sub_id) > 0 THEN
            -- Print subscriber header
            SELECT CONCAT('--- Watch History for: ', sub_name, ' ---') AS Header;
            -- Show their watch history
            CALL GetWatchHistoryBySubscriber(sub_id);
        END IF;
    END LOOP;

    CLOSE cur;
END$$

DELIMITER ;

CALL SendWatchTimeReport();