--Creating User-Defined Functions
USE eShop

--Creating a Scalar function that will accept date and returns a single value that is month
CREATE FUNCTION udfGetMonth(@Date DATETIME)
RETURNS INT
AS
BEGIN
	RETURN DATEPART(MONTH, @Date)
END

--Calling a scalar function: Syntax must contain schema.functionName
SELECT dbo.udfGetMonth(GETDATE()) AS 'Month'


--Scalar function
use MyDB

--Writing expression(deducting 2 LWP to calculate net salary this month)
--Net Salary = (Gross Monthly Salary / No. of working days) * No. of payable days
SELECT iEmployeeID, cFirstName, iSalary AS 'Gross Salary', 
		((iSalary / 22) * 20) AS 'Net Salary'
FROM Employee

create function dbo.GetNetSalry(@Salary int)
returns int
as
begin
	return ((@Salary / 22) * 20)
end


--calling function
select dbo.GetNetSalry(10000) as 'Net Salary'

SELECT iEmployeeID, cFirstName, iSalary AS 'Gross Salary', 
		dbo.GetNetSalry(iSalary) as 'Net Salary'
FROM Employee


--Creating table valued function
CREATE FUNCTION dbo.GetProductById(@ProductId INT)
RETURNS TABLE
AS
RETURN
(
SELECT * FROM PRODUCT WHERE iProductId = @ProductId
);

--Calling a table-valued function
SELECT * FROM dbo.GetProductById(1)

--Cannot Create a function without input parameter
--Cannot use DML statements in a function
--Cannot use TRY..CATCH in UDF
CREATE FUNCTION dbo.GetCustomer (@CustomerId INT, @LastName CHAR(30))
RETURNS CHAR(30)
AS
BEGIN
DECLARE @FirstName CHAR(30)
BEGIN TRY
SELECT 1/0;
END TRY
BEGIN CATCH
PRINT 'Error'
END CATCH
UPDATE Customer SET cFirstName = 'Bipasha' WHERE iCustomerId = @CustomerId
DELETE FROM Customer WHERE iCustomerId = @CustomerId
INSERT INTO Customer(cFirstName,cLastName) VALUES('Abhi','Bhai')
SELECT @FirstName = cFirstName FROM Customer WHERE iCustomerId = @CustomerId
RETURN @FirstName
END

SELECT dbo.GetCustomer(1,'Godbole')

DROP FUNCTION udfGetMonth
DROP FUNCTION dbo.GetProductById
