DROP DATABASE IF EXISTS exercise3;
CREATE DATABASE IF NOT EXISTS exercise3;
USE exercise3;

CREATE TABLE `exercise3`
(
	`id` 				INT auto_increment PRIMARY KEY,
    `name`				VARCHAR(50),
    `dateofbirth`		datetime,
    `gender`			INT CHECK (0 <= `gender` >= 1) default NULL,
    `IsDeletedFlag` 	ENUM('0' , '1') NOT NULL
);