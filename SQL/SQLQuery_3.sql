--aggregation functions + group by 
--subquery 
--union vs. union all 
--window function 
--cte

--temp table: a special type of table so that we can store data temproraily. 
--local temp table #

CREATE TABLE #LocalTemp(
    Num int
)
DECLARE @Variable int = 1
WHILE(@Variable <=10)
BEGIN
    INSERT INTO #LocalTemp(Num) VALUES(@Variable)
    SET @Variable = @Variable +1
END

SELECT *
FROM #LocalTemp

SELECT *
FROM tempdb.sys.tables

--global temp table ##

CREATE TABLE ##GlobalTemp(
    Num int
)
DECLARE @Variable2 int = 1
WHILE(@Variable2 <=10)
BEGIN
    INSERT INTO ##GlobalTemp(Num) VALUES(@Variable2)
    SET @Variable2 = @Variable2 +1
END

SELECT *
FROM ##GlobalTemp

SELECT *
FROM tempdb.sys.tables

--table variable: type of variable which is of table type

DECLARE @today DATETIME
SET @today = GETDATE()
PRINT @today

DECLARE @WeekDays TABLE(
    DayNum int,
    DayAbb varchar(20),
    WeeKName varchar(20)
)
INSERT INTO @WeekDays
VALUES
(1,'Mon','Monday')  ,
(2,'Tue','Tuesday') ,
(3,'Wed','Wednesday') ,
(4,'Thu','Thursday'),
(5,'Fri','Friday'),
(6,'Sat','Saturday'),
(7,'Sun','Sunday')

SELECT * FROM @WeekDays
SELECT *
FROM tempdb.sys.tables

--temp tables vs. table variables
--1. Both table variable and temp table are stored in the tempdb database
--2. scope: local/temp table, table variable: current batch
--3. size:>100 rows go with temp tables, size<100 rows go with table variables
--4. we do not use temp tables in stored procedures or user defined functions but can use table variables in sp or udf

--view: virtual table that contains data from one or multiple tables 

USE AprBatch
GO

SELECT *
FROM Employee

INSERT INTO Employee VALUES(1, 'Fred', 5000),(3, 'Amy', 6000)

CREATE VIEW vwEmp
AS
SELECT Id, ENmae, Salary
FROM Employee

SELECT *
FROM vwEmp

--sotred procedure: A preprepared sql query that we can save in our database and reuse it whenever we want to

BEGIN
 PRINT 'Hello Anonymous Block'
END

CREATE PROC spHello
AS
BEGIN 
    PRINT 'Hello Anonymous Block'
END

EXEC spHello 

--sql injection: hackers inject some mallicious code into our SQL queries thus destroying our databse 

SELECT Id, Name
FROM User
WHERE Id = 1 UNION SELECT Id, Password FROM User

SELECT Id, Name
FROM User
WHERE Id = 1 OR 1=1

SELECT Id, Name
FROM User
WHERE Id = 1 DROP TABLE User


--input

CREATE PROC spAddNumbers
@a int,
@b int
AS
BEGIN
   PRINT @a + @b
END

EXEC spAddNumbers 10, 20

--output

CREATE PROC spGetName1
@id int,
@EName varchar(20) OUT
AS
BEGIN
    SELECT @EName = ENmae
    FROM Employee
    WHERE Id = @id
END

BEGIN
  DECLARE @en VARCHAR(20)
  EXEC spGetName1 3, @en OUT
  PRINT @en
END 

SELECT *
FROM Employee

CREATE PROC spGetAllEmp
AS
BEGIN
    SELECT *
    FROM Employee
END

EXEC spGetAllEmp

--trigger
--DML trigger
--DDL trigger
--LogOn trigger

--lifescope sp and views: they will be stored in the database forever as long as you do not drop them

--FUNCTIONS:
--Biilt-in
--User defined functions: used for calculations


CREATE FUNCTION GetTotalRevenue(@price money, @discount real, @quantity int)
RETURNS money
AS
BEGIN
    DECLARE @revenue money
    SET @revenue = @price * (1-@discount) * @quantity
    RETURN @revenue
END

SELECT UnitPrice,  Quantity, Discount, dbo.GetTotalRevenue(UnitPrice, Discount, Quantity) AS Revenue
FROM [Order Details]

CREATE FUNCTION ExpensiveProduct(@threshold money)
RETURNS TABLE
AS
    RETURN SELECT * 
            FROM Products
            WHERE UnitPrice<@threshold

SELECT *
FROM dbo.ExpensiveProduct(10)

--sp vs. udf
--1. Usage: sp for DML, udf for calculations
--2. how to call: sp will be called by its name after exec keyword but udf must be called in sql statements
--3.input/output: sp may or may not have input or output but for fucntions, may or may not have inuput but it must have output
--4.sp can call functions but function can not call sp

--pagination
--offset: skip
--fetch next x Rows : select

SELECT CustomerId, ContactName, City
FROM Customers
ORDER BY CustomerId
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY


--TOP: fetch to several records, use it or without order by 
--offset and fetch next: only use with ORDER BY


DECLARE @PageNum INT
DECLARE @RowsOfPage INT
SET @PageNum = 2
SET @RowsOfPage = 10
SELECT CustomerId, ContactName, City
FROM Customers
ORDER BY CustomerId
OFFSET (@PageNum - 1 ) * @RowsOfPage ROWS
FETCH NEXT @RowsOfPage ROWS ONLY



DECLARE @PageNum INT
DECLARE @RowsOfPage INT
DECLARE @MaxTablePage FLOAT
SET @PageNum = 1
SET @RowsOfPage = 10
SELECT @MaxTablePage = COUNT(*) FROM Customers
SET @MaxTablePage=CEILING(@MaxTablePage/@RowsOfPage)
WHILE(@PageNum<=@MaxTablePage)
BEGIN
    SELECT CustomerId, ContactName, City
    FROM Customers
    ORDER BY CustomerId
    OFFSET (@PageNum - 1 ) * @RowsOfPage ROWS
    FETCH NEXT @RowsOfPage ROWS ONLY
    SET @PageNum = @PageNum + 1
END


--Normalization
--one to many
--Employee table and Department table
--many to many --> create a conjunction table
--student table and class table

--Constraints

USE AprBatch
GO

DROP TABLE Employee

CREATE TABLE Employee(
    Id int PRIMARY KEY,
    EName VARCHAR(20) not null,
    Age int
)

SELECT *
FROM Employee

INSERT INTO Employee VALUES(1, 'Sam', 45)

INSERT INTO Employee VALUES(null, 'Fiona', 32)

--primary key vs. unique constraint

--1.unique constraint can accept one and only null value but pk can not accept any null value
--2.One table can have multiple unique keys but only one primary key.
--3.Primary key will sort the data by defualt but unique key will not
--4.Primary key will by default create a clustered index but unique key will create non clustered index


DELETE Employee

INSERT INTO Employee
VALUES(4, 'Fred', 45)

INSERT INTO Employee
VALUES(1, 'Laura', 34)

INSERT INTO Employee
VALUES(3, 'Peter', 19)

INSERT INTO Employee VALUES(2, 'Sam', 45)