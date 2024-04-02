USE Northwind
GO

--SELECT statement: identify which columns we want to retrieve
--1. SELECT all columns and rows

SELECT *
FROM Employees

--2. SELECT a list of columns

SELECT EmployeeID, FirstName, LastName
FROM Employees

SELECT e.EmployeeID, e.FirstName, e.LastName
FROM Employees AS e

--avoid using SELECT *
--1. unnecessary data
--2. Name conflicts

SELECT *
FROM Employees

SELECT *
FROM Customers

SELECT *
FROM Employees e JOIN Orders o ON e.EmployeeID = o.EmployeeID JOIN Customers c ON o.CustomerID = c.CustomerID


--3. SELECT DISTINCT Value: 
--list all the cities that employees are located at

SELECT DISTINCT City
FROM Employees

--4. SELECT combined with plain text: retrieve the full name of employees

SELECT FirstName +' '+ LastName AS FullName
FROM Employees


--identifiers: names we give to db, tables, columns, sp.
--1. Regular Identifier
      --1. First character: a-z, A-Z, @, #
            --@: decalre a variable
            DECLARE @today DATETIME
            SELECT @today = GETDATE()
            PRINT @today

            --#: temp tables
                --#: local temp table
                --##: global temp table
    --2. subsequent character: a-z, A-Z, 0-9, $, #, _, @
    --3. identifier must not be a sql reserved word both uppercase or lowercase 
    --4. embedded space is not allowed

--2. Delimited Identifier: [], " "

SELECT FirstName +' '+ LastName AS "Full Name"
FROM Employees

SELECT *
FROM [Order Details]

--WHERE statement: filter records
--1. equal =
--Customers who are from Germany

SELECT CustomerId, ContactName, Country
FROM Customers
WHERE Country = 'Germany'


--Product which price is $18
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice = 18


--2. Customers who are not from UK
SELECT CustomerId, ContactName, Country
FROM Customers
WHERE Country != 'UK'

SELECT CustomerId, ContactName, Country
FROM Customers
WHERE Country <> 'UK'

--IN Operator: retrieve data among list of values
--E.g: Orders that ship to USA AND Canada

SELECT OrderId, CustomerId, ShipCountry
FROM Orders 
WHERE ShipCountry = 'USA' OR ShipCountry = 'Canada'

SELECT OrderId, CustomerId, ShipCountry
FROM Orders 
WHERE ShipCountry IN ('USA', 'Canada')

--BETWEEN Operator: retrieve data in consecutive range
--1. retreive products whose price is between 20 and 30.

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice >= 20 AND UnitPrice <= 30


SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 20 AND 30

--NOT Operator: 
-- list orders that does not ship to USA or Canada

SELECT OrderId, CustomerId, ShipCountry
FROM Orders 
WHERE ShipCountry NOT IN ('USA', 'Canada')

SELECT OrderId, CustomerId, ShipCountry
FROM Orders 
WHERE NOT ShipCountry IN ('USA', 'Canada')

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice NOT BETWEEN 20 AND 30

SELECT ProductName, UnitPrice
FROM Products
WHERE NOT UnitPrice  BETWEEN 20 AND 30

--NULL Value: a field without a value 
--check which employees' region information is empty

SELECT EmployeeID, FirstName, LastName, Region
FROM Employees
WHERE Region IS NULL


--exclude the employees whose region is null
SELECT EmployeeID, FirstName, LastName, Region
FROM Employees
WHERE Region IS NOT NULL


--Null in numerical operation

CREATE TABLE TestSalary(EId int primary key identity(1,1), Salary money, Comm money)
INSERT INTO TestSalary VALUES(2000, 500), (2000, NULL),(1500, 500),(2000, 0),(NULL, 500),(NULL,NULL)

SELECT EId, Salary, Comm, ISNULL(Salary, 0) + ISNULL(Comm, 0)AS TotalCompensation
FROM TestSalary

--LIKE Operator: create a serach expression

--1. Work with % wildcard character: % is used to substitute 0 or more characters

--retrieve all the employees whose last name starts with D

SELECT FirstName, LastName
FROM Employees
WHERE LastName LIKE 'D%'

--2. Work with [] and % to search in ranges: 

--find customers whose postal code starts with number between 0 and 3

SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode LIKE '[0-3]%'


--3. Work with NOT: 


SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode NOT LIKE '[0-3]%'

--4. Work with ^: any characters not in the brackets

SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode LIKE '[^0-3]%'

--Customer name starting from letter A but not followed by l-n

SELECT ContactName, PostalCode
FROM Customers
WHERE ContactName LIKE 'A[^l-n][r-z]%'


--ORDER BY statement: sort the result in ascending or descending order
--1. retrieve all customers except those in Boston and sort by Name

SELECT ContactName, City
FROM Customers
WHERE City != 'Boston'
ORDER BY ContactName DESC

--2. retrieve product name and unit price, and sort by unit price in descending order

SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--3. Order by multiple columns

SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC, ProductName DESC

SELECT ProductName, UnitPrice
FROM Products
ORDER BY 2 DESC, 1 DESC


--JOIN: used to combine rows from one or more tables based on the related column between them
--1. INNER JOIN: returns record that has matching value in both tables

--find employees who have deal with any orders

SELECT e.EmployeeID, e.FirstName + ' ' + e.LastName AS FullName, o.OrderDate
FROM Employees AS e INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID

--get cusotmers information and corresponding order date

SELECT C.ContactName, C.City, c.Country, o.OrderDate
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID

SELECT C.ContactName, C.City, c.Country, o.OrderDate
FROM Customers c, Orders o
WHERE c.CustomerID = O.CustomerID

--join multiple tables:
--get customer name, the corresponding employee who is responsible for this order, and the order date

SELECT c.ContactName As CustomerName, e.FirstName + ' '+ e.LastName As EmployeeName, o.OrderDate
FROM Customers c JOIN Orders o ON c.CustomerID= o.CustomerID JOIN Employees e ON o.EmployeeID = e.EmployeeID


--add detailed information about quantity and price, join Order details

SELECT c.ContactName As CustomerName, e.FirstName + ' '+ e.LastName As EmployeeName, o.OrderDate, od.Quantity, od.UnitPrice
FROM Customers c JOIN Orders o ON c.CustomerID= o.CustomerID JOIN Employees e ON o.EmployeeID = e.EmployeeID INNER JOIN [Order Details] 
od ON od.OrderID = o.OrderID


--2. OUTER JOIN: return all the values from one table and only a matching value from another table

--1) LEFT OUTER JOIN: return all the records from the left table and matching records from the right table, if we can not find any matching records,
--then for that row we will return null. 

--list all customers whether they have made any purchase or not

SELECT C.ContactName, O.OrderID
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY O.OrderID DESC



--JOIN with WHERE: 
--customers who never placed any order

SELECT C.ContactName, O.OrderID
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderId is null

--2) RIGHT OUTER JOIN: return all the records from the right table and only the matching records from the left table, if we can not find any matching records,
--then for that row we will return null. 

--list all customers whether they have made any purchase or not

SELECT C.ContactName, O.OrderID
FROM Orders o RIGHT JOIN Customers c ON c.CustomerID = o.CustomerID
ORDER BY O.OrderID DESC


--3) FULL OUTER JOIN: return all the rows from both left and right table with null values if we can not find the matching records

--Match all customers and suppliers by country.

SELECT c.ContactName as customer, c.Country as CustomerCountry, s.Country as SupplierCountry, s.ContactName AS Supplier
FROM Customers c FULL JOIN Suppliers s ON c.Country=s.Country
ORDER by CustomerCountry, SupplierCountry

--3. CROSS JOIN: create the cartesian product of two tables
--table 1: 10 rows
--table 2: 20 rows
--cross join-->200 rows

SELECT *
FROM Customers

SELECT * 
FROM Orders

SELECT *
FROM Customers  CROSS JOIN Orders

--* SELF JOIN：join a table with itself

SELECT EmployeeID, FirstName, LastName, ReportsTo
FROM Employees


--find emloyees with the their manager name

--CEO: Andrew
--Manager:Nancy, Janet, Margaret, Steven, Laura
--Employee: Michael, Robert, Anne

SELECT e.FirstName+ ' '+ e.LastName AS Employee, m.FirstName+ ' '+m.LastName AS Manager
FROM Employees e INNER JOIN Employees m ON e.ReportsTo = m.EmployeeID

SELECT e.FirstName+ ' '+ e.LastName AS Employee, m.FirstName+ ' '+m.LastName AS Manager
FROM Employees e LEFT JOIN Employees m ON e.ReportsTo = m.EmployeeID


--Batch Directives

USE Northwind
GO

CREATE DATABASE AprBatch
GO
USE AprBatch
GO
CREATE TABLE Employee(Id int, ENmae varchar(20), Salary money)

