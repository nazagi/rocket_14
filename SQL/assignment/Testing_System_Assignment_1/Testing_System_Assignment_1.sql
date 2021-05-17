DROP DATABASE IF EXISTS testing_system;
CREATE DATABASE IF NOT EXISTS testing_system;
USE testing_system;

CREATE TABLE `department`
(
	`id`		INT auto_increment PRIMARY KEY,
    `name`		NVARCHAR(50) unique not null
);

CREATE TABLE `position`
(
	`id`		INT auto_increment PRIMARY KEY,
    `name`		ENUM('Dev','Test','Scrum Master', 'PM')
);

CREATE TABLE `account`
(
	`id` 			int auto_increment PRIMARY KEY,
    `email`			VARCHAR(100) UNIQUE NOT NULL,
    `usename`		VARCHAR(50) UNIQUE NOT NULL,
    `fullname`		VARCHAR(50) NOT NULL,
    `createdate`	datetime,
    `department_id`	INT NOT NULL,
    `position_id`	INT NOT NULL,
    FOREIGN KEY (`department_id`) REFERENCES `department`(`id`),
    FOREIGN KEY (`position_id`) REFERENCES `position`(`id`)
);

CREATE TABLE `group`
(
	`id`			INT NOT NULL UNIQUE,
    `name`			VARCHAR(50),
    `createdate`	datetime,
    `creator_id`	INT,
   FOREIGN KEY (`creator_id`) REFERENCES `account`(`id`)
);

CREATE TABLE `gr_account`
(
	`group_id` 		INT NOT NULL,
    `account_id`	INT NOT NULL,
	FOREIGN KEY (`group_id`) REFERENCES `group`(`id`),
    FOREIGN KEY	(`account_id`) REFERENCES `account`(`id`),
    `joindate`		datetime
);

CREATE TABLE `typequestion`
(
	`id`	INT auto_increment PRIMARY KEY,
    `name`	VARCHAR(30)
);

CREATE TABLE `categoryquestion`
(
	`id`	INT auto_increment PRIMARY KEY,
    `name`	VARCHAR(30)
);

CREATE TABLE `question`
(
	`id`			INT auto_increment PRIMARY KEY,
    `content`		VARCHAR(300),
    `category_id`	INT NOT NULL,
    `creator_id`	INT NOT NULL,
    `createdate`	datetime,
	FOREIGN KEY (`category_id`) REFERENCES `categoryquestion`(`id`),
    FOREIGN KEY (`creator_id`) REFERENCES `account`(`id`)
);

CREATE TABLE `answer`
(
	`id`			INT auto_increment PRIMARY KEY,
    `content`		VARCHAR(300),
    `question_id`	INT NOT NULL,
    `isCorrect`	ENUM('Yes','No'),
    FOREIGN KEY (`question_id`) REFERENCES `question`(`id`)
);

CREATE TABLE `exam`
(
	`id`			INT auto_increment PRIMARY KEY,
    `code`			INT,
    `title`			VARCHAR(50),
    `category_id`	INT NOT NULL,
    `creator_id`	INT NOT NULL,
    `duration` 		datetime,
    `createdate` 	datetime,
    FOREIGN KEY (`creator_id`) REFERENCES `account`(`id`),
    FOREIGN KEY (`category_id`) REFERENCES `categoryquestion`(`id`)
);

CREATE TABLE _exam_question
(
	`exam_id`		INT NOT NULL,
    `question_id` 	INT NOT NULL,
	FOREIGN KEY (`exam_id`) REFERENCES `exam`(`id`),
	FOREIGN KEY (`question_id`) REFERENCES `question`(`id`)
);