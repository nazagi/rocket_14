DROP DATABASE IF EXISTS testing_system;
CREATE DATABASE IF NOT EXISTS testing_system;
USE testing_system;

CREATE TABLE `department`
(
	`departmentID`			INT auto_increment PRIMARY KEY,
    `departmentname`		NVARCHAR(50) unique not null
);

CREATE TABLE `position`
(
	`positionID`		INT auto_increment PRIMARY KEY,
    `positionname`		ENUM('Dev','Test','Scrum Master', 'PM')
);

CREATE TABLE `account`
(
	`accountID` 			int auto_increment PRIMARY KEY,
    `email`					VARCHAR(100) UNIQUE NOT NULL,
    `username`				VARCHAR(50) UNIQUE NOT NULL,
    `fullname`				VARCHAR(50) NOT NULL,
    `createdate`			datetime,
    `departmentID`			INT NOT NULL,
    `positionID`			INT NOT NULL,
    FOREIGN KEY (`departmentID`) REFERENCES `department`(`departmentID`),
    FOREIGN KEY (`positionID`) REFERENCES `position`(`positionID`)
);

CREATE TABLE `group`
(
	`groupID`			INT PRIMARY KEY,
    `groupname`			VARCHAR(50),
    `createdate`		datetime,
    `creatorID`		INT,
   FOREIGN KEY (`creatorID`) REFERENCES `account`(`accountID`)
);

CREATE TABLE `gr_account`
(
	`groupID` 		INT NOT NULL,
    `accountID`	INT NOT NULL,
	FOREIGN KEY (`groupID`) REFERENCES `group`(`groupID`),
    FOREIGN KEY	(`accountID`) REFERENCES `account`(`accountID`),
    `joindate`		datetime
);

CREATE TABLE `typequestion`
(
	`typeID`		INT auto_increment PRIMARY KEY,
    `typename`		VARCHAR(30)
);

CREATE TABLE `categoryquestion`
(
	`categoryID`			INT auto_increment PRIMARY KEY,
    `categoryname`			VARCHAR(30)
);

CREATE TABLE `question`
(
	`questionID`					INT auto_increment PRIMARY KEY,
    `questioncontent`				VARCHAR(300),
    `categoryID`					INT NOT NULL,
    `creatorID`						INT NOT NULL,
    `createdate`					datetime,
	FOREIGN KEY (`categoryID`) REFERENCES `categoryquestion`(`categoryID`),
    FOREIGN KEY (`creatorID`) REFERENCES `account`(`accountID`)
);

CREATE TABLE `answer`
(
	`answerID`				INT auto_increment PRIMARY KEY,
    `answercontent`			VARCHAR(300),
    `questionID`			INT NOT NULL,
    `isCorrect`				ENUM('0' , '1'),
    FOREIGN KEY (`questionID`) REFERENCES `question`(`questionID`)
);

CREATE TABLE `exam`
(
	`examID`			INT auto_increment PRIMARY KEY,
    `code`				INT,
    `title`				VARCHAR(50),
    `categoryID`		INT NOT NULL,
    `creatorID`			INT NOT NULL,
    `duration` 			INT,
    `createdate` 		datetime,
    FOREIGN KEY (`creatorID`) REFERENCES `account`(`accountID`),
    FOREIGN KEY (`categoryID`) REFERENCES `categoryquestion`(`categoryID`)
);

CREATE TABLE `examquestion`
(
	`examID`		INT NOT NULL,
    `questionID` 	INT NOT NULL,
	FOREIGN KEY (`examID`) REFERENCES `exam`(`examID`),
	FOREIGN KEY (`questionID`) REFERENCES `question`(`questionID`)
);

-- Question 1: Thêm ít nhất 10 record vào mỗi table
INSERT INTO `department` (`departmentname`) 
VALUES 
	('Sale'				),
	('Marketing'		),
    ('Dev'				),
    ('CSKH'				),
    ('HR'				);
    
INSERT INTO `position`(`positionname`)
VALUES
	('Dev'			),
    ('Test'			),
    ('Scrum Master'	),
    ('PM'			);

INSERT INTO `account` (`email`,`username`,`fullname`,`createdate`,`departmentID`,`positionID`)
VALUES
	('nguyennam1@gmail.com',	'nam1',		'nguyen nam1',	'2018-01-02',	'1',	'4'		),
    ('nguyennam1@gmai2.com',	'nam2',		'nguyen nam2',	'2018-03-05',	'2',	'4'		),
	('nguyennam1@gmai3.com',	'nam3',		'nguyen nam3',	'2017-05-02',	'4',	'4'		),
    ('nguyennam1@gmai4.com',	'nam4',		'nguyen nam4',	'2016-12-25',	'3',	'1'		),
    ('nguyennam1@gmai5.com',	'nam5',		'nguyen nam5',	'2021-10-05',	'3',	'1'		),
    ('nguyennam1@gmai6.com',	'nam6',		'nguyen nam6',	'2020-11-20',	'3',	'2'		),
    ('nguyennam1@gmai7.com',	'nam7',		'nguyen nam7',	'2019-07-27',	'3',	'3'		),
    ('nguyennam1@gmai8.com',	'nam8',		'nguyen nam8',	'2019-01-22',	'3',	'3'		),
    ('nguyennam1@gmai9.com',	'nam9',		'nguyen nam9',	'2017-09-16',	'5',	'4'		),
    ('nguyennam1@gmail0.com',	'nam10',	'nguyen nam10',	'2020-08-14',	'3',	'4'		);
    
INSERT INTO `group`
VALUES
	('1',	'group1',	'2018-12-25',	'1'	),
    ('2',	'group2',	'2020-11-15',	'5'	),
    ('3',	'group3',	'2020-05-12',	'10'),
    ('4',	'group4',	'2021-04-23',	'7'	),
    ('5',	'group5',	'2017-01-02',	'5'	);
    
INSERT INTO `gr_account`
VALUES
	('1',	'1',	'2019-12-25'	),
    ('2',	'2',	'2020-11-15'	),
    ('3',	'3',	'2020-05-12'	),
    ('4',	'4',	'2021-04-23'	),
    ('5',	'5',	'2017-01-02'	);

INSERT INTO `typequestion` (`typename`)
VALUES
		('tu luan'		),
		('trac nghiem'	);
        
INSERT INTO `categoryquestion` (`categoryname`)
VALUES
	('Java'			),
    ('PHP'			),
    ('CPP'			),
    ('.Net'			),
    ('Ruby'			),
    ('python'		),
    ('Postman'		);
    
INSERT INTO `question` (`questioncontent`,`categoryID`,`creatorID`,`createdate`)
VALUES
	('cau hoi java', 		'1', 	'4', 	'2018-01-02'	),
    ('cau hoi java2', 		'1', 	'7', 	'2018-01-02'	),
    ('cau hoi PHP', 		'2', 	'4', 	'2018-01-02'	),
    ('cau hoi PHP2', 		'2', 	'2', 	'2018-01-02'	),
    ('cau hoi java3', 		'1', 	'3', 	'2018-01-02'	),
    ('cau hoi java4',		'1', 	'9', 	'2018-01-02'	),
    ('cau hoi CPP', 		'3', 	'1', 	'2018-01-02'	),
    ('cau hoi CPP2', 		'3', 	'1', 	'2018-01-02'	),
    ('cau hoi CPP3',		'3', 	'2', 	'2018-01-02'	),
    ('cau hoi .NET',		'4', 	'1', 	'2018-01-02'	),
    ('cau hoi python', 		'6', 	'8', 	'2018-01-02'	),
    ('cau hoi ruby', 		'5', 	'10', 	'2018-01-02'	),
    ('cau hoi ruby2', 		'5', 	'10', 	'2018-01-02'	),
    ('cau hoi ruby3', 		'5', 	'10', 	'2018-01-02'	),
    ('cau hoi postman', 	'7', 	'5', 	'2018-01-02'	),
    ('cau hoi postman2',	'7', 	'6', 	'2018-01-02'	),
    ('cau hoi postman3',	'7', 	'7', 	'2018-01-02'	),
    ('cau hoi postman4',	'7', 	'8', 	'2018-01-02'	),
    ('cau hoi postman5',	'7', 	'9', 	'2018-01-02'	),
    ('cau hoi java5',		'1', 	'3', 	'2018-01-02'	);

INSERT INTO `answer` (`answercontent`,`questionID`,`iscorrect`)
VALUES
	('a',	'1',	'1'	),
	('b',	'3',	'1'	),
    ('c',	'1',	'0'	),
    ('a',	'15',	'0'	),
    ('a',	'20',	'1'	),
    ('c',	'13',	'0'	),
    ('d',	'5',	'0'	),
    ('e',	'7',	'1'	),
    ('f',	'2',	'1'	),
    ('b',	'3',	'1'	),
    ('a',	'3',	'1'	),
    ('c',	'3',	'1'	);
    
INSERT INTO `exam` (`code`,`title`,`categoryID`,`creatorID`,`duration`,`createdate`)
VALUES
	('324',		'java',		'1',	'3',	'60', 	'2018-01-02'),
	('320',		'java',		'1',	'3',	'60', 	'2018-01-02'),
    ('321',		'java',		'4',	'4',	'60', 	'2018-01-02'),
    ('322',		'java',		'2',	'4',	'60', 	'2018-01-02'),
    ('323',		'java',		'4',	'10',	'60', 	'2018-01-02'),
    ('325',		'java',		'6',	'2',	'60', 	'2018-01-02'),
    ('326',		'java',		'3',	'5',	'60', 	'2018-01-02'),
    ('327',		'java',		'2',	'3',	'60', 	'2018-01-02'),
    ('328',		'java',		'5',	'3',	'60', 	'2018-01-02');
    
INSERT INTO `examquestion`
vALUES
	('1',	 '1'),
    ('2',	 '2'),
    ('3',	 '5'),
    ('4',	 '6'),
    ('5',	 '1'),
    ('6',	 '6'),
    ('7',	 '5'),
    ('8',	 '6'),
    ('9',	 '2');    