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

-- Question 1: Thêm ít nhất 10 record vào mỗi table
INSERT INTO `department` (`departmentname`) 
VALUES 
						(N'Marketing'	),
						(N'Sale'		),
						(N'Bảo vệ'		),
						(N'Nhân sự'		),
						(N'Kỹ thuật'	),
						(N'Tài chính'	),
						(N'Phó giám đốc'),
						(N'Giám đốc'	),
						(N'Thư kí'		),
						(N'Bán hàng'	);
    
INSERT INTO `position`(`positionname`)
VALUES
	('Dev'			),
    ('Test'			),
    ('Scrum Master'	),
    ('PM'			);

INSERT INTO `account` (`email`,`username`,`fullname`,`departmentID`,`positionID`,`createdate`)
VALUES
	 				('haidang29productions@gmail.com'	, 'dangblack'		,'Nguyễn hải Đăng'			,   '5'			,   '1'		,'2020-03-05'),
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
						(N'Câu hỏi về Java Câu hỏi về Java Câu hỏi về Java Câu hỏi về Java'	,	1		,   '1'			,   '2'		,'2020-04-05'),
						(N'Câu Hỏi về PHP'	,	10		,   '2'			,   '2'		,'2020-04-05'),
						(N'Hỏi về C#'		,	9		,   '2'			,   '3'		,'2020-04-06'),
						(N'Hỏi về Ruby'		,	6		,   '1'			,   '4'		,'2020-04-06'),
						(N'Hỏi về Postman'	,	5		,   '1'			,   '5'		,'2020-04-06'),
						(N'Hỏi về ADO.NET'	,	3		,   '2'			,   '6'		,'2020-04-06'),
						(N'Hỏi về ASP.NET'	,	2		,   '1'			,   '7'		,'2020-04-06'),
						(N'Hỏi về C++'		,	8		,   '1'			,   '8'		,'2020-04-07'),
						(N'Hỏi về SQL'		,	4		,   '2'			,   '9'		,'2020-04-07'),
						(N'Hỏi về Python'	,	7		,   '1'			,   '10'	,'2020-04-07');


INSERT INTO `answer` (`answercontent`,`questionID`,`iscorrect`)
VALUES
					(N'Trả lời 01'	,   1			,	'0'		),
					(N'Trả lời 02'	,   1			,	'1'		),
                    (N'Trả lời 03'	,   1			,	'0'		),
                    (N'Trả lời 04'	,   1			,	'1'		),
                    (N'Trả lời 05'	,   2			,	'1'		),
                    (N'Trả lời 06'	,   3			,	'1'		),
                    (N'Trả lời 07'	,   4			,	'0'		),
                    (N'Trả lời 08'	,   8			,	'0'		),
                    (N'Trả lời 09'	,   9			,	'1'		),
                    (N'Trả lời 10'	,   10			,	'1'		);
	
    
INSERT INTO `exam` (`code`,`title`,`categoryID`,`duration`,`creatorID`,`createdate`)
VALUES
					('VTIQ001'		, N'Đề thi C#'			,	1			,	60		,   '5'			,'2019-04-05'),
					('VTIQ002'		, N'Đề thi PHP'			,	10			,	60		,   '2'			,'2019-04-05'),
                    ('VTIQ003'		, N'Đề thi C++'			,	9			,	120		,   '2'			,'2019-04-07'),
                    ('VTIQ004'		, N'Đề thi Java'		,	6			,	60		,   '3'			,'2020-04-08'),
                    ('VTIQ005'		, N'Đề thi Ruby'		,	5			,	120		,   '4'			,'2020-04-10'),
                    ('VTIQ006'		, N'Đề thi Postman'		,	3			,	60		,   '6'			,'2020-04-05'),
                    ('VTIQ007'		, N'Đề thi SQL'			,	2			,	60		,   '7'			,'2020-04-05'),
                    ('VTIQ008'		, N'Đề thi Python'		,	8			,	60		,   '8'			,'2020-04-07'),
                    ('VTIQ009'		, N'Đề thi ADO.NET'		,	4			,	90		,   '9'			,'2020-04-07'),
                    ('VTIQ010'		, N'Đề thi ASP.NET'		,	7			,	90		,   '10'		,'2020-04-08');
                    
    
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
    
-- Question 2: lấy ra tất cả các phòng ban
SELECT * FROM `account` ORDER BY `accountID`;

-- Question 3: lấy ra id của phòng ban "Sale"
SELECT `departmentID` FROM `department` WHERE `name` = 'Sale';

-- Question 4: lấy ra thông tin account có full name dài nhất
SELECT MAX(char_length(`fullname`)) FROM `account`;

-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
SELECT MAX(char_length(`fullname`)) FROM `account` WHERE `departmentID` = 3;
SELECT * FROM `account` WHERE `accountID` = 3 and char_length(`fullname`) = 17;

-- Câu 6: Lấy ra các Group tạo trước ngày 20/12/2019
SELECT `name` FROM `group` WHERE `createdate` < '2019-12-20';

-- Câu 7:
SELECT `question_id` FROM  `answer` GROUP BY `question_id` HAVING count(*) >= 4;

-- Câu 8: 
SELECT `code` FROM `exam` WHERE `duration` >= 60 AND CreateDate < '2019-12-20';

-- Câu 9: 
SELECT * FROM `group` ORDER BY `createdate` DESC limit 5;

-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT count(*) FROM account WHERE `departmentID` = 2;

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT 		`fullname` FROM 		`Account`
WHERE 		(SUBSTRING_INDEX(`fullName`, ' ', -1)) LIKE 'D%o' ;

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
DELETE FROM `exam` WHERE 		CreateDate < '2019-12-20';

-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
DELETE FROM 		`question`
WHERE 		(SUBSTRING_INDEX(`questioncontent`,' ',2)) = 'Câu hỏi';

-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE 		`account` 
SET 		`fullname` 	= 	'Nguyễn Bá Lộc', 
			`email` 		= 	'loc.nguyenba@vti.com.vn'
WHERE 		`accountID` = 5;

-- Question 15: update account có id = 5 sẽ thuộc group có id = 4
UPDATE 		`groupaccount` 
SET 		`accountID` = 5 
WHERE 		`groupID` = 4;
