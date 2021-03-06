DROP TRIGGER IF EXISTS insert_block_if1yearprevious
DELIMITER $$
CREATE TRIGGER insert_block_if1yearprevious
BEFORE INSERT ON `group` FOR EACH ROW
BEGIN 
	IF NEW.createdate = CURRENT_DATE - INTERVAL 1 YEAR
	THEN 
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot insert';
	END IF;
END $$
DELIMITER ;

-- Question 2: Tao trigger khong cho phep nguoi dung them bat ki user nao vao department 'Sale' nua, 
-- khi them thi hien ra thong bao 'Department Sale cannot add more user'
DROP TRIGGER IF EXISTS before_accounts_insert_department_sale;
DELIMITER $$
CREATE TRIGGER before_accounts_insert_department_sale
BEFORE INSERT ON `account`
FOR EACH ROW
BEGIN
	DECLARE department_id_sale INT;
    
    SELECT department_id INTO department_id_sale
    FROM departments
    WHERE department_name = 'Sale';
    
    IF NEW.department_id = department_id_sale THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Department Sale cannot add more user';
	END IF;	
END$$
DELIMITER ;

INSERT INTO accounts (email, 	user_name,  full_name, department_id, position_id)
VALUES				 ('test',	'test', 	'test',	   3, 			   1);

-- Question 3: Cau hinh 1 group co nhieu nhat la 5 user
DROP TRIGGER IF EXISTS before_group_account_insert_five_users_at_most_per_group;
DELIMITER $$
CREATE TRIGGER before_group_account_insert_five_users_at_most_per_group
BEFORE INSERT ON group_account
FOR EACH ROW 
BEGIN 
	IF NEW.group_id IN (SELECT group_id FROM (SELECT group_id, COUNT(account_id) AS number_of_accounts
											  FROM group_account
                                              GROUP BY group_id
                                              HAVING number_of_accounts = 5) AS temp) THEN
		SIGNAL SQLSTATE '12345' -- disallow insert this record
		SET MESSAGE_TEXT = 'Max is five users in each group';
    END IF;
END$$
DELIMITER ;

INSERT INTO group_account (group_id, account_id)
VALUES					  (1, 20);

-- Question 4: Cau hinh 1 bai thi co nhieu nhat la 10 question
DROP TRIGGER IF EXISTS before_exam_question_insert_ten_questions_at_most_per_exam;
DELIMITER $$
CREATE TRIGGER before_exam_question_insert_ten_questions_at_most_per_exam
BEFORE INSERT ON exam_question
FOR EACH ROW 
BEGIN 
	IF NEW.exam_id IN (SELECT exam_id FROM (SELECT exam_id, COUNT(question_id) AS number_of_questions
											FROM exam_question
											GROUP BY exam_id
											HAVING number_of_questions = 10) AS temp) THEN
		SIGNAL SQLSTATE '12345' -- disallow insert this record
		SET MESSAGE_TEXT = 'Max is ten questions in each exam';
    END IF;
END$$
DELIMITER ;

-- Question 5: Tao trigger khong cho phep nguoi dung xoa tai khoan co email la admin@gmail.com
-- (day la tai khoan admin, khong cho phep user xoa), con lai cac tai khoan khac thi se
-- cho phep xoa va se xoa tat ca cac thong tin lien quan toi user do
DROP TRIGGER IF EXISTS before_accounts_delete;
DELIMITER $$
CREATE TRIGGER before_accounts_delete 
BEFORE DELETE ON accounts
FOR EACH ROW
BEGIN
	DECLARE v_account_id INT;
    
    SELECT account_id INTO v_account_id
    FROM accounts
    WHERE email = OLD.email;
	
	IF OLD.email = 'admin@gmail.com' THEN
		SIGNAL SQLSTATE '12345' -- disallow delete this record
		SET MESSAGE_TEXT = 'This is Admin account, you can not delete!';
	ELSE 
		DELETE FROM group_account WHERE account_id = v_account_id;
        UPDATE `groups` SET creator_id = NULL WHERE creator_id = v_account_id;
        UPDATE exams SET creator_id = NULL WHERE creator_id = v_account_id;
        UPDATE questions SET creator_id = NULL WHERE creator_id = v_account_id;
    END IF;
END$$
DELIMITER ;

DELETE FROM accounts
WHERE email = 'tfermer0@ucla.edu';

-- Question 6: Khong su dung cau hinh default cho field department_id cua table accounts
-- hay tao trigger cho phep nguoi dung khi tao account khong dien vao department_id
-- thi se duoc phan vao phong ban 'Waiting Room'
DROP TRIGGER IF EXISTS before_accounts_insert;
DELIMITER $$
CREATE TRIGGER before_accounts_insert 
BEFORE INSERT ON accounts
FOR EACH ROW
BEGIN
	DECLARE v_department_id INT;
    
    SELECT department_id INTO v_department_id 
    FROM departments
    WHERE department_name = 'Waiting Room';
    
    IF NEW.department_id IS NULL THEN
		SET NEW.department_id = v_department_id;
	END IF;
END$$
DELIMITER ; 

INSERT INTO accounts (email,   user_name,  full_name,  position_id)
VALUES				 ('test',  'test',     'test',     1);

SELECT * FROM accounts;

-- Question 7: Cau hinh 1 bai thi chi cho phep user tao toi da 4 answers cho moi question
-- trong do co toi da 2 dap an dung
DROP TRIGGER IF EXISTS before_insert_answer;
DELIMITER $$
CREATE TRIGGER before_insert_answer
BEFORE INSERT ON answers
FOR EACH ROW
BEGIN
	DECLARE v_number_of_answers TINYINT;
	DECLARE v_number_of_correct_answers TINYINT;

	SELECT COUNT(a.answer_id) INTO v_number_of_answers
    FROM answers a 
    JOIN questions q ON a.question_id = q.question_id
    WHERE a.question_id = NEW.question_id;
    
    SELECT COUNT(a.answer_id) INTO v_number_of_correct_answers
    FROM answers a 
    JOIN questions q ON a.question_id = q.question_id
    WHERE a.question_id = NEW.question_id AND a.is_correct = 1;
    
    IF v_number_of_answers = 4 THEN
		SIGNAL SQLSTATE '12345' -- disallow insert this record
		SET MESSAGE_TEXT = 'One question has a maximum of 4 answers!';
	END IF;
    
    IF v_number_of_correct_answers = 2 THEN
		SIGNAL SQLSTATE '12345' -- disallow insert this record
		SET MESSAGE_TEXT = 'One question has a maximum of 2 correct answers!';
	END IF;
END$$
DELIMITER ;

INSERT INTO answers (content, 	question_id,  is_correct)
VALUES				('Answer',	4, 			  1);

-- Question 8: Vi???t trigger s???a l???i d??? li???u cho ????ng:
-- N???u ng?????i d??ng nh???p v??o gender c???a account l?? nam, n???, ch??a x??c ?????nh
-- Th?? s??? ?????i l???i th??nh M, F, U cho gi???ng v???i c???u h??nh ??? database
DROP TRIGGER IF EXISTS before_insert_account_reset_gender;
DELIMITER $$
CREATE TRIGGER before_insert_account_reset_gender
BEFORE INSERT ON accounts
FOR EACH ROW
BEGIN
	IF NEW.gender = 'Male' THEN
		SET NEW.gender = 'M';
	ELSEIF NEW.gender = 'Female' THEN
		SET NEW.gender = 'F';
	ELSEIF NEW.gender = 'Unknown' THEN
		SET NEW.gender = 'U';
	END IF;
END$$
DELIMITER ;

INSERT INTO accounts 
(email, 						user_name, 			full_name, 				gender,			department_id, 		position_id) VALUES
('duynguyen@vti.edu.vn', 		'duynguyen', 		'Nguyen Ngoc Duy', 		'Male',			1, 					1		   ),
('mynguyen@vti.edu.vn', 		'mynguyen', 		'Nguyen Thi My', 		'Female',		1, 					1		   ),
('test@vti.edu.vn', 			'test', 			'test', 				'Unknown',		1, 					1		   );

-- Question 9: Vi???t trigger kh??ng cho ph??p ng?????i d??ng x??a b??i thi m???i t???o ???????c 2 ng??y
DROP TRIGGER IF EXISTS before_delete_exam;
DELIMITER $$
CREATE TRIGGER before_delete_exam
BEFORE DELETE ON exams
FOR EACH ROW
BEGIN
    IF OLD.exam_id IN (SELECT exam_id
					   FROM exams
                       WHERE DAY(NOW()) - DAY(create_date) = 2) THEN
		SIGNAL SQLSTATE '12345' -- disallow delete this record
		SET MESSAGE_TEXT = 'This exam was created 2 days ago, you can not delete!';
	END IF;
    
    DELETE FROM exam_question
    WHERE exam_id = OLD.exam_id;
END$$
DELIMITER ;

DELETE FROM exams
WHERE exam_id = 2;

-- Question 10: Vi???t trigger ch??? cho ph??p ng?????i d??ng ch??? ???????c update, delete 
-- c??c question khi question ???? ch??a n???m trong exam n??o
-- Trigger for update
DROP TRIGGER IF EXISTS before_update_question;
DELIMITER $$
CREATE TRIGGER before_update_question
BEFORE UPDATE ON questions
FOR EACH ROW
BEGIN
	IF OLD.question_id IN (SELECT DISTINCT question_id FROM exam_question) 
	OR OLD.question_id IN (SELECT DISTINCT question_id FROM answers) THEN
		SIGNAL SQLSTATE '12345' -- disallow update this record
		SET MESSAGE_TEXT = 'This question exists in exam_question table or answers table or both of them, you can not update!';
	END IF;
END$$
DELIMITER ;

UPDATE questions
SET content = 'a'
WHERE question_id = 5;

-- Trigger for delete
DROP TRIGGER IF EXISTS before_delete_question;
DELIMITER $$
CREATE TRIGGER before_delete_question
BEFORE DELETE ON questions
FOR EACH ROW
BEGIN
	IF OLD.question_id IN (SELECT DISTINCT question_id FROM exam_question) 
	OR OLD.question_id IN (SELECT DISTINCT question_id FROM answers) THEN
		SIGNAL SQLSTATE '12345' -- disallow delete this record
		SET MESSAGE_TEXT = 'This question exists in exam_question table or answers table or both of them, you can not delete!';
	END IF;
END$$
DELIMITER ;

DELETE FROM questions
WHERE question_id = 5;

-- Question 12: L???y ra th??ng tin exam trong ????:
-- Duration <= 30 th?? s??? ?????i th??nh gi?? tr??? "Short time"
-- 30 < Duration <= 60 th?? s??? ?????i th??nh gi?? tr??? "Medium time"
-- Duration > 60 th?? s??? ?????i th??nh gi?? tr??? "Long time"
SELECT `code`, title, duration,
CASE 
	WHEN duration <= 30 THEN 'Short time'
    WHEN 30 < duration <= 60 THEN 'Medium time'
    ELSE 'Long time'
END AS duration_text
FROM exams;

-- Question 13: Th???ng k?? s??? account trong m???i group v?? in ra th??m 1 column n???a 
-- c?? t??n l?? the_number_user_amount v?? mang gi?? tr??? ???????c quy ?????nh nh?? sau:
-- N???u s??? l?????ng user trong group <= 5 th?? s??? c?? gi?? tr??? l?? few
-- N???u s??? l?????ng user trong group <= 20 v?? > 5 th?? s??? c?? gi?? tr??? l?? normal
-- N???u s??? l?????ng user trong group > 20 th?? s??? c?? gi?? tr??? l?? higher
SELECT g.group_name, COUNT(ga.account_id) AS number_of_accounts,
CASE 
	WHEN COUNT(ga.account_id) <= 5 THEN 'few'
    WHEN 5 < COUNT(ga.account_id) <= 20 THEN 'normal'
    ELSE 'higher'
END AS the_number_user_amount
FROM `groups` g
JOIN group_account ga ON g.group_id = ga.group_id
GROUP BY g.group_id;

-- Question 14: Th???ng k?? s??? m???i ph??ng ban c?? bao nhi??u user, 
-- n???u ph??ng ban n??o kh??ng c?? user th?? s??? thay ?????i gi?? tr??? 0 th??nh "Kh??ng c?? user n??o" 
SELECT d.department_name, IF(COUNT(a.account_id) = 0, 'Kh??ng c?? user n??o', COUNT(a.account_id)) AS number_of_accounts
FROM departments d
LEFT JOIN accounts a ON d.department_id = a.department_id
GROUP BY d.department_id;