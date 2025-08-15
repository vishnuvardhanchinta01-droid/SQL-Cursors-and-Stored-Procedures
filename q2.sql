
DELIMITER $$

CREATE PROCEDURE GetWatchHistoryBySubscriber(IN sub_id INT)
BEGIN
    SELECT s.SubscriberName,
           sh.Title AS ShowTitle,
           wh.WatchTime
    FROM WatchHistory wh
    INNER JOIN Subscribers s ON wh.SubscriberID = s.SubscriberID
    INNER JOIN Shows sh ON wh.ShowID = sh.ShowID
    WHERE wh.SubscriberID = sub_id;
END$$

DELIMITER ;
-- For Subscriber 1
CALL GetWatchHistoryBySubscriber(1);

-- For Subscriber 3
CALL GetWatchHistoryBySubscriber(3);