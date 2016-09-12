use eShop

SELECT * FROM Employee

SELECT iEmployeeId, cTitle, cFirstName, cLastName
FROM Employee

SELECT iEmployeeId, 
	   cJobTitle AS 'Designation', 
	   dBirthDate AS 'Date of Birth'
FROM Employee

SELECT iProductId, 
	   iUnitPrice, 
	   (iUnitPrice - (iUnitPrice * .1)) AS 'Discounted Price'
FROM Product

SELECT  DISTINCT cJobTitle FROM Employee

SELECT TOP 2 iUnitPrice, cProductName FROM Product
ORDER BY iUnitPrice DESC

SELECT TOP 50 PERCENT iUnitPrice, cProductName FROM Product
ORDER BY iUnitPrice DESC

SELECT DB_ID('eShop')--returns database id

SELECT DB_NAME(10)--returns database name

SELECT @@VERSION--

SELECT iProductId, cProductName, iUnitPrice
FROM Product
WHERE iUnitPrice > 35000

--using Range search conditions
--it returns all values between two specified values
SELECT iProductId, cProductName, iUnitPrice
FROM Product
WHERE iUnitPrice BETWEEN 35000 AND 40000

SELECT iProductId, cProductName, iUnitPrice
FROM Product
WHERE iUnitPrice NOT BETWEEN 35000 AND 40000

SELECT iEmployeeId, cTitle, cFirstName, cCity
FROM Employee
WHERE cCity IN ('Pune','Ahmedabad')

SELECT iEmployeeId, cTitle, cFirstName, cCity
FROM Employee
WHERE cCity NOT IN ('Pune','Ahmedabad')

SELECT iEmployeeId, cTitle, cFirstName, cCity
FROM Employee
WHERE cFirstName LIKE '_a%'

SELECT iEmployeeId, cTitle, cFirstName, cCity
FROM Employee
WHERE cFirstName LIKE 'sa%'

SELECT iEmployeeId, cTitle, cFirstName, cCity
FROM Employee
WHERE cCity LIKE '[a-c]%'

SELECT iEmployeeId, cTitle, cFirstName, cCity
FROM Employee
WHERE cCity LIKE '[^a-c]%'

SELECT COUNT(iProductId) AS "Product Count"
FROM Product

SELECT AVG(iUnitPrice) AS "Average Price"
FROM Product

SELECT MIN(iUnitPrice) AS "Minimum Price"
FROM Product

SELECT MAX(iUnitPrice) AS "Maximum Price"
FROM Product

SELECT SUM(iQuantity) AS "Total Quantity"
FROM Product

SELECT iProductId, SUM(iQuantity) AS "Quantity Sold"
FROM Orders
GROUP BY iProductId
ORDER BY iProductId

select * from Orders

SELECT iProductId, SUM(iQuantity) AS "Quantity Sold"
FROM Orders
GROUP BY iProductId
HAVING SUM(iQuantity) > 2
ORDER BY iProductId

SELECT iProductId, SUM(iQuantity) AS "Quantity Sold"
FROM Orders
WHERE iQuantity > 1
GROUP BY iProductId
HAVING SUM(iQuantity) > 3
ORDER BY iProductId

SELECT iCustomerId, iProductId, SUM(iQuantity) AS "Quantity Sold"
FROM Orders
GROUP BY iCustomerId, iProductId
WITH ROLLUP

SELECT iCustomerId, iProductId, SUM(iQuantity) AS "Quantity Sold"
FROM Orders
GROUP BY iCustomerId, iProductId
WITH CUBE

--Using UNION operator, it will return distinct rows
SELECT cState FROM Employee

SELECT cState FROM Customer


SELECT cState FROM Employee
UNION
SELECT cState FROM Customer

--Using UNION ALL, this will return duplicate rows
SELECT cState FROM Employee
UNION ALL
SELECT cState FROM Customer

--Using EXCEPT operand, it returns values from Query1 - Query2
SELECT cState FROM Employee
EXCEPT
SELECT cState FROM Customer

--Using INTERSECT operand, it returns distinct values common to both the tables
SELECT cState FROM Employee
INTERSECT
SELECT cState FROM Customer

DROP TABLE table1
DROP TABLE table2

CREATE TABLE table1
(ID INT, Value VARCHAR(10))

INSERT INTO Table1 (ID, Value) 
values(1,'First'), (2,'Second'), (3,'Third'), (4,'Fourth'), (5,'Fifth')

select * from Table1

CREATE TABLE table2
(ID INT, Value VARCHAR(10))

INSERT INTO Table2 (ID, Value) 
values(1,'First'),
	(2,'Second'),
	(3,'Third'),
	(6,'Sixth'),
	(7,'Seventh'),
	(8,'Eighth')
select * from table2

SELECT t1.*,t2.*
FROM Table1 t1 INNER JOIN Table2 t2 
ON t1.ID = t2.ID

SELECT t1.*,t2.*
FROM Table1 t1 CROSS JOIN Table2 t2

SELECT t1.*,t2.*
FROM Table1 t1 FULL JOIN Table2 t2 
ON t1.ID = t2.ID

SELECT emp1.iEmployeeId, 
emp1.cFirstName AS "Employee", 
emp2.cFirstName AS "Manager"
FROM Employee AS emp1 INNER JOIN Employee AS emp2
ON emp1.iManagerId = emp2.iEmployeeId

select * from employee

--Sub-Query
SELECT * FROM Orders
WHERE iCustomerId = (SELECT iCustomerId 
FROM Customer 
WHERE cFirstName = 'Anil' AND cLastName = 'Kumble')

SELECT * FROM Orders AS od
JOIN Customer AS cust
ON od.iCustomerId = cust.iCustomerId
WHERE cust.cFirstName = 'Anil' AND cust.cLastName = 'Kumble'

--SQL Server buit-in functions
--string function
SELECT ASCII('A')

SELECT ASCII('BCD')    

--CHAR(n): Converts the given ASCII code to a character.
SELECT CHAR(97)     
 
--CHARINDEX(search exp, string exp [ , start_location ] ): Returns the starting position of the search exp in the string exp which can also be a column name.
SELECT CHARINDEX('O', 'HELLO WORLD')  
SELECT CHARINDEX('O', 'HELLO WORLD', 6)  

 SELECT LEFT('HELLO', 4)    
 
--RIGHT(s, n): Returns the right part of the string with the specified number of characters.
SELECT RIGHT('HELLO', 4)   
 
--SUBSTRING(s, start, length): Returns a part of a string from a string input s starting 
--from a position specified in start(first character 1 not 0), where length is the no of chars to be picked.
 SELECT SUBSTRING('HELLO', 1, 4)  
 SELECT SUBSTRING('HELLO', 4, 2) 
 --LEN(s): Returns the number of characters of the specified string expression, 
--This function includes leading space but excludes trailing white spaces.
 SELECT LEN('HELLO')    
 SELECT LEN(' HELLO')    
 SELECT LEN('HELLO ')   
 
--LOWER(s): Returns a character expression after converting the given character data to lowercase.
 SELECT LOWER('HELLO')   
 
--UPPER(s): Returns a character expression after converting the given character data to uppercase.
 SELECT UPPER('hello') 

 SELECT LEN(LTRIM(' HELLO'))  
 --RTRIM(s): Returns a character expression after it removes trailing blanks.
 SELECT RTRIM('HELLO ') + 'WORLD'  
 
--REPLACE(s1, s2, s3): Replaces all occurrences of the s2 in s1 with s3.
 SELECT REPLACE('HELLO', 'ELLO', 'I') 
 SELECT REPLICATE('HA..', 3)  
 
--REVERSE(s): Returns the reverse of the given string 's'.
 SELECT REVERSE('C++')  

--SPACE(n): Returns a string with specified 'n' number of repeated spaces.
 SELECT 'HELLO' + SPACE(1) + 'WORLD' 
 
--STUFF(s, start, length, replace_str): Replaces specified length of 
--characters from specified starting point with replace_str in the string 's'
 SELECT STUFF('GANDHINAGAR', 1, 1, 'A') 

 --Date Functions
 SELECT GETDATE()
--DAY(date): Returns an integer representing the DAY of the specified date, 
SELECT DAY(GETDATE()) 
SELECT DAY('10/24/78')
--MONTH(date): Returns an integer representing the MONTH of the specified date, 
SELECT MONTH(GETDATE()) 
SELECT MONTH('10/24/78') 
--YEAR(date): Returns an integer representing the YEAR of the specified date.
SELECT YEAR(GETDATE())
SELECT YEAR('10/24/78') 
/*
Datepart--Abbreviations
year=yy, yyyy
quarter=qq, q
month=mm, m
dayofyear=dy, y
day=dd, d
week=wk, ww
weekday=dw
hour=hh
minute=mi, n
second=ss, s
millisecond=ms
*/

SELECT DATENAME(MM, '10/24/78')

SELECT DATENAME(ms, GETDATE())
 
SELECT DATENAME(dd, '10/24/78')

--Adds 30 days to GETDATE(). 
SELECT DATEADD(dd, 30, GETDATE()) 
--–Adds 12 months to GETDATE().
SELECT DATEADD(mm, 12, GETDATE())  
--DATEDIFF(datepart, startdate, enddate): Returns the difference between 
--the start and end dates in the give datepart format. 
SELECT DATEDIFF(yy, '10/24/95', GETDATE())

/*
Conversion Functions
*/
SELECT GETDATE()
--Error, Conversion failed
SELECT 'Current Date and Time : ' + GETDATE()
--Convert using CONVERT() function
SELECT 'Current Date and Time : ' + CONVERT(CHAR(30), GETDATE())
--Convert using CAST() function
SELECT 'Current Date and Time : ' + CAST(GETDATE() AS CHAR(30))

