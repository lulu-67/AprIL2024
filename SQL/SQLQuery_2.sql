--SELECT: RETRIEVE
--WHERE: filter
--ORDER BY: sort
--JOIN: work on multiple tables in one query

--Aggregation functions: perform a calculation on a set of values and returns a single aggregated result
--1. COUNT(): returns the number of rows

SELECT COUNT(OrderId) AS TotalNumofRows
FROM Orders

SELECT COUNT(*) AS TotalNumofRows
FROM Orders

--COUNT(*) vs. COUNT(colName): 
--COUNT(*) will include all the values both null and non null and COUNT(colName) will not 

SELECT FirstName, Region
FROM Employees
 
SELECT COUNT(Region), COUNT(*)
FROM Employees

-- GROUP BY: group rows that have the same values into the summary rows

--find total number of orders placed by each customers

SELECT C.ContactName, c.City, c.Country, COUNT(o.OrderID) AS NumOfOrders
FROM Customers c JOIN Orders o ON c.CustomerID=o.CustomerID
GROUP BY C.ContactName, c.City, c.Country
ORDER BY  NumOfOrders DESC

--a more complex template: 
--only retreive total order numbers where customers located in USA or Canada, and order number should be greater than or equal to 10

SELECT C.ContactName, c.City, c.Country, COUNT(o.OrderID) AS NumOfOrders
FROM Customers c JOIN Orders o ON c.CustomerID=o.CustomerID
WHERE c.Country IN ('USA', 'Canada')
GROUP BY C.ContactName, c.City, c.Country
HAVING COUNT(o.OrderID) >=10
ORDER BY NumOfOrders DESC

--WHERE vs. HAVING
--1. both are used as filters, HAVING will only apply to group as whole but WHERE is applied to an individual row
--2. WHERE goes before aggregation but HAVING goes after aggregation

--SQL execution order

--SELECT fields, aggregate(fields)
--FROM table, JOIN table2 ON..
--WHERE filter data based on some criteria, optional
--GROUP BY fileds - use when we have both aggregated and non aggregated fields
--HAVING-optional
--ORDER BY fields DESC --optional

--FROM/JOIN ---->WHERE --->GROUP BY ----> HAVING ---> SELECT--->DISTINCT--->ORDER BY
---                |________________________|
--                  can not use alias from select

--3. Where can be used with select, update, delete but having can only be used in select statements

SELECT *
FROM Products

Update Products
SET UnitPrice = 20
WHERE ProductId = 1

--DISTINCT: only get the unique values 
--COUNT DISTINCT: only count the unique values

SELECT COUNT(DISTINCT City), COUNT(City)
FROM Customers

--2. AVG(): returns the average value of the numeric column
--list average revenue for each customer

SELECT c.CustomerID, C.ContactName, AVG(od.UnitPrice * od.Quantity) AS AvgRevenue
FROM Customers c JOIN Orders o ON c.CustomerId = o.CustomerID JOIN  [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, C.ContactName

--3. SUM(): returns the sum value of the numeric column
--list sum of revenue for each customer

SELECT c.CustomerID, C.ContactName, SUM(od.UnitPrice * od.Quantity) As TotalRevenue
FROM Customers c JOIN Orders o ON c.CustomerId = o.CustomerID JOIN  [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, C.ContactName

--4. MAX(): return a maximum value
--list maxinum revenue from each customer

SELECT c.CustomerID, C.ContactName, MAX(od.UnitPrice * od.Quantity) As MaxRevenue
FROM Customers c JOIN Orders o ON c.CustomerId = o.CustomerID JOIN  [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, C.ContactName


--5.MIN(): returns the minimum value from a column
--list the cheapeast product bought by each customer

SELECT c.CustomerID, C.ContactName, MIN(od.UnitPrice) AS Cheapestproduct
FROM Customers c JOIN Orders o ON c.CustomerId = o.CustomerID JOIN  [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, C.ContactName

--TOP predicate: select a specific number or certain percentage of records
--retrieve top 5 most expensive products

SELECT TOP 5 p.ProductID, p.ProductName
FROM Products p
ORDER BY p.UnitPrice DESC

--retrieve top 10 percent most expensive products

SELECT TOP 10 PERCENT p.ProductID, p.ProductName
FROM Products p
ORDER BY p.UnitPrice DESC

--list top 5 customers who created the most total revenue

SELECT TOP 5 c.CustomerID, C.ContactName, SUM(od.UnitPrice * od.Quantity) As TotalRevenue
FROM Customers c JOIN Orders o ON c.CustomerId = o.CustomerID JOIN  [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, C.ContactName
ORDER BY TotalRevenue DESC

SELECT TOP 5 ContactName
FROM Customers

--LIMIT: 

--Subquery: a SELECT statement that is embedded in another SQL statement

--find the customers from the same city where Alejandra Camino lives 

SELECT ContactName, City
FROM Customers
WHERE City IN (
    SELECT  City
    FROM Customers
    WHERE ContactName = 'Alejandra Camino'
)

--find customers who make any orders

--JOIN

SELECT DISTINCT c.CustomerID, c.ContactName, c.City, c.Country
FROM Customers c JOIN Orders o ON c.CustomerID=o.CustomerID

--subquery

SELECT CustomerId, ContactName, City,Country
FROM Customers 
WHERE CustomerId IN
(SELECT DISTINCT CustomerID
FROM Orders)

--subquery vs. join
--1.JOIN can only be used in FROM clause but subquery can be used in SELECT,FROM, WHERE, HAVING, ORDER BY

--get the order information like which employees deal with which order but limit the employees location to London:

--join

SELECT o.OrderDate, e.FirstName, e.LastName
FROM Orders o JOIN Employees e ON o.EmployeeID = e.EmployeeID 
WHERE e.City = 'London'
ORDER BY o.OrderDate, e.FirstName, e.LastName

--Subquery

SELECT o.OrderDate,(SELECT e1.FirstName FROM Employees e1 WHERE o.EmployeeID=e1.EmployeeID) AS FirstName, (SELECT e2.LastName FROM Employees e2 WHERE o.EmployeeID=e2.EmployeeID) AS FirstName
FROM Orders o
WHERE (
    SELECT e3.City
    FROM Employees e3
    WHERE e3.EmployeeID = o.EmployeeID
) IN ('London')
ORDER BY o.OrderDate, (SELECT e1.FirstName FROM Employees e1 WHERE o.EmployeeID=e1.EmployeeID), 
(SELECT e2.LastName FROM Employees e2 WHERE o.EmployeeID=e2.EmployeeID) 

--2.Subquery is easy to maintain and understand. 

--Let's find the customers who never placed any order

--JOIN

SELECT c.CustomerID, C.ContactName, c.City, c.Country
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderId is null

--Subquery

SELECT c.CustomerID, C.ContactName, c.City, c.Country
FROM Customers c 
WHERE CustomerId Not IN (
    SELECT DISTINCT CustomerID
    FROM Orders
)

--3. Ususally Join has better performance than subquery
--JOIN: inner join/outer join
--physical join: hash join, merge join, neested loop join 

--Correlated Subquery: we have an inner query that is dependent on the outer query

SELECT CustomerId, ContactName, City,Country
FROM Customers 
WHERE CustomerId IN
(SELECT DISTINCT CustomerID
FROM Orders)

--Customer name and total number of orders by customer

--JOIN
SELECT c.ContactName, COUNT(o.OrderId) AS TotalNumOfOrders
FROM Customers c LEFT JOIN Orders o ON c.CustomerID=o.CustomerId
GROUP BY  c.ContactName
ORDER BY TotalNumOfOrders DESC

--Subquery

SELECT C.ContactName, (SELECT COUNT(o.OrderId) FROM Orders o WHERE o.CustomerID = c.CustomerID) AS TotalNumOfOrders
FROM Customers c
ORDER BY TotalNumOfOrders DESC

--derived table: subquery in the from clause

SELECT CustomerID, ContactName, Address
FROM (SELECT *
FROM Customers) dt

--get customers information and the number of orders made by each customer

--JOIN

SELECT c.ContactName, c.City, c.Country, COUNT(o.OrderId) As TotalNumofOrders
FROM Customers c LEFT JOIN Orders o ON c.CustomerId = o.CustomerId
GROUP BY c.ContactName, c.City, c.Country
ORDER BY TotalNumofOrders DESC

SELECT c.ContactName, c.City, c.Country, dt.TotalNumOfOrders 
FROM Customers c LEFT JOIN (
    SELECT CustomerID, COUNT(OrderId) AS TotalNumOfOrders
    FROM Orders 
    GROUP BY CustomerId
) dt ON c.CustomerId = dt.CustomerID
ORDER BY dt.TotalNumOfOrders DESC

--Union vs. Union ALL: 

--common features:
--1. both are used to combine different result sets vertically

SELECT  City, Country
FROM Customers
UNION
SELECT  City, Country
FROM Employees

SELECT  City, Country
FROM Customers
UNION ALL
SELECT  City, Country
FROM Employees

--2. they follow the same criteria
  --1. the number of columns must be the same 

        SELECT  City, Country
        FROM Customers
        UNION ALL
        SELECT  City, Country
        FROM Employees
       
       --2. the data type of each column must be the same 

        SELECT  City, Country
        FROM Customers
        UNION ALL
        SELECT  City, Country
        FROM Employees

--differences

--1.Union will remove duplicate values and union all will not 

SELECT  City, Country
FROM Customers
UNION
SELECT  City, Country
FROM Employees

SELECT  City, Country
FROM Customers
UNION ALL
SELECT  City, Country
FROM Employees

--2. Union will sort the first column automatically in an ascending order.

SELECT  City, Country
FROM Customers
UNION
SELECT  City, Country
FROM Employees

--3. Union can not be used in recursive cte but union all can be used. 

--Window Function: operate on a set of rows and return a single aggregated value for each row by adding extra columns

--RANK(): give a rank based on certain order 

SELECT ProductId, ProductName, UnitPrice, RANK() OVER(ORDER BY UnitPrice DESC ) RNK
from Products


--rank for product price, when there is a tie, there will be a value gap

--product with the 2nd highest price 

SELECT dt.ProductID, dt.ProductName, dt.RNK
FROM (SELECT ProductId, ProductName, UnitPrice, RANK() OVER(ORDER BY UnitPrice DESC ) RNK
from Products) dt
WHERE dt.RNK = 2


--DENSE_RANK(): if you do not want the value gap, use DENSE_RANK()

SELECT ProductId, ProductName, UnitPrice, DENSE_RANK() OVER(ORDER BY UnitPrice DESC) RNK
from Products

--ROW_NUMBER(): return the row number of the sorted records starting from 1

SELECT ProductId, ProductName, UnitPrice, RANK() OVER(ORDER BY UnitPrice DESC) RNK ,DENSE_RANK() OVER(ORDER BY UnitPrice DESC) RNK, 
ROW_NUMBER() OVER(ORDER BY UnitPrice Desc) RowNum
from Products

--partition by: it will divide the result into partitions and perform calculation on each subset

--list customers from every country with the ranking for number of orders

SELECT c.ContactName, c.Country, COUNT(o.OrderID) AS NumOfOrders, RANK() OVER(PARTITION BY c.Country ORDER BY COUNT(o.OrderID) DESC) RNK
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName, c.Country

--- find top 3 customers from every country with maximum orders

SELECT dt.ContactName, dt.Country, dt.NumOfOrders, dt.RNK
FROM (SELECT c.ContactName, c.Country, COUNT(o.OrderID) AS NumOfOrders, RANK() OVER(PARTITION BY c.Country ORDER BY COUNT(o.OrderID) DESC) RNK
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName, c.Country) dt
WHERE dt.Rnk<=3

--cte: common table expression: a temprorary name result set to make our query more readable

SELECT c.ContactName, c.City, c.Country, dt.TotalNumOfOrders 
FROM Customers c LEFT JOIN (
    SELECT CustomerID, COUNT(OrderId) AS TotalNumOfOrders
    FROM Orders 
    GROUP BY CustomerId
) dt ON c.CustomerId = dt.CustomerID
ORDER BY dt.TotalNumOfOrders DESC


WITH OrderCntCTE
AS(
    SELECT CustomerID, COUNT(OrderId) AS TotalNumOfOrders
    FROM Orders 
    GROUP BY CustomerId
)
SELECT c.ContactName, c.City, cte.TotalNumOfOrders
FROM Customers c LEFT JOIN OrderCntCTE cte ON c.CustomerID= cte.CustomerID
ORDER BY cte.TotalNumOfOrders DESC

--lifecycle: use it right away in the next select statement, should be used and executed in the same batch

--recursive CTE:  it can recrusively call itself

--Initalization
--Recursive Rule

SELECT EmployeeID, FirstName, ReportsTo
FROM Employees

--level 1: Andrew
--level 2: Nancy, Janet, Margaret, Steven, Laura
--level 3: Michael, Robert, Anne

WITH EmpHierarchyCTE
AS(
    SELECT EmployeeID, FirstName, ReportsTo, 1 lvl
    FROM Employees
    WHERE ReportsTo IS NULL
    UNION ALL
    SELECT e.EmployeeID, e.FirstName, e.ReportsTo, cte.lvl + 1
    FROM Employees e INNER JOIN EmpHierarchyCTE cte ON e.ReportsTo = cte.EmployeeId
)
SELECT * FROM EmpHierarchyCTE

