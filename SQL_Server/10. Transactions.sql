--Using Transaction
USE eShop

DROP TABLE Temp

CREATE TABLE Temp
(
	ID INT PRIMARY KEY
)

SELECT * FROM Temp

--The following first two rows will be inserted but last two will fail
INSERT INTO Temp VALUES(1)
INSERT INTO Temp VALUES(2)
INSERT INTO Temp VALUES(2)--Duplicate value
INSERT INTO TempTable VALUES(3)--Invalid table name

SELECT * FROM Temp

DELETE FROM Temp

--Using Transaction, now either all rows will be inserted or none of them
BEGIN TRY
BEGIN TRANSACTION Tran1
INSERT INTO Temp VALUES(1)
INSERT INTO Temp VALUES(2)
INSERT INTO Temp VALUES(2)--Duplicate value
INSERT INTO TempTable VALUES(3)--Invalid table name
COMMIT TRANSACTION Tran1
PRINT 'Transaction Committed successfully'
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION Tran1
PRINT 'Transaction Rolled back by SQL Server due to some error'
END CATCH

