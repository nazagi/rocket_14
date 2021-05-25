DROP DATABASE IF EXISTS exercise1;
CREATE DATABASE IF NOT EXISTS exercise1;
USE exercise1;

CREATE TABLE trainee
(
	`id`				SMALLINT auto_increment PRIMARY KEY,
    `name`				VARCHAR(50) NOT NULL,
    `dob`				DATE NOT NULL,
    `gender`			ENUM('male', 'female', 'unknown'),
    `et_iq`				INT NOT NULL DEFAULT'0' CHECK(0 <= `et_iq` <= 20),
    `et_gmath`			INT NOT NULL DEFAULT'0' CHECK(0 <= `et_gmath` <= 20),
	`et_english`		INT NOT NULL DEFAULT'0' CHECK(0 <= `et_english` <= 50),
    `training_class`	INT NOT NULL,
    `evaluation_notes` 	CHAR(50)
);

ALTER TABLE trainee
	ADD `VTI_account`	CHAR(100) NOT NULL
    AFTER `gender`;

-- Question 1: Add at least 10 records into created table    
    INSERT INTO trainee (`name`, `dob`, `gender`,`VTI_account`,`et_iq`,`et_gmath`,`et_english`,`training_class`,`evaluation_notes`)
    VALUES
					('Nguyễn hải Đăng1'				,   '2020-01-01'		,   'male'		,	'haidang29productions@gmail.com',	 '12',	 '10',	'25',	'1',	'abcd'	),
					('Nguyễn hải Đăng2'				,   '2020-02-02'		,   'female'	,	'haidang20productions@gmail.com',	 '15',	 '10',	'50',	'2',	'azmx'	),
                    ('Nguyễn hải Đăng3'				,   '2020-03-03'		,   'male'		,	'haidang21productions@gmail.com',	 '20',	 '19',	'42',	'3',	'asks'	),
                    ('Nguyễn hải Đăng4'				,   '2020-04-04'		,   'male'		,	'haidang23productions@gmail.com',	 '05',	 '18',	'30',	'5',	'slsk'	),
                    ('Nguyễn hải Đăng5'				,   '2020-04-05'		,   'female'	,	'haidang24productions@gmail.com',	 '18',	 '15',	'20',	'4',	'vfgi'	),
                    ('Nguyễn hải Đăng6'				,   '2020-05-06'		,   'male'		,	'haidang25productions@gmail.com',	 '17',	 '16',	'15',	'1',	'ckbn'	),
                    ('Nguyễn hải Đăng7'				,   '2020-06-07'		,   'unknown'	,	'haidang26productions@gmail.com',	 '18',	 '18',	'40',	'2',	'skbn'	),
                    ('Nguyễn hải Đăng8'				,   '2020-06-08'		,   'male'		,	'haidang27productions@gmail.com',	 '19',	 '17',	'46',	'4',	'skmb'	),
                    ('Nguyễn hải Đăng9'				,   '2020-01-09'		,   'female'	,	'haidang22productions@gmail.com',	 '20',	 '20',	'45',	'5',	'qofm'	),
                    ('Nguyễn hải Đăng10'			,   '2020-02-10'		,   'male'		,	'haidang28productions@gmail.com',	 '14',	 '15',	'37',	'1',	'prti'	);
                    
-- Question 2: Query all the trainees who is passed the entry test, group them into different birth months
SELECT * 
FROM trainee
GROUP BY EXTRACT(MONTH FROM `dob`);

-- Question 3: Query the trainee who has the longest name, showing his/her age along with his/her basic information (as defined in the table)
SELECT *, MAX(char_length(`name`)) FROM trainee;
/* Question 4: Query all the ET-passed trainees. One trainee is considered as ET-passed when he/she has the entry test points satisfied below criteria:
 ET_IQ + ET_Gmath>=20
 ET_IQ>=8
 ET_Gmath>=8
 ET_English>=18 */


-- Question 5: delete information of trainee who has TraineeID = 3
-- Question 6: trainee who has TraineeID = 5 move "2" class. Let update information into database
