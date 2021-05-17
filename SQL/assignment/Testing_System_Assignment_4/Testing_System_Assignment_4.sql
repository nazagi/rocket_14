-- Testing System 4
USE testing_system;

-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT 		a.`email`, a.`username`, a.`fullname`, a`position_id`, a.`createdate`, a.`department_id`, d.`departmentname`
FROM		`account` a
LEFT JOIN 	`department`d	ON	a.`departmenr_id` = d.`departmentID`;
-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT		*
FROM		`account`
WHERE		`createdate` < '2020-03-20';

-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT		*
FROM		`account` A 
INNER JOIN 	Position P ON A.`positionID` = P.`positionID`
WHERE		P.`positionname` = 'Dev';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT 		D.`departmentID`, D.`departmentname`, COUNT(A.`departmentID`) AS 'number of departments'
FROM 		`account` A 
INNER JOIN 	`department`  D ON D.`departmentID` = A.`departmentID`
GROUP BY 	A.`departmentID`
HAVING 		COUNT(A.`departmentID`) > 3;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT 
 a.`examID`,
 a.`questionID`,
 b.`questioncontent`,
 count(*) AS total
FROM 
 `examquestion` a
 INNER JOIN `question` b ON a.`questionID` = b.`questionID`
GROUP BY 
 a.`questionID`
HAVING 
 count(*) = (SELECT count(*) FROM `examquestion` GROUP BY `questionID` ORDER BY count(*) DESC limit 1);
 
-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT		cq.`categoryID`, cq.`name`, COUNT(q.`categoryID`) AS 'SO LUONG'
FROM		`categoryquestion` cq 
LEFT JOIN 	`question` q ON cq.`categoryID` = q.`categoryID`
GROUP BY	cq.`categoryID`
ORDER BY	cq.`categoryID`;
-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT		q.`content`, COUNT(eq.`question_id`) AS total_exam
FROM		`question` q 
LEFT JOIN 	`examquestion` eq ON eq.`questionID` = q.`questionID`
GROUP BY	q.`QuestionID`
ORDER BY 	eq.ExamID ASC;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT 
 a.`questionID`,
 a.`questioncontent`,
 count(b.`answerID`) AS total_answer
FROM 
 `question` a
 LEFT JOIN `answer` b ON a.`questionID` = b.`questionID`
GROUP BY 
 a.`questionID`
HAVING 
 total_answer = (SELECT count(`answerID`) FROM `answer` GROUP BY `questionID` ORDER BY count(`answerID`) DESC limit 1);

-- Question 9: Thống kê số lượng account trong mỗi group
SELECT
 a.`groupID`,
 a.`groupname`,
 count(b.`accountID`) AS total_member
FROM
 `group` a
 LEFT JOIN `groupaccount` b ON a.`groupID` = b.`groupID`
GROUP BY 
 a.`groupID`;

-- Question 10: Tìm chức vụ có ít người nhất
SELECT
 a.`positionID`,
 a.`Positionname`,
 count(b.`accountID`) AS total_employee
FROM 
 position a
 LEFT JOIN `account` b ON a.`positionID` = b.`positionID`
GROUP BY 
 a.`positionID`
HAVING 
 total_employee = (SELECT count(`accountID`) FROM account GROUP BY `positionID` ORDER BY count(`accountID`) ASC limit 1);

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT
	a.`fullName`,
	b.`departmentID`,
	b.`departmentname`,
	c.`positionID`,
	c.`positionname`,
 count(*) AS total
FROM
 account a 
 LEFT JOIN `department` b ON a.`departmentID` = b.`departmentID`
 LEFT JOIN position c ON a.`positionID` = c.`positionID`
GROUP BY
 b.`departmentname`, c.`positionname`
ORDER BY
 b.`departmentname`, c.`positionname`;
 
-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
SELECT 		t.`typename` AS 'question type', Q.`creatorID` AS 'creator ID', Q.`questioncontent` AS 'question', A.`answercontent` AS 'answer', Q.`createdate` AS 'createdate'
FROM		`question` Q 
INNER JOIN 	`answer` A ON	Q.`questionID` = A.`questionID`
INNER JOIN	`typequestion` T ON Q.`typeID` = T.`typeID`;

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT		T.`typename` AS 'question type', COUNT(Q.`typeID`) AS 'number of questions'
FROM		`question` Q 
INNER JOIN 	`typequestion` T ON Q.`typeID` = T.`typeID`
GROUP BY	Q.`typeID`;

-- Question 14:Lấy ra group không có account nào
SELECT 		DISTINCT G.`groupname`
FROM 		`group` G
LEFT JOIN 	`groupaccount` GA ON G.`groupID` = GA.`groupID`
WHERE 		GA.`accountID` IS NULL;

-- Question 15: Lấy ra group không có account nào
SELECT		*
FROM		`group` 
WHERE		`groupID`  NOT IN	(SELECT	GroupID FROM GroupAccount);

-- Question 16: Lấy ra question không có answer nào
SELECT		*
FROM		`question`
WHERE		`questionID` NOT IN (SELECT QuestionID FROM	Answer);

-- Exercise 2: Union
/* Question 17:
a) Lấy các account thuộc nhóm thứ 1
b) Lấy các account thuộc nhóm thứ 2
c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau */
-- a) Lấy các account thuộc nhóm thứ 1
SELECT 		GA.`fullname`
FROM 		`account` A
JOIN 		`groupaccount` GA ON A.`accountID` = GA.`accountID`
WHERE 		GA.`groupID` = 1;

-- b) Lấy các account thuộc nhóm thứ 3
SELECT 		A.`fullname`
FROM 		`account` A
JOIN 		`groupaccount` GA ON A.`accountID` = GA.`accountID`
WHERE 		GA.`groupID` = 3;

-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT 		A.`fullname`
FROM 		`account` A
JOIN 		`groupaccount` GA ON A.`accountID` = GA.`accountID`
WHERE 		GA.`groupID` = 1
UNION
SELECT 		A.`fullname`
FROM 		`account` A
JOIN 		`groupaccount` GA ON A.`accountID` = GA.`accountID`
WHERE 		GA.`groupID` = 3;

/*Question 18:
a) Lấy các group có lớn hơn 5 thành viên
b) Lấy các group có nhỏ hơn 7 thành viên
c) Ghép 2 kết quả từ câu a) và câu b) */
-- a) Lấy các group có lớn hơn bằng 3 thành viên 
SELECT 		G.`groupname`, COUNT(1) AS so_luong
FROM 		`group` G
JOIN 		`groupaccount` GA ON G.`groupID` = GA.`groupID`
GROUP BY	GA.`groupID`
HAVING 		so_luong >= 3;

-- b) Lấy các group có nhỏ hơn 7 thành viên 
SELECT 		G.`groupname`, COUNT(1) AS so_luong
FROM 		`group` G
JOIN 		`groupaccount` GA ON G.`groupID` = GA.`groupID`
GROUP BY	GA.`groupID`
HAVING 		so_luong <= 7;

-- c) Ghép 2 kết quả từ câu a) và câu b) 
SELECT 		G.`groupname`, COUNT(1) AS so_luong
FROM 		`group` G
JOIN 		`groupaccount` GA ON G.`groupID` = GA.`groupID`
GROUP BY	GA.`groupID`
HAVING 		so_luong >= 3
UNION
SELECT 		G.`groupname`, COUNT(1) AS so_luong
FROM 		`group` G
JOIN 		`groupaccount` GA ON G.`groupID` = GA.`groupID`
GROUP BY	GA.`groupID`
HAVING 		so_luong <= 7;
