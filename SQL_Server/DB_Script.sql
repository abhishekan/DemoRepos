--Delete Database
DROP DATABASE eShop

--Creating database MyDB
CREATE DATABASE eShop

--Selecting Database
Use eShop

--Creating Department table
CREATE TABLE Department
(
	iDepartmentId INT IDENTITY(1,1) NOT NULL,
	cDepartmentName CHAR(30) NOT NULL,
	CONSTRAINT pkDeptId PRIMARY KEY (iDepartmentId)
)

DROP TABLE Department

--Inserting data into Department table
INSERT INTO Department VALUES('HR')
INSERT INTO Department VALUES('IT')
INSERT INTO Department VALUES('Sales')
INSERT INTO Department VALUES('Training')


--View Data from Department table
SELECT * FROM Department

--Creating Employee table
DROP TABLE Employee

CREATE TABLE Employee
(
	iEmployeeId INT IDENTITY(1,1) NOT NULL,
	cTitle CHAR(4),
	cFirstName CHAR(30) NOT NULL,
	cLastName CHAR(30) NOT NULL,
	cJobTitle CHAR(30),
	iManagerId INT,
	dBirthDate DATE,
	dDateOfJoining DATE,
	iPhone BIGINT,
	vEmail VARCHAR(100),
	vAddress VARCHAR(200),
	cCounty CHAR(30),
	cState CHAR(30),
	cCity CHAR(30),
	iSalary INT,
	iDepartmentId INT,
	CONSTRAINT pkEmpId PRIMARY KEY(iEmployeeId),
	CONSTRAINT fkDeptId FOREIGN KEY(iDepartmentId) REFERENCES Department(iDepartmentId)
)

--Inserting data into Employee table
INSERT INTO Employee
VALUES('Mr.','Sachin','Patel','Software Engineer',NULL,'1990-09-29',GETDATE(),9526541523,'abc@gmail.com','29/1 M.G.Road','India','Gujarat','Ahmedabad',20000,1)
INSERT INTO Employee
VALUES('Mr.','Samir','Joshi','Software Engineer',1,'1989-07-21',GETDATE(),9856891235,'samirjoshi@hotmail.com','2/B C.G.Road','India','Maharashtra','Pune',25000,2)
INSERT INTO Employee
VALUES('Mr.','Gargi','Mukherjee','Software Engineer',1,'1989-07-21',GETDATE(),9856891235,'samirjoshi@hotmail.com','2/B C.G.Road','India','West Bengal','Kolkata',30000,1)
INSERT INTO Employee
VALUES('Mr.','Sarthak','Meheta','Software Engineer',1,'1989-07-21',GETDATE(),9856891235,'samirjoshi@hotmail.com','2/B C.G.Road','India','Tamil Nadu','Chennai',35000,3)
INSERT INTO Employee
VALUES('Mr.','Bhumika','Kakani','Software Engineer',2,'1989-07-21',GETDATE(),9856891235,'samirjoshi@hotmail.com','2/B C.G.Road','India','Karnataka','Bengaluru',40000,2)
INSERT INTO Employee(cTitle,cFirstName,cLastName,cJobTitle,iManagerId)
VALUES('Mr.','Mehul','Baghela','Software Engineer',2)

--View Data from Employee table
SELECT * FROM Employee

--Creating Customer table
CREATE TABLE Customer
(
	iCustomerId INT IDENTITY(1,1) NOT NULL,
	cTitle CHAR(4),
	cFirstName CHAR(30),
	cLastName CHAR(30),
	dBirthDate DATE,
	iPhone BIGINT,
	vEmail VARCHAR(100),
	vAddress VARCHAR(200),
	cCounty CHAR(30),
	cState CHAR(30),
	cCity CHAR(30),
	dRegistrationDate DATETIME,
	CONSTRAINT pkCustId PRIMARY KEY(iCustomerId)
)

--Inserting data into Customer table
INSERT INTO Customer
VALUES('Ms.','Asha','Godbole','1982-11-29',9625364512,'ashag@gmail.com','1/2 Chandni Chowk','India','Delhi','Delhi',GETDATE())
INSERT INTO Customer
VALUES('Mr.','Anil','Sharma','1972-10-21',9254581278,'anilsharma@gmail.com','5/6 Prince Town','India','Andhra Pradesh','Hyderabad',GETDATE())
INSERT INTO Customer
VALUES('Mr.','Anil','Kumble','1972-10-21',9254581278,'anilk@gmail.com','5/6 Prince Town','India','Maharashtra','Pune',GETDATE())
INSERT INTO Customer
VALUES('Mr.','Sachin','Tendulkar','1972-10-21',9254581278,'sachint@gmail.com','5/6 Prince Town','India','Karnataka','Bengaluru',GETDATE())
INSERT INTO Customer
VALUES('Mr.','Sunil','Gavaskar','1972-10-21',9254581278,'sachint@gmail.com','5/6 Prince Town','India','Maharashtra','Mumbai',GETDATE())

--View data from Customer table
SELECT * FROM Customer

--Creating Product table
CREATE TABLE Product
(
	iProductId INT IDENTITY(1,1) NOT NULL,
	cProductName CHAR(30) NOT NULL,
	iUnitPrice INT,
	iQuantity INT,
	CONSTRAINT pkProdId PRIMARY KEY(iProductId)
)

--Inserting Data into Product table
INSERT INTO Product VALUES('Samsung Galaxy S3',35000,10)
INSERT INTO Product VALUES('Samsung Galaxy Grand',21000,30)
INSERT INTO Product VALUES('iPhone 4',40000,70)
INSERT INTO Product VALUES('iPhone 5',45000,20)

--View data from Product
SELECT * FROM Product
SELECT * FROM Customer

drop table orders

--Creating Orders table
CREATE TABLE Orders
(
	iOrderId INT IDENTITY(1,1) NOT NULL,
	iCustomerId INT NOT NULL,
	iProductId INT NOT NULL,
	iUnitPrice INT NOT NULL,
	iQuantity INT NOT NULL,
	iTotalPrice INT NULL,
	dOrderDate DATETIME,
	dShipDate DATETIME,
	vShipAddress VARCHAR(200),
	cShipStatus CHAR(30),	
	CONSTRAINT pkOrderId PRIMARY KEY(iOrderId),	
	CONSTRAINT fkCustId FOREIGN KEY(iCustomerId) REFERENCES Customer(iCustomerId),
	CONSTRAINT fkProdId2 FOREIGN KEY(iProductId) REFERENCES Product(iProductId)
)

--Insert queries should be updated according to table structure
--Inserting data into Orders table
INSERT INTO Orders
VALUES(3, 1, 35000, 1, 35000, '2010-12-22','2010-12-27','21/1 Prince Street, Mumbai','Delivered')
INSERT INTO Orders
VALUES(3, 2, 21000, 2, 42000, '2011-11-21','2011-11-26','1/2 Shivangi Nagar, Mumbai','Delivered')
INSERT INTO Orders
VALUES(1, 4, 45000, 1, 45000, '2011-11-13','2011-11-18','22 Shivaji Nagar, Bengaluru','Delivered')
INSERT INTO Orders
VALUES(5, 3, 40000, 3, 120000, '2011-11-13','2011-11-18','22 Shivaji Nagar, Pune','Delivered')
INSERT INTO Orders
VALUES(5, 1, 35000, 1, 35000, '2011-11-13','2011-11-18','22 Shivaji Nagar, Pune','Delivered')
INSERT INTO Orders
VALUES(5, 2, 21000, 2, 42000, '2011-11-13','2011-11-18','22 Shivaji Nagar, Pune','Delivered')

