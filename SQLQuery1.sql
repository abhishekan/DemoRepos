-- Create Database
CREATE DATABASE BookStoreDB
USE BookStoreDB

--Author Table
CREATE TABLE AUTHOR(
	AuthorId int IDENTITY(1,1) NOT NULL,
	AuthorName char(50), 
	DateOfBirth date,
	State char(50),
	City char(50),
	Phone bigint 
)

ALTER TABLE AUTHOR ADD CONSTRAINT pk_authorId PRIMARY KEY (AuthorId)

SELECT * FROM AUTHOR

INSERT INTO AUTHOR(AuthorName, DateOfBirth, State, City, Phone) VALUES('Abhishek', '04-01-1994', 'Maharashtra', 'Pune', 8485028926)
INSERT INTO AUTHOR(AuthorName, DateOfBirth, State, City, Phone) VALUES('Omkar', '04-01-1994', 'Maharashtra', 'Thane', 9730612333)




--Publisher table

CREATE TABLE PUBLISHER(
	PublisherId int IDENTITY(1,1) NOT NULL,
	PublisherName char(50),
	DateOfBirth date,
	State char(50),
	City char(50),
	Phone bigint 
)	
ALTER TABLE PUBLISHER ADD CONSTRAINT pk_publisherId PRIMARY KEY (PublisherId)

INSERT INTO PUBLISHER(PublisherName, DateOfBirth, State, City, Phone) VALUES('TechMax', '01-08-1993', 'Maharashtra', 'Thane', 9730612333)
INSERT INTO PUBLISHER(PublisherName, DateOfBirth, State, City, Phone) VALUES('Technical', '09-08-1992', 'Punjab', 'Chandigarh', 8485028926)
INSERT INTO PUBLISHER(PublisherName, DateOfBirth, State, City, Phone) VALUES('Nirali', '07-01-1999', 'Andhra Pradesh', 'Banglore', 7285028926)

SELECT * FROM PUBLISHER 





--Junction Table (BOOK_AUTHOR)

CREATE TABLE BOOK_AUTHOR(
	Bid int NOT NULL,
	Aid int NOT NULL,
)
ALTER TABLE BOOK_AUTHOR ADD CONSTRAINT pk_book_author PRIMARY KEY (Bid, Aid)

ALTER TABLE BOOK_AUTHOR ADD CONSTRAINT fk_BookId FOREIGN KEY(Bid) REFERENCES BOOK(BookId)
ALTER TABLE BOOK_AUTHOR ADD CONSTRAINT fk_AuthorId FOREIGN KEY(Aid) REFERENCES AUTHOR(AuthorId)

INSERT INTO BOOK_AUTHOR(Bid, Aid) VALUES(2, 2)
 
SELECT * FROM BOOK_AUTHOR



--Category Table
CREATE TABLE CATEGORY(
	CategoryId int IDENTITY(1,1) NOT NULL,
	Categoryname char(50),
	Description char(50)
)
ALTER TABLE CATEGORY ADD CONSTRAINT pk_categoryId PRIMARY KEY (CategoryId)

INSERT INTO CATEGORY(Categoryname, Description) VALUES('Technical', 'Technical_Description')
INSERT INTO CATEGORY(Categoryname, Description) VALUES('Management', 'Management_Description')

SELECT * FROM CATEGORY



--Book Table
CREATE TABLE BOOK(
	BookId int IDENTITY(1,1) NOT NULL,
	Title char(50),
	Description char(50),
	Price bigint,
	ISBN bigint,
	PublicationDate date,
	Image char(100)

)
ALTER TABLE BOOK ADD CONSTRAINT pk_bookId PRIMARY KEY (BookId)

ALTER TABLE BOOK ADD B_Cid int 
ALTER TABLE BOOK ADD B_Pid int 

ALTER TABLE BOOK ADD CONSTRAINT fk_B_Cid FOREIGN KEY(B_Cid) REFERENCES CATEGORY(CategoryId)
ALTER TABLE BOOK ADD CONSTRAINT fk_B_Pid FOREIGN KEY(B_Pid) REFERENCES PUBLISHER(PublisherId)

INSERT INTO BOOK(Title, Description, Price, ISBN, PublicationDate, Image, B_Cid, B_Pid) VALUES('Dot Net', 'Dot_Net_Description', 450, 107, '11-21-2016', 'C:\Users\omkarpa\Pictures\Dot_Net.jpeg', 1, 3)

SELECT * FROM BOOK
SELECT * FROM PUBLISHER 
SELECT * FROM CATEGORY 


--Order Table
CREATE TABLE [ORDER](
	OrderId int IDENTITY(1,1) NOT NULL,
	Date date,
	Quantity int,
	UnitPrice bigint,
	ShipingAddress char(50) 
)
ALTER TABLE [ORDER] ADD CONSTRAINT pk_orderId PRIMARY KEY (OrderId)

ALTER TABLE [ORDER] ADD O_Bid int
ALTER TABLE [ORDER] ADD CONSTRAINT fk_O_Bid FOREIGN KEY(O_Bid) REFERENCES BOOK(BookId)

INSERT INTO [ORDER](Date, Quantity, UnitPrice, ShipingAddress, O_Bid) VALUES('05-01-2013', 7, 9000, 'Mumbai', 2)

SELECT * FROM [ORDER]




-- a.) Get All the books written by specific author
SELECT * FROM BOOK WHERE BookId IN(SELECT Bid FROM BOOK_AUTHOR WHERE Aid = 2)


-- b.) Get all the books written by specific author and published by specific publisher belonging to “Technical” book Category


-- c. Get total books published by each publisher.
SELECT B_Pid, COUNT(BookId) FROM BOOK  WHERE B_Pid IN (SELECT DISTINCT(B_Pid) FROM BOOK) GROUP BY B_Pid 


-- d. Get all the books for which the orders are placed.
SELECT * FROM BOOK B, [ORDER] O WHERE B.BookId = O.O_Bid