DROP DATABASE IF EXISTS exercise2;
CREATE DATABASE IF NOT EXISTS exercise2;
USE exercise2;


CREATE TABLE `exercise2`
(
	`id` 				INT auto_increment PRIMARY KEY,
    `name`				VARCHAR(50),
    `code`				FLOAT check ('00000' <= `code` >= '99999'),
    `modified_date` 	datetime
);