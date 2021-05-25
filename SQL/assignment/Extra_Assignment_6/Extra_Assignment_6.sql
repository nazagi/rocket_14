/*
a, Create the tables (with the most appropriate field/column constraints &
types) and add at least 3 records into each created table.
*/
DROP DATABASE IF EXISTS extra6;
CREATE DATABASE IF NOT EXISTS extra6;
USE extra6;

CREATE TABLE IF NOT EXISTS Projects (
    ProjectID INT PRIMARY KEY AUTO_INCREMENT,
    ProjectName VARCHAR(255),
    ProjectStartDate DATE,
    ProjectDescription VARCHAR(255),
    ProjectDetail VARCHAR(255),
    ProjectCompletedOn DATE
);

CREATE TABLE IF NOT EXISTS Project_Modules (
    ModuleID INT PRIMARY KEY AUTO_INCREMENT,
    ProjectID INT,
    ProjectModulesDate DATE,
    ProjectModulesCompletedOn DATE,
    ProjectModulesDescription VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Work_Done (
    WorkDoneID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    ModuleID INT,
    WorkDoneDate DATE,
    WorkDoneDescription VARCHAR(255),
    WorkDoneStatus BIT
);

create table if not exists Employee (
	EmployeeID int primary key auto_increment,
    EmployeeLastName varchar(255),
    EmployeeFirstName varchar(255),
    EmployeeHireDate Date,
    EmployeeStatus bit,
    SuperVisorID int,
    SocialSercurityNumber int
);

ALTER TABLE Work_Done 
ADD CONSTRAINT Work_Done_Employee_FK FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID) ON DELETE CASCADE;

ALTER TABLE Work_Done 
ADD CONSTRAINT Work_Done_ProjectModule_FK FOREIGN KEY (ModuleID) REFERENCES Project_Modules (ModuleID) ON DELETE CASCADE;

ALTER TABLE Project_Modules 
ADD CONSTRAINT Project_Modules_Projects_FK FOREIGN KEY (ProjectID) REFERENCES Projects (ProjectID) ON DELETE CASCADE;

ALTER TABLE Employee 
ADD CONSTRAINT Employee_Employee_FK FOREIGN KEY (SuperVisorID) REFERENCES Employee (EmployeeID) ON DELETE CASCADE;

INSERT INTO Employee (`EmployeeLastName`, `EmployeeFirstName`, `EmployeeHireDate`, `EmployeeStatus`, `SuperVisorID`, `SocialSercurityNumber`) 
VALUES 
	('Nam', 'Nguyen Phuong', '2018/1/1', b'1', NULL, 1),
    ('Vu', 'Nguyen Ba', '2019/3/2', b'1', 1, 2),
    ('Quang', 'Nguyen Minh', '2019/2/10', b'1', 1, 3);
INSERT INTO Projects (`ProjectName`, `ProjectStartDate`, `ProjectDescription`, `ProjectDetail`, `ProjectCompletedOn`)
VALUES 
	('Lashinbang', '2018/3/10', 'Documentation OCR', 'Documentation OCR use Computer Vision', '2019/1/1'),
    ('Paddock', '2019/9/15', 'Horse Tracking', 'Tracking horses in the paddock use Computer Vision', '2019/2/19'),
    ('BoomTV', '2019/12/1', 'Boom Web', 'Develop game steaming web', NULL);
INSERT INTO Project_Modules (`ProjectID`, `ProjectModulesDate`, `ProjectModulesCompletedOn`, `ProjectModulesDescription`)
VALUES 
		('1', '2018/3/10', '2018/5/10', 'Lashinbang module 1'),
		('1', '2018/5/10', '2019/1/1', 'Lashinbang module 2'),
		('2', '2019/9/15', '2019/1/10', 'Paddock module 1'),
		('2', '2019/1/10', '2019/2/19', 'Paddock module 2'),
		('3', '2019/12/1', '2020/3/1', 'BoomTV module 1'),
		('3', '2020/3/1', '2020/12/31', 'BoomTV module 2'),
		('3', '2020/12/31', NULL, 'BoomTV module 3');
INSERT INTO Work_Done (`EmployeeID`, `ModuleID`, `WorkDoneDate`, `WorkDoneDescription`, `WorkDoneStatus`)
VALUES 
('1', '1', NULL, NULL, b'1'),
('1', '1', NULL, NULL, b'1'),
('1', '1', NULL, NULL, b'1'),
('1', '1', NULL, NULL, b'1'),
('1', '1', NULL, NULL, b'1'),
('2', '2', NULL, NULL, b'1'),
('2', '2', NULL, NULL, b'1'),
('2', '3', NULL, NULL, b'1'),
('3', '3', NULL, NULL, b'1'),
('3', '3', NULL, NULL, b'1'),
('3', '1', NULL, NULL, b'1');