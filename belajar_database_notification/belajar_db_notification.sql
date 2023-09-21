CREATE DATABASE belajar_db_notification;

use belajar_db_notification;

SHOW tables;



# USER

CREATE TABLE User (
    id VARCHAR(100) NOT NULL PRIMARY KEY ,
    name VARCHAR(100) NOT NULL
) ENGINE InnoDB;


INSERT INTO User(id,name) VALUES ('001','Denny Raymond');
INSERT INTO User(id,name) VALUES ('002','Raymond Denny');

SELECT * FROM User;


# Notification/inbox feature

CREATE TABLE Notification (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    title VARCHAR(255) NOT NULL ,
    detail TEXT NOT NULL ,
    created_at TIMESTAMP NOT NULL ,
    user_id VARCHAR(100)
) ENGINE InnoDB;

SHOW TABLES;

SELECT * FROM Notification;

# create a relation between the table user and notification
ALTER TABLE Notification ADD CONSTRAINT fk_notification_user
FOREIGN KEY (user_id) REFERENCES User(id);

DESC Notification;

INSERT INTO Notification( title, detail, created_at, user_id)  VALUES ('Contoh pesanan','detail pesanan',CURRENT_TIMESTAMP(),'001');

INSERT INTO Notification( title, detail, created_at, user_id)  VALUES ('Contoh promo','detail promo',CURRENT_TIMESTAMP(),null);

INSERT INTO Notification( title, detail, created_at, user_id)  VALUES ('Contoh pembayaran','detail pembayaran',CURRENT_TIMESTAMP(),'002');


SELECT * FROM Notification;

# query the notification based on the user only
SELECT * FROM Notification WHERE user_id='001';

# Query the notification based on the user and the global category
SELECT * FROM Notification WHERE (user_id='001' OR user_id IS NULL ) ORDER BY created_at DESC;


# Category
CREATE TABLE Category(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
    name VARCHAR(100) NOT NULL
) ENGINE InnoDB;

ALTER TABLE Category MODIFY COLUMN id VARCHAR(100);

SHOW TABLES ;

ALTER TABLE Notification MODIFY COLUMN category_id VARCHAR(100);

ALTER TABLE Notification ADD COLUMN category_id INT;

ALTER TABLE Notification MODIFY COLUMN id INT;

SELECT * FROM Notification;

ALTER TABLE Notification ADD CONSTRAINT fk_notification_category
FOREIGN KEY (category_id) REFERENCES Category(id);

DESC Notification;
SELECT * FROM Notification;

INSERT INTO Category(id,name) VALUES('INFO','Info');
INSERT INTO Category(id,name) VALUES('PROMO','Promo');

SELECT * FROM Category;

SELECT * FROM Notification;

# update the notification with category
UPDATE Notification SET category_id = 'INFO'
WHERE id = 1;

UPDATE Notification SET category_id = 'PROMO'
WHERE id = 2;

UPDATE Notification SET category_id = 'INFO'
WHERE id = 3;

SELECT * FROM Notification;

# query the notification based on category name Promo
SELECT * FROM Notification WHERE( Notification.category_id = 'Promo');

SELECT *
FROM Notification;


SELECT *
FROM Notification
WHERE (user_id = '001' OR user_id IS NULL)
ORDER BY created_at DESC;


SELECT *
FROM Notification n
         JOIN Category c ON (n.category_id = c.id);

SELECT *
FROM Notification n
         JOIN Category c ON (n.category_id = c.id)
WHERE (user_id = '001' OR user_id IS NULL)
ORDER BY created_at DESC;


SELECT *
FROM Notification n
         JOIN Category c ON (n.category_id = c.id)
WHERE (user_id = '002' OR user_id IS NULL)
ORDER BY created_at DESC;


# Get only promo
SELECT *
FROM Notification n
         JOIN Category c ON (n.category_id = c.id)
WHERE (user_id = '001' OR user_id IS NULL)
  AND c.id = 'PROMO'
ORDER BY created_at DESC;


# Notification Read
CREATE TABLE NotificationRead
(
    id              INT          NOT NULL PRIMARY KEY,
    is_read         BOOLEAN      NOT NULL,
    notification_id INT          NOT NULL,
    user_id         VARCHAR(100) NOT NULL
) ENGINE = InnoDB

SHOW TABLES;

SELECT *
FROM NotificationRead;

# set FK
ALTER TABLE NotificationRead
    ADD CONSTRAINT fk_notification_read_notification
        FOREIGN KEY (notification_id) REFERENCES Notification (id);
# set FK
ALTER TABLE NotificationRead
    ADD CONSTRAINT fk_notification_read_user
        FOREIGN KEY (user_id) REFERENCES User (id);

DESC NotificationRead;

SELECT * FROM Notification;

# Update colum to auto increment
ALTER TABLE NotificationRead
MODIFY id INT AUTO_INCREMENT;

DESC NotificationRead;
# insert data to notificationRead
INSERT INTO NotificationRead(is_read, notification_id, user_id)
VALUES (
        true,2,'001'
       );

INSERT INTO NotificationRead(is_read, notification_id, user_id)
VALUES (
        true,2,'002'
       );

INSERT INTO NotificationRead( is_read, notification_id, user_id) VALUES (true,1,'001');
INSERT INTO NotificationRead( is_read, notification_id, user_id) VALUES (true,3,'002');

SELECT * FROM NotificationRead;


# show the notification box with category name and is read
SELECT * FROM Notification n
    JOIN Category c ON (n.category_id = c.id)
    LEFT JOIN NotificationRead nr ON (nr.notification_id = n.id)
WHERE (n.user_id = '001' OR n.user_id IS NULL)
  AND (nr.user_id = '001' OR nr.user_id IS NULL)
ORDER BY n.created_at DESC;


# get notification unread counter
SELECT COUNT(*) FROM Notification n JOIN Category c ON (n.category_id = c.id)
LEFT JOIN NotificationRead nr ON (nr.notification_id = n.id)
WHERE (n.user_id = '001' OR n.user_id IS NULL)
AND (nr.user_id IS NULL)
ORDER BY n.created_at DESC;


