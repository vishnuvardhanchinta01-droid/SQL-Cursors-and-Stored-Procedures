DROP PROCEDURE IF EXISTS AddSubscriberIfNotExists;

DELIMITER $$

CREATE PROCEDURE AddSubscriberIfNotExists(IN subName VARCHAR(100))
BEGIN
    DECLARE subCount INT;
    DECLARE newID INT;

    -- Check if subscriber name already exists
    SELECT COUNT(*) INTO subCount
    FROM Subscribers
    WHERE LOWER(SubscriberName) = LOWER(subName);

    IF subCount = 0 THEN
        -- Get new ID separately
        SELECT IFNULL(MAX(SubscriberID), 0) + 1 INTO newID FROM Subscribers;

        -- Insert with new ID
        INSERT INTO Subscribers (SubscriberID, SubscriberName, SubscriptionDate)
        VALUES (newID, subName, CURDATE());

        SELECT CONCAT('Subscriber "', subName, '" added successfully.') AS Message;
    ELSE
        SELECT CONCAT('Subscriber "', subName, '" already exists.') AS Message;
    END IF;
END$$

DELIMITER ;

-- Adding new Subscriber
CALL AddSubscriberIfNotExists('Donald Trump');

-- Checking whether a existing Subscriber can be added or not
CALL AddSubscriberIfNotExists('Lionel Messi');
