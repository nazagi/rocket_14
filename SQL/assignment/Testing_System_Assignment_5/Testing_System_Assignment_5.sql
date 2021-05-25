USE testing_system;

-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
CREATE OR REPLACE VIEW vw_DSNV_Sale
AS
	SELECT		A.*, D.`departmentname`
	FROM 		`account` A 
	INNER JOIN 	`department` D ON A.`departmentID` = D.`departmentID`
	WHERE		D.`departmentname` = 'Sale';

SELECT 	* 
FROM 	vw_DSNV_Sale;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
CREATE OR REPLACE VIEW vw_InfAccountMaxGroup
AS
SELECT 		A.*, COUNT(GA.AccountID) AS 'SO LUONG'
FROM		`account` A 
INNER JOIN 	`groupaccount` GA ON A.`accountID` = GA.`accountID`
GROUP BY	A.`accountID`
HAVING		COUNT(GA.`accountID`) = (
									SELECT 		COUNT(GA.`accountID`) 
									FROM		`account` A 
									INNER JOIN 	`groupaccount` GA ON A.`accountID` = GA.`accountID`
									GROUP BY	A.`accountID`
									ORDER BY	COUNT(GA.`accountID`) DESC
									LIMIT		1
								  );
								  
SELECT 	* 
FROM 	vw_InfAccountMaxGroup;

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 18 từ được coi là quá dài) và xóa nó đi (De cu la 300 tu nhung do thiet ke db tu dau nen sua lai 18 tu de demo
CREATE OR REPLACE VIEW vw_ContentTren18Tu
AS
	SELECT 	LENGTH(`questioncontent`)
	FROM	`question`
	WHERE	LENGTH(`questioncontent`) > 18;
	
SELECT 	* 
FROM 	vw_ContentTren18Tu;


-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
CREATE OR REPLACE VIEW vw_DepartmentMaxAccount
AS
	SELECT 		D.*, COUNT(A.`departmentID`)
	FROM		`department` D 
	INNER JOIN 	`account` A ON D.`departmentID` = A.`departmentID`
	GROUP BY	D.`departmentID`
	HAVING		COUNT(A.`departmentID`) = (
										SELECT 		COUNT(A.`departmentID`)
										FROM		`department` D 
										INNER JOIN 	`account` A ON D.`departmentID` = A.`departmentID`
										GROUP BY	D.`departmentID`
										HAVING		COUNT(A.`departmentID`)
										ORDER BY	COUNT(A.`departmentID`) DESC
										LIMIT		1
										);
										
SELECT 	* 
FROM 	vw_DepartmentMaxAccount;

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
CREATE OR REPLACE VIEW vw_QuesHoNguyen
AS
	SELECT 		Q.*, A.`fullName`
	FROM 		`question` Q 
	INNER JOIN 	`account` A ON Q.`creatorID` = A.`accountID`
	WHERE		SUBSTRING_INDEX(`fullName`,' ',1) = 'Nguyen';

SELECT 	* 
FROM 	vw_QuesHoNguyen;

