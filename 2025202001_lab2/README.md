# SQL Stored Procedures and Cursors

## CS6.302 - Software System Development

This repository is focused on implementing stored procedures and cursors in MySQL. The queries written demonstrate various database operations based on Stored Procedures and Cursors.

## Database Schema

The Subscribers Database uses a streaming service database with three main tables with the following schemas:

### Tables Structure

**Shows Table**
- `ShowID` (INT, Primary Key)
- `Title` (VARCHAR(100))
- `Genre` (VARCHAR(50))
- `ReleaseYear` (INT)

**Subscribers Table**
- `SubscriberID` (INT, Primary Key)
- `SubscriberName` (VARCHAR(100))
- `SubscriptionDate` (DATE)

**WatchHistory Table**
- `HistoryID` (INT, Primary Key)
- `ShowID` (INT, Foreign Key)
- `SubscriberID` (INT, Foreign Key)
- `WatchTime` (INT) - Duration in minutes


### Database Setup
1. Open MySQL Workbench
2. Create a new schema/database for this lab
3. Execute the table creation statements:

```sql
-- Create Tables
CREATE TABLE Shows (
    ShowID INT PRIMARY KEY,
    Title VARCHAR(100),
    Genre VARCHAR(50),
    ReleaseYear INT
);

CREATE TABLE Subscribers (
    SubscriberID INT PRIMARY KEY,
    SubscriberName VARCHAR(100),
    SubscriptionDate DATE
);

CREATE TABLE WatchHistory (
    HistoryID INT PRIMARY KEY,
    ShowID INT,
    SubscriberID INT,
    WatchTime INT,
    FOREIGN KEY (ShowID) REFERENCES Shows(ShowID),
    FOREIGN KEY (SubscriberID) REFERENCES Subscribers(SubscriberID)
);
```

4. Insert sample data:

```sql
-- Insert Sample Data
INSERT INTO Shows (ShowID, Title, Genre, ReleaseYear) VALUES
(1, 'Stranger Things', 'Sci-Fi', 2016),
(2, 'The Crown', 'Drama', 2016),
(3, 'The Witcher', 'Fantasy', 2019);

INSERT INTO Subscribers (SubscriberID, SubscriberName, SubscriptionDate) VALUES
(1, 'Emily Clark', '2023-01-10'),
(2, 'Chris Adams', '2023-02-15'),
(3, 'Jordan Smith', '2023-03-05');

INSERT INTO WatchHistory (HistoryID, SubscriberID, ShowID, WatchTime) VALUES
(1, 1, 1, 100),
(2, 1, 2, 10),
(3, 2, 1, 20),
(4, 2, 2, 40),
(5, 2, 3, 10),
(6, 3, 2, 10),
(7, 3, 1, 10);
```

## Execution Instructions

Execute the SQL files in the following order:

### 1. Question 1 (q1.sql)
**ListAllSubscribers() Procedure**
- Creates a stored procedure that uses a cursor to iterate through all subscribers
- Stores subscriber names in a temporary table and displays them
```bash
mysql> source q1.sql
```
### ListAllSubscribers()
```
| name              |
|-------------------|
| Emily Clark       |
| Chris Adams       |
| Jordan Smith      |
| Virat Kohli       |
| Rohit Sharma      |
| MS Dhoni          |
| Sachin Tendulkar  |
| Jasprit Bumrah    |
| Sunil Chhetri     |
| Cristiano Ronaldo |
| Lionel Messi      |
| Neymar Jr         |
| Kylian Mbappé     |
| Harry Kane        |
| Mohamed Salah     |
| Sergio Ramos      |
| David Beckham     |
| Sunil Gavaskar    |
| Kapil Dev         |
| Rahul Dravid      |
````
### 2. Question 2 (q2.sql)
**GetWatchHistoryBySubscriber() Procedure**
- Creates a procedure to get watch history for a specific subscriber
- Includes calls for subscribers 1 and 3
```bash
mysql> source q2.sql
```
### GetWatchHistoryBySubscriber(1)
```
| SubscriberName | ShowTitle        | WatchTime |
|----------------|------------------|-----------|
| Emily Clark    | Stranger Things  | 100       |
| Emily Clark    | The Crown        | 10        |
```
### GetWatchHistoryBySubscriber(3)
```
| SubscriberName | ShowTitle        | WatchTime |
|----------------|------------------|-----------|
| Jordan Smith   | The Crown        | 10        |
| Jordan Smith   | Stranger Things  | 10        |
```
### 3. Question 3 (q3.sql)
**AddSubscriberIfNotExists() Procedure**
- Adds a new subscriber only if they don't already exist
- Demonstrates conditional insertion logic
- Includes test calls for new and existing subscribers
```bash
mysql> source q3.sql
```
### AddSubscriberIfNotExists('Donald Trump')
```
| Message                                       |
|-----------------------------------------------|
| Subscriber "Donald Trump" added successfully. |
```
### AddSubscriberIfNotExists('Lionel Messi');
```
| Message                                       |
|-----------------------------------------------|
| Subscriber "Lionel Messi" added successfully. |
```
### 4. Question 4 (q4.sql)
**SendWatchTimeReport() Procedure**
- Uses cursor to iterate through all subscribers
- Calls GetWatchHistoryBySubscriber() for subscribers with watch history
- Depends on q2.sql being executed first
```bash
mysql> source q4.sql
```
### SendWatchTimeReport() 

```
+---------------+-------------+-----------+
| SubscriberName| ShowTitle   | WatchTime |
+---------------+-------------+-----------+
| Sergio Ramos  | Mindhunter  | 100       |
+---------------+-------------+-----------+
```

### 5. Question 5 (q5.sql)
**ShowAllSubscribersWatchHistory() Procedure**
- Alternative cursor-based approach to display all subscribers' watch history
- Calls existing GetWatchHistoryBySubscriber() procedure
- Depends on q2.sql being executed first
```bash
mysql> source q5.sql
```
### ShowAllSubscribersWatchHistory()
```
+---------------+-------------------+-----------+
| SubscriberName| Title             | WatchTime |
+---------------+-------------------+-----------+
| Rahul Dravid  | House of Cards    | 85        |
+---------------+-------------------+-----------+
```

## File Structure
```
├── q1.sql          # ListAllSubscribers procedure
├── q2.sql          # GetWatchHistoryBySubscriber procedure
├── q3.sql          # AddSubscriberIfNotExists procedure
├── q4.sql          # SendWatchTimeReport procedure
├── q5.sql          # ShowAllSubscribersWatchHistory procedure
└── README.md       # Readme file