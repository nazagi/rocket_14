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
    `email`					NVARCHAR(100) UNIQUE NOT NULL,
    `username`				VARCHAR(50) UNIQUE NOT NULL,
    `fullname`				NVARCHAR(50) NOT NULL,
    `createdate`			datetime,
    `departmentID`			INT NOT NULL,
    `positionID`			INT NOT NULL,
    FOREIGN KEY (`departmentID`) REFERENCES `department`(`departmentID`),
    FOREIGN KEY (`positionID`) REFERENCES `position`(`positionID`)
);

CREATE TABLE `group`
(
	`groupID`			INT PRIMARY KEY,
    `groupname`			NVARCHAR(50),
    `creatorID`			INT NOT NULL,
    `createdate`		datetime,
   FOREIGN KEY (`creatorID`) REFERENCES `account`(`accountID`)
);

CREATE TABLE `groupaccount`
(
	`groupID` 		INT NOT NULL,
    `accountID`		INT NOT NULL,
	FOREIGN KEY (`groupID`) REFERENCES `group`(`groupID`),
    FOREIGN KEY	(`accountID`) REFERENCES `account`(`accountID`),
    `joindate`		datetime
);

CREATE TABLE `typequestion`
(
	`typeID`		INT auto_increment PRIMARY KEY,
    `typename`		NVARCHAR(30)
);

CREATE TABLE `categoryquestion`
(
	`categoryID`			INT auto_increment PRIMARY KEY,
    `categoryname`			NVARCHAR(30)
);

CREATE TABLE `question`
(
	`questionID`					INT auto_increment PRIMARY KEY,
    `questioncontent`				NVARCHAR(300),
    `categoryID`					INT NOT NULL,
    `creatorID`						INT NOT NULL,
    `typeID`						INT NOT NULL,
    `createdate`					datetime,
    FOREIGN KEY (`typeID`) REFERENCES `typequestion`(`typeID`),
	FOREIGN KEY (`categoryID`) REFERENCES `categoryquestion`(`categoryID`),
    FOREIGN KEY (`creatorID`) REFERENCES `account`(`accountID`)
);

CREATE TABLE `answer`
(
	`answerID`				INT auto_increment PRIMARY KEY,
    `answercontent`			NVARCHAR(300),
    `questionID`			INT NOT NULL,
    `isCorrect`				ENUM('0' , '1'),
    FOREIGN KEY (`questionID`) REFERENCES `question`(`questionID`)
);

CREATE TABLE `exam`
(
	`examID`			INT auto_increment PRIMARY KEY,
    `code`				VARCHAR(30),
    `title`				NVARCHAR(50),
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

-- Question 1: Th??m ??t nh???t 10 record v??o m???i table
INSERT INTO `department` (`departmentname`) 
VALUES 
						(N'Marketing'	),
						(N'Sale'		),
						(N'B???o v???'		),
						(N'Nh??n s???'		),
						(N'K??? thu???t'	),
						(N'T??i ch??nh'	),
						(N'Ph?? gi??m ?????c'),
						(N'Gi??m ?????c'	),
						(N'Th?? k??'		),
						(N'B??n h??ng'	);
    
INSERT INTO `position`(`positionname`)
VALUES
	('Dev'			),
    ('Test'			),
    ('Scrum Master'	),
    ('PM'			);

INSERT INTO `account` (`email`,`username`,`fullname`,`departmentID`,`positionID`,`createdate`)
VALUES
	 				('haidang29productions@gmail.com'	, 'dangblack'		,'Nguy???n h???i ????ng'			,   '5'			,   '1'		,'2020-03-05'),
					('account1@gmail.com'				, 'quanganh'		,'Nguyen Chien Thang2'		,   '1'			,   '2'		,'2020-03-05'),
                    ('account2@gmail.com'				, 'vanchien'		,'Nguyen Van Chien'			,   '2'			,   '3'		,'2020-03-07'),
                    ('account3@gmail.com'				, 'cocoduongqua'	,'Duong Do'					,   '3'			,   '4'		,'2020-03-08'),
                    ('account4@gmail.com'				, 'doccocaubai'		,'Nguyen Chien Thang1'		,   '4'			,   '4'		,'2020-03-10'),
                    ('dapphatchetngay@gmail.com'		, 'khabanh'			,'Ngo Ba Kha'				,   '6'			,   '3'		,'2020-04-05'),
                    ('songcodaoly@gmail.com'			, 'huanhoahong'		,'Bui Xuan Huan'			,   '7'			,   '2'		, NULL		),
                    ('sontungmtp@gmail.com'				, 'tungnui'			,'Nguyen Thanh Tung'		,   '8'			,   '1'		,'2020-04-07'),
                    ('duongghuu@gmail.com'				, 'duongghuu'		,'Duong Van Huu'			,   '9'			,   '2'		,'2020-04-07'),
                    ('vtiaccademy@gmail.com'			, 'vtiaccademy'		,'Vi Ti Ai'					,   '10'		,   '1'		,'2020-04-09');
    
INSERT INTO `group`
VALUES
	 				('1',	N'Testing System'		,   5			,'2019-03-05'),
					('2',	N'Development'			,   1			,'2020-03-07'),
                    ('3',	N'VTI Sale 01'			,   2			,'2020-03-09'),
                    ('4',	N'VTI Sale 02'			,   3			,'2020-03-10'),
                    ('5',	N'VTI Sale 03'			,   4			,'2020-03-28'),
                    ('6',	N'VTI Creator'			,   6			,'2020-04-06'),
                    ('7',	N'VTI Marketing 01'		,   7			,'2020-04-07'),
                    ('8',	N'Management'			,   8			,'2020-04-08'),
                    ('9',	N'Chat with love'		,   9			,'2020-04-09'),
                    ('10',	N'Vi Ti Ai'				,   10			,'2020-04-10');

INSERT INTO `groupaccount`
VALUES
	 						(	1		,    1		,'2019-03-05'),
							(	1		,    2		,'2020-03-07'),
							(	3		,    3		,'2020-03-09'),
							(	3		,    4		,'2020-03-10'),
							(	5		,    5		,'2020-03-28'),
							(	1		,    3		,'2020-04-06'),
							(	1		,    7		,'2020-04-07'),
							(	8		,    3		,'2020-04-08'),
							(	1		,    9		,'2020-04-09'),
							(	10		,    10		,'2020-04-10');


INSERT INTO `typequestion` (`typename`)
VALUES
				('Essay'			), 
				('Multiple-Choice'	); 
        
INSERT INTO `categoryquestion` (`categoryname`)
VALUES
									('Java'			),
									('ASP.NET'		),
									('ADO.NET'		),
									('SQL'			),
									('Postman'		),
									('Ruby'			),
									('Python'		),
									('C++'			),
									('C Sharp'		),
									('PHP'			);
									
    
INSERT INTO `question` (`questioncontent`,`categoryID`,`typeID`,`creatorID`,`createdate`)
VALUES
						(N'C??u h???i v??? Java C??u h???i v??? Java C??u h???i v??? Java C??u h???i v??? Java'	,	1		,   '1'			,   '2'		,'2020-04-05'),
						(N'C??u H???i v??? PHP'	,	10		,   '2'			,   '2'		,'2020-04-05'),
						(N'H???i v??? C#'		,	9		,   '2'			,   '3'		,'2020-04-06'),
						(N'H???i v??? Ruby'		,	6		,   '1'			,   '4'		,'2020-04-06'),
						(N'H???i v??? Postman'	,	5		,   '1'			,   '5'		,'2020-04-06'),
						(N'H???i v??? ADO.NET'	,	3		,   '2'			,   '6'		,'2020-04-06'),
						(N'H???i v??? ASP.NET'	,	2		,   '1'			,   '7'		,'2020-04-06'),
						(N'H???i v??? C++'		,	8		,   '1'			,   '8'		,'2020-04-07'),
						(N'H???i v??? SQL'		,	4		,   '2'			,   '9'		,'2020-04-07'),
						(N'H???i v??? Python'	,	7		,   '1'			,   '10'	,'2020-04-07');


INSERT INTO `answer` (`answercontent`,`questionID`,`iscorrect`)
VALUES
					(N'Tr??? l???i 01'	,   1			,	'0'		),
					(N'Tr??? l???i 02'	,   1			,	'1'		),
                    (N'Tr??? l???i 03'	,   1			,	'0'		),
                    (N'Tr??? l???i 04'	,   1			,	'1'		),
                    (N'Tr??? l???i 05'	,   2			,	'1'		),
                    (N'Tr??? l???i 06'	,   3			,	'1'		),
                    (N'Tr??? l???i 07'	,   4			,	'0'		),
                    (N'Tr??? l???i 08'	,   8			,	'0'		),
                    (N'Tr??? l???i 09'	,   9			,	'1'		),
                    (N'Tr??? l???i 10'	,   10			,	'1'		);
	
    
INSERT INTO `exam` (`code`,`title`,`categoryID`,`duration`,`creatorID`,`createdate`)
VALUES
					('VTIQ001'		, N'????? thi C#'			,	1			,	60		,   '5'			,'2019-04-05'),
					('VTIQ002'		, N'????? thi PHP'			,	10			,	60		,   '2'			,'2019-04-05'),
                    ('VTIQ003'		, N'????? thi C++'			,	9			,	120		,   '2'			,'2019-04-07'),
                    ('VTIQ004'		, N'????? thi Java'		,	6			,	60		,   '3'			,'2020-04-08'),
                    ('VTIQ005'		, N'????? thi Ruby'		,	5			,	120		,   '4'			,'2020-04-10'),
                    ('VTIQ006'		, N'????? thi Postman'		,	3			,	60		,   '6'			,'2020-04-05'),
                    ('VTIQ007'		, N'????? thi SQL'			,	2			,	60		,   '7'			,'2020-04-05'),
                    ('VTIQ008'		, N'????? thi Python'		,	8			,	60		,   '8'			,'2020-04-07'),
                    ('VTIQ009'		, N'????? thi ADO.NET'		,	4			,	90		,   '9'			,'2020-04-07'),
                    ('VTIQ010'		, N'????? thi ASP.NET'		,	7			,	90		,   '10'		,'2020-04-08');
                    
    
INSERT INTO `examquestion`
vALUES
						(	1	,		5		),
						(	2	,		10		), 
						(	3	,		4		), 
						(	4	,		3		), 
						(	5	,		7		), 
						(	6	,		10		), 
						(	7	,		2		), 
						(	8	,		10		), 
						(	9	,		9		), 
						(	10	,		8		); 
    
-- Question 2: l???y ra t???t c??? c??c ph??ng ban
SELECT * FROM `account` ORDER BY `accountID`;

-- Question 3: l???y ra id c???a ph??ng ban "Sale"
SELECT `departmentID` FROM `department` WHERE `name` = 'Sale';

-- Question 4: l???y ra th??ng tin account c?? full name d??i nh???t
SELECT MAX(char_length(`fullname`)) FROM `account`;

-- Question 5: L???y ra th??ng tin account c?? full name d??i nh???t v?? thu???c ph??ng ban c?? id = 3
SELECT MAX(char_length(`fullname`)) FROM `account` WHERE `departmentID` = 3;
SELECT * FROM `account` WHERE `accountID` = 3 and char_length(`fullname`) = 17;

-- C??u 6: L???y ra c??c Group t???o tr?????c ng??y 20/12/2019
SELECT `name` FROM `group` WHERE `createdate` < '2019-12-20';

-- C??u 7:
SELECT `question_id` FROM  `answer` GROUP BY `question_id` HAVING count(*) >= 4;

-- C??u 8: 
SELECT `code` FROM `exam` WHERE `duration` >= 60 AND CreateDate < '2019-12-20';

-- C??u 9: 
SELECT * FROM `group` ORDER BY `createdate` DESC limit 5;

-- Question 10: ?????m s??? nh??n vi??n thu???c department c?? id = 2
SELECT count(*) FROM account WHERE `departmentID` = 2;

-- Question 11: L???y ra nh??n vi??n c?? t??n b???t ?????u b???ng ch??? "D" v?? k???t th??c b???ng ch??? "o"
SELECT 		`fullname` FROM 		`Account`
WHERE 		(SUBSTRING_INDEX(`fullName`, ' ', -1)) LIKE 'D%o' ;

-- Question 12: X??a t???t c??? c??c exam ???????c t???o tr?????c ng??y 20/12/2019
DELETE FROM `exam` WHERE 		CreateDate < '2019-12-20';

-- Question 13: X??a t???t c??? c??c question c?? n???i dung b???t ?????u b???ng t??? "c??u h???i"
DELETE FROM 		`question`
WHERE 		(SUBSTRING_INDEX(`questioncontent`,' ',2)) = 'C??u h???i';

-- Question 14: Update th??ng tin c???a account c?? id = 5 th??nh t??n "Nguy???n B?? L???c" v?? email th??nh loc.nguyenba@vti.com.vn
UPDATE 		`account` 
SET 		`fullname` 	= 	'Nguy???n B?? L???c', 
			`email` 		= 	'loc.nguyenba@vti.com.vn'
WHERE 		`accountID` = 5;

-- Question 15: update account c?? id = 5 s??? thu???c group c?? id = 4
UPDATE 		`groupaccount` 
SET 		`accountID` = 5 
WHERE 		`groupID` = 4;
