--Exercise 1
--1.
SELECT CustomerID, CompanyName, Address + ' ' + City + ' ' + Country + ' ' + PostalCode AS "Full Address", Region FROM Customers WHERE City='London';
--Pick the specific columns as long as it meets the requirements of being customers from London

--1.2
SELECT ProductName FROM Products WHERE QuantityPerUnit LIKE '%bottles';
--Picks the products that end in bottles in the quantity per unit

--1.3
SELECT Products.ProductName, Products.SupplierID, Suppliers.Country FROM Products 
INNER JOIN Suppliers ON Products.SupplierID=Suppliers.SupplierID
WHERE QuantityPerUnit LIKE '%bottles';
--Picks the products, suppliers and country that end in bottles in the quantity per unit
--the country came from suppliers table

--1.4
SELECT Categories.CategoryName, COUNT(Products.ProductID) AS NumberOfProducts
FROM Products
INNER JOIN Categories ON Products.CategoryID=Categories.CategoryID
GROUP BY CategoryName
ORDER BY Count(CategoryName) DESC;
--Calculates how many products via category name
--Category name came from the categories table

--1.5
SELECT TitleOfCourtesy  + ' ' + FirstName + ' '  + LastName AS "Full_Name", City FROM Employees WHERE Country='UK';
--Pick employees that are from the UK, giving their title, first name and surname

--1.6
SELECT terr.RegionID, FORMAT(SUM(oSub.Subtotal),'N2') AS "Sales Total"
FROM Territories terr
INNER JOIN EmployeeTerritories ET ON terr.TerritoryID=ET.TerritoryID
INNER JOIN Orders Ord ON Ord.OrderID=Ord.OrderID
INNER JOIN [Order Subtotals] oSub ON Ord.OrderID=oSub.OrderID
GROUP BY terr.RegionID
HAVING SUM(oSub.Subtotal) > 1000000;

--1.7
SELECT COUNT(*) FROM Orders WHERE ShipCountry='USA' AND Freight >100.00;
--Calculates how many orders that are over 100 frieght in the USA

-- 1.8 
SELECT DISTINCT OrderID "Order Numbers", Discount FROM [Order Details] ORDER BY Discount DESC;
--Specifying the order numbers respective to their discount, putting them in descentding order

--Exercise 2
CREATE TABLE Spartan_Table
(
Title VARCHAR(10),
FirstName VARCHAR(25),
LastName VARCHAR(35),
Age INT,
University_Attended VARCHAR(100),
Course VARCHAR(100),
Grade DECIMAL,
Graduation_Year DATE
)
INSERT INTO Spartan_Table(
  Title,
  FirstName,
  LastName,
  Age,
  University_Attended,
  Course,
  Grade,
  Graduation_Year
)
VALUES
('Miss', 'Rume', 'Rhuada', '23','Coventry University', 'Medical and Pharmacological Science', '2.2', '2016-11-22'),
('Miss', 'Yolanda', 'Simpson', '21','University Of Northampton', 'Computing(Computer Systems Engineering)', '2.1', '2018-07-25'),
('Miss', 'Mishu', 'Jahur', '23','Queen Mary University Of London', 'Maths', '1.0', '2018-08-27'),
('Miss', 'Faduma', 'Hussein', '26','St George''s, University Of London', 'Biomedical Science', '2.2', '2014-07-17'),
('Mr', 'Jerome', 'Hanciles', '26','Middlesex University', '3D Animation and Gaming', '3.0', '2014-07-17'),
('Mr', 'Thomas', 'Dam', '23','Keele University', 'Psychology', '2.1', '2018-07-22'),
('Mr', 'Matthew', 'Shaw', '29','Exeter University', 'Computer Science', '2.1', '2013-11-14'),
('Mr', 'Tevin', 'Muparadzi', '24','Middlesex University', 'BioChemical Engineering', '2.1', '2014-06-22'),
('Mr', 'Rahib', 'Sayed', '22','Westminister University', 'Computer Science', '2.2', '2016-07-12');
--creates table that identify the datatypes, insert the column heading then input the values

--Exercise 3
--3.1
SELECT E.FirstName + ' ' + E.LastName AS "Employee Name",R.FirstName + ' ' + R.LastName AS "ReportsTo"
FROM Employees E
LEFT JOIN Employees R ON E.ReportsTo=R.EmployeeID;

--3.2
SELECT SU.CompanyName, 
FORMAT(SUM(OD.UnitPrice*Quantity*(1-Discount)), 'N2') AS "Sale Total"
FROM [Order Details] OD
INNER JOIN Products prod ON OD.ProductID=PROD.ProductID
INNER JOIN Suppliers SU ON prod.SupplierID=SU.SupplierID
GROUP BY SU.CompanyName
HAVING SUM(OD.UnitPrice*Quantity*(1-Discount)) > 10000;

--3.3
SELECT TOP 10 CompanyName FROM Orders 
INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID
WHERE YEAR (OrderDate)='1998'
GROUP BY CompanyName
ORDER BY Max(OrderDate) DESC;

--3.4
SELECT MONTH(ShippedDate) AS "Date Shipped (Month)", AVG(DAY(ShippedDate - OrderDate)) AS "Difference in Days"
FROM Orders
GROUP BY  MONTH(ShippedDate)
HAVING MONTH(ShippedDate) IS NOT NULL;