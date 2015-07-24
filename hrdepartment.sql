DROP DATABASE IF EXISTS hrdepartment;

CREATE DATABASE hrdepartment;

USE hrdepartment;

CREATE TABLE departments
(
	deptId int NOT NULL AUTO_INCREMENT,
	deptName varchar(50) NOT NULL UNIQUE,
	PRIMARY KEY (deptId)
);

CREATE TABLE positions 
(
	posId int NOT NULL AUTO_INCREMENT,
	posName varchar(50) NOT NULL UNIQUE,
	minSalary int NOT NULL,
	maxSalary int NOT NULL,
	PRIMARY KEY (posId)
);

CREATE TABLE employees 
(
	passportId varchar(8) NOT NULL,
	firstName varchar(20) NOT NULL,
	surName varchar(50) NOT NULL,
	birthday date NOT NULL,
	salary int NOT NULL,
	deptId int NOT NULL,
	posName varchar(50) NOT NULL,
	PRIMARY KEY (passportId),
	FOREIGN KEY (deptId) REFERENCES departments (deptId),
	FOREIGN KEY (posName) REFERENCES positions (posName)
);

INSERT INTO departments (deptName)
VALUES ('Accounting'), 
	('Development'),
	('Human Resources'),
	('Public Relations'),
	('Quality Assurance');
	
INSERT INTO positions (posName, minSalary, maxSalary)
VALUES ('PR Manager', 500, 2000),
	('HR Manager', 500, 2000),
	('Dev Senior', 1500, 3000),
	('Dev Middle', 1000, 1500),
	('Dev Junior', 600, 1000),
	('QA Senior', 1400, 2500),
	('QA Middle', 800, 1350),
	('QA Junior', 600, 800),
	('Accountant', 500, 1500),
	('Bookkeeper', 500, 1500),
	('General Director', 5000, 5000);
	
INSERT INTO employees (passportId, firstName, surName, birthday, salary, deptId, posName)
VALUES ('ME222413', 'Aaron', 'Jones', '1986-03-20', 2400, 2, 'Dev Senior'),
	('ME231231', 'Adele', 'Wiliams', '1990-05-12', 2500, 2, 'Dev Senior'),
	('PM252354', 'Andrew', 'Brown', '1980-01-21', 3000, 2, 'Dev Senior'),
	('ME224352', 'Steve', 'Wiliams', '1985-04-05', 1500, 2, 'Dev Middle'),
	('ME876055', 'Tomas', 'Harris', '1989-11-08', 1100, 2, 'Dev Middle'),
	('PP757438', 'Henry', 'Beckon', '1988-12-30', 1300, 2, 'Dev Middle'),
	('DS104765', 'Bob', 'Clark', '1980-06-16', 800, 2, 'Dev Junior'),
	('EM717413', 'Ben', 'Kent', '1987-04-06', 800, 2, 'Dev Junior'),
	('ME993940', 'Igor', 'Lewis', '1991-09-25', 800, 2, 'Dev Junior'),
	('EE746381', 'Stephen', 'King', '1990-08-18', 2000, 5, 'QA Senior'),
	('ME100232', 'Kortney', 'Dundee', '1992-02-29', 1500, 4, 'PR Manager'),
	('ET561231', 'Sarah', 'Connors', '1985-07-20', 2000, 3, 'HR Manager'),
	('MF743800', 'Jim', 'Jim', '1985-07-03', 2000, 5, 'QA Senior'),
	('EP245672', 'Leyla', 'Watson', '1986-05-03', 2000, 5, 'QA Senior'),
	('EP243524', 'Bertie', 'Stephenson', '1982-03-15', 1300, 1, 'Bookkeeper'),
	('EP879547', 'Noah', 'Watson', '1981-05-09', 1200, 5, 'QA Middle'),
	('TR395724', 'Stew', 'Penchovski', '1988-01-07', 1200, 5, 'QA Middle'),
	('EP234351', 'Melinda', 'Mandinda', '1989-03-20', 1200, 5, 'QA Middle'),
	('AA123841', 'Mettew', 'Perry', '1977-12-31', 700, 5, 'QA Junior'),
	('AB847462', 'Nina', 'Kalina', '1990-04-20', 700, 5, 'QA Junior'),
	('AB324113', 'Emmy', 'Watson', '1987-02-20', 1400, 1, 'Accountant'),
	('MT771431', 'Igor', 'Presnyakov', '1986-07-22', 1500, 1, 'Accountant'),
	('NY478532', 'Jessey', 'Spenser', '1990-03-20', 700, 5, 'QA Junior'),
	('PO777777', '777777', '77777', '1991-07-01', 5000, 2, 'General Director'); 	
	
	



















