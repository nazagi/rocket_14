DROP DATABASE IF EXISTS exercise1;
CREATE DATABASE IF NOT EXISTS exercise1;
USE exercise1;

CREATE TABLE trainee
(
	`id`				SMALLINT auto_increment PRIMARY KEY,
    `name`				VARCHAR(50) NOT NULL,
    `dob`				DATE NOT NULL,
    `gender`			ENUM('Male', 'Female', 'Unknown'),
    `et_iq`				INT NOT NULL DEFAULT'0' CHECK(0 <= `et_iq` <= 20),
    `et_gmath`			INT NOT NULL DEFAULT'0' CHECK(0 <= `et_gmath` <= 20),
	`et_english`		INT NOT NULL DEFAULT'0' CHECK(0 <= `et_english` <= 50),
    `training_class`	CHAR(20),
    `evaluation_notes` 	CHAR(100)
);

ALTER TABLE trainee
	ADD `VTI_accounnt`	CHAR(100) UNIQUE NOT NULL
    AFTER `gender`;