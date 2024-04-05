--basic queries: select, where, order by,join, aggregation functions, group by, having
--advanced topics: subquery, CTE, window function, pagination, top
--temp tables
--table variables
--stored procedures
--user defined fucntions

--check constraint: limit the value range that can be palced in a column

SELECT *
FROM Employee

INSERT INTO EMPLOYEE VALUES (5, 'Monster', 3000)
INSERT INTO EMPLOYEE VALUES (6, 'Monster', -3000)

DELETE Employee

ALTER TABLE Employee
ADD CONSTRAINT Chk_Age_Employee CHECK(Age BETWEEN 18 AND 65)

INSERT INTO EMPLOYEE VALUES (1, 'Fred', 30)

--identity property

CREATE TABLE Product(
    Id int PRIMARY KEY IDENTITY(1, 001),
    ProductName varchar(20) UNIQUE NOT NULL,
    UnitPrice Money
)

DROP TABLE Product

SELECT *
FROM Product

INSERT INTO Product VALUES('Green Tea', 2)
INSERT INTO Product VALUES('Latte', 3)
INSERT INTO Product VALUES('Cold Brew', 4)

--truncate vs. delete
--1. Delete is a DML, it will not reset the property value; TRUNCATE is a DDL, will reset the property value

DELETE Product

SELECT *
FROM Product

TRUNCATE TABLE Product

--2. DELETE can be used with WHERE but TRUNCATE can not be used.

DELETE Product
WHERE Id = 3

--DROP: DDL statement that will delete the whole table

--referential integrity: it is implemented by foreign key
--Department table
--Employee table

CREATE TABLE Department(
    Id int PRIMARY KEY,
    DepartmentName varchar(20),
    Location varchar(20)
)

DROP TABLE Employee

CREATE TABLE Employee(
    Id int PRIMARY KEY,
    EmployeeName varchar(20),
    Age int CHECK(AGE BETWEEN 18 AND 65),
    DepartmentId int FOREIGN KEY REFERENCES Department(Id)
)

SELECT *
FROM Department

SELECT *
FROM Employee

INSERT INTO Department VALUES(1, 'IT', 'Chicago')
INSERT INTO Department VALUES(2, 'HR', 'Sterling')
INSERT INTO Department VALUES(3, 'QA', 'Paris')

INSERT INTO Employee VALUES(1, 'Fred', 34, 1)
INSERT INTO Employee VALUES(1, 'Fred', 34, 4)

DELETE FROM Department
WHERE Id =1 

DELETE FROM Department
WHERE Id =3

CREATE TABLE Employee(
    Id int PRIMARY KEY,
    EmployeeName varchar(20),
    Age int CHECK(AGE BETWEEN 18 AND 65),
    DepartmentId int FOREIGN KEY REFERENCES Department(Id) ON DELETE SET NULL
)

CREATE TABLE Employee(
    Id int PRIMARY KEY,
    EmployeeName varchar(20),
    Age int CHECK(AGE BETWEEN 18 AND 65),
    DepartmentId int FOREIGN KEY REFERENCES Department(Id) ON DELETE CASCADE
)

SELECT *
FROM Department

SELECT *
FROM Employee

DROP TABLE Employee

INSERT INTO Employee VALUES(1, 'Fred', 20, 1)

DELETE FROM Department
WHERE Id =1 

--Composite primary key
--student table
--class table
--enrollment table

CREATE TABLE STUDENT(
    Id int PRIMARY KEY,
    StudentName varchar(20)
)

CREATE TABLE Class(
    Id int PRIMARY KEY,
    ClassName varchar(20)
)

CREATE TABLE Enrollment(
    StudentId int NOT NULL,
    ClassId int NOT NULL,
    CONSTRAINT PK_Enrollment PRIMARY KEY( StudentId,ClassId),
    CONSTRAINT FK_Enrollemnt_Student FOREIGN KEY(StudentId) REFERENCES Student(Id),
    CONSTRAINT FK_Enrollemnt_Class FOREIGN KEY(ClassId) REFERENCES Class(Id)
)

--transaction: a group of logically realted DML statement that will either succeed together or fail together
--3 modes:
--Autocommit transaction: default one 
--Implicit transaction:
--Explicit transaction: 

DROP TABLE Product

CREATE TABLE Product(
    Id int PRIMARY KEY ,
    ProductName varchar(20) UNIQUE NOT NULL,
    UnitPrice Money,
    Quantity int
)

SELECT *
FROM Product

INSERT INTO Product VALUES(1, 'Green Tea', 2, 100)
INSERT INTO Product VALUES(2, 'Latee', 3, 100)
INSERT INTO Product VALUES(3, 'Cold Brew', 4, 100)

--Properties
--ACID

--1.Atomicity: work is atomic
--2.Consistency: whatever happens in the mid of the transaction, this property will never leave our db in half completed state
--3.Isolation: locking the resource
--4.Durability: once the transaction is completed, the changes it made to our db will be permanent.


--concurrency problem: when two or more than two users try to access the same data

--1.Dirty read: if t1 allows t2 to read the uncommitted data ans then t1 rolled back; happens when isolation level is read uncommitted; is solved by updating the isolation level to read committed
--2.Lost Update: when t1 and t2 read and update the same data but t2 finishes its wor earlier, so the update from the t2 will be missing, happens when the isolation level is read committed, update the isolation level to repeatable read
--3.Non-repeatable read: t1 will read the same data twice while t2 is updating the data; happens when isolation level is read committed; update the isolation level to repeatable read to solve
--4.Phantom Read: t1 reads the same data twice while t2 is inserting the data; happens when isolation level is repeatable read; update the isolation level to serializable

--index: on disk-structure to increase the data retrieval speed --SELECT
--Clustered Index: sort the recod, one clustered index in one table, generated by the primary key,
--since data can be only sorted in one way, there will only be one clustered index in one table generated by the primary key
--Non clustered index: will not sort the record, store elsewhere and point to the data row, generated by unique constraint, one table can have multiple clustered index


CREATE TABLE Customer(
    Id int,
    FullName varchar(20),
    City VARCHAR(20),
    Country varchar(20)
)

SELECT *
FROM Customer

CREATE CLUSTERED INDEX Cluster_IX_Customer_ID ON Customer(Id)

INSERT INTO Customer VALUES(2, 'David', 'Sterling', 'USA')
INSERT INTO Customer VALUES(1, 'Fred', 'Chicago', 'USA')

DROP TABLE Customer

CREATE TABLE Customer(
    Id int PRIMARY KEY,
    FullName varchar(20),
    City VARCHAR(20),
    Country varchar(20)
)

CREATE INDEX NonCluster_IX_Customer_City ON Customer(City)

--disadvantages:
--extra space, slow down other DML statements: UPDATE/INSERT/DELETE

--PERFORMANCE TUNING 
--look at the execution plan/sql profiler
--create index wisely
--avoid unnecessary joins
--avoid SELECT *
--derived table to avoid grouping of a lot of non-aggregated fields
--use join to replace subquery