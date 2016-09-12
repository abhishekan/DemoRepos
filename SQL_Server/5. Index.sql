CREATE DATABASE TestDB

USE TestDB

--Creating a Product table
DROP TABLE Product


CREATE TABLE Product
(
	ProductId INT IDENTITY(1,1),
	ProductName CHAR(30),
	UnitPrice INT
)

CREATE TABLE Customer
(
	CustomerId INT,
	CustomerName CHAR(30),
	Phone INT
)

--Create a unique clustered index
CREATE UNIQUE CLUSTERED INDEX uciProductId
ON Product(ProductId)

--Creating nonclustered index
CREATE NONCLUSTERED INDEX nciProductName
ON Product(ProductName)

--View all indexes created on a table
SP_HELPINDEX Product

--Creating nonclustered Composite index
CREATE INDEX idxUnitPriceProductName
ON Product(UnitPrice, ProductName)

--Create Unique index
CREATE UNIQUE INDEX uidxCustomerPhone
ON Customer(Phone)

--Rename an index
SP_RENAME 'Product.uciProductId','uciIdxProductId'

--Delete an index
DROP INDEX Product.uciIdxProductId

DROP INDEX Product.uciProductId
