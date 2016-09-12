use eShop

--Create a simple view
CREATE VIEW vwEmployee
AS
SELECT iEmployeeId, cFirstName, cLastName, cJobTitle, dDateOfJoining
FROM Employee

--Retrieving data using view
SELECT * FROM vwEmployee

--Modify View
ALTER VIEW vwEmployee
AS
SELECT iEmployeeId, cFirstName, cLastName
FROM Employee

--Rename View(SP_RENAME Old_View_Name, New_View_Name)
SP_RENAME vwEmployee, vwEmp

SP_RENAME vwEmp, vwEmployee

--Deleting View
DROP VIEW vwEmployee

--Insert data to base table using view
DROP TABLE TestEmp

CREATE TABLE TestEmp
(
	EmpId int,
	Name char(30)
)

INSERT INTO TestEmp VALUES(1,'A')

SELECT * FROM TestEmp

--Creating view on TestEmp table
CREATE VIEW vwTestEmp
AS
SELECT * FROM TestEmp


SELECT * FROM vwTestEmp

--Using view to insert data to base table
INSERT INTO vwTestEmp
VALUES(2,'B')

--Check base table
SELECT * FROM TestEmp

--Using view to delete data from base table
DELETE FROM vwTestEmp
WHERE EmpId = 2

--Using View to modify data on base table
UPDATE TestEmp
SET Name = 'X'

DROP VIEW vwTestEmp

--Creating view with SCHEMABINDING clause
DROP VIEW vwTestEmp

CREATE VIEW vwTestEmp
WITH SCHEMABINDING
AS
SELECT EmpId, Name FROM dbo.TestEmp

--You can not drop or alter underlying base table TestEmp in a way that would affect view definition
DROP TABLE TestEmp

--Returns the view definition
SP_HELPTEXT vwTestEmp

--Creating view WITH ENCRYPTION
DROP VIEW vwTestEmp2

CREATE VIEW vwTestEmp2
WITH ENCRYPTION
AS
SELECT EmpId, Name FROM TestEmp

--Returns a message - The text for object 'vwTestEmp2' is encrypted.
SP_HELPTEXT vwTestEmp2

--To remove encryption alter the view
Alter VIEW vwTestEmp2
AS
SELECT EmpId, Name FROM TestEmp

--Creating views using WITH CHECK OPTION
DROP VIEW vwTestEmp3

SELECT * FROM TestEmp

CREATE VIEW vwTestEmp3
AS
SELECT EmpId, Name FROM TestEmp WHERE EmpId = 2
WITH CHECK OPTION

SELECT * FROM vwTestEmp3

--Update statement will fail because the view created using WITH CHECK OPTION and the update
--statement will make the data invisible to the view
UPDATE vwTestEmp3
SET EmpId = 3
WHERE Name = 'B'
