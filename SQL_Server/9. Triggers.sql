--Creating Triggers
USE eShop

DROP TRIGGER trgDenyDMLOperations

--Creating trigger to prevent DML operaion on Employee table
CREATE TRIGGER trgDenyDMLOperations
ON Employee
FOR INSERT, UPDATE, DELETE
AS
	PRINT 'You are not authorized to change data'
	ROLLBACK

--Try DML operation
DELETE FROM Employee

INSERT INTO Employee(cFirstName,cLastName)
VALUES('Sri','Sant')

UPDATE Employee
SET cFirstName = 'Saurav'
WHERE iEmployeeId = 1

select * from Employee

DROP TRIGGER trgDenyDMLOperations2

CREATE TRIGGER trgDenyDMLOperations2
ON Employee
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	PRINT 'trgDenyDMLOperations2 executing...'
	PRINT 'You are not authorized to change data'
	ROLLBACK
END

--INSTEAD OF Trigger

CREATE TRIGGER trgDenyDMLOperations3
ON Employee
INSTEAD OF INSERT, UPDATE, DELETE
AS
BEGIN
	PRINT 'trgDenyDMLOperations3 executing...'
	PRINT 'You are not authorized to change data'
	ROLLBACK
END

--Writing a trigger that will insert data into history table if an employee deleted from Employee table
use TestDB

create table EmployeeHistory
(
	EmployeeId int primary key,
	Name char(20),
	City char(20),
	DepartmentId int
)

CREATE TRIGGER AddToEmployeeHistory
ON Employee
FOR DELETE
AS
BEGIN
DECLARE @empid INT, 
		@name CHAR(30), 
		@city CHAR(30), 
		@deptid INT
SELECT @empid = EmployeeID, 
	   @name = Name, 
	   @city = City, 
	   @deptid = DepartmentID
FROM DELETED

INSERT INTO EmployeeHistory
VALUES(@empid, @name, @city, @deptid)
PRINT 'Employee added to History table'
END

select * from Employee

select * from EmployeeHistory

DELETE FROM Employee
WHERE EmployeeID = 23

--Writing custom check constraint using trigger
ALTER TRIGGER CheckEmployeeCity
ON Employee
FOR UPDATE, INSERT
AS
BEGIN
DECLARE @city CHAR(30)
--for insert command
SELECT @city = City FROM inserted

IF @city != 'Pune' AND @city != 'GNR' AND @city != 'HYd'
BEGIN
	ROLLBACK
	PRINT 'Invalid city, statement is terminated'
END
END

sp_help Employee

ALTER TABLE Employee
DROP chkCity

SELECT * FROM Employee

INSERT INTO Employee(Name, City)
VALUES('Rahul', 'Bangalore')

INSERT INTO Employee(Name, City)
VALUES('Rohan', 'Pune')


/*
--Enable or Disable Trigger
ALTER TABLE Employee Disable TRIGGER trgDenyDMLOperations

ALTER TABLE Employee Enable TRIGGER trgDenyDMLOperations