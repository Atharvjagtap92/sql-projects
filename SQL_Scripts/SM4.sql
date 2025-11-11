CREATE DATABASE my_database;

USE my_database;

CREATE TABLE Products (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(50),
  Category VARCHAR(50),
  Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Category, Price) 
VALUES 
(101, 'Laptop', 'Electronics', 1000), 
(102, 'Smartphone', 'Electronics', 700), 
(103, 'Tablet', 'Electronics', 400), 
(104, 'Smartwatch', 'Electronics', 200), 
(105, 'Headphones', 'Accessories', 50);

CREATE TABLE Sales (
  SaleID INT PRIMARY KEY,
  ProductID INT,
  Quantity INT,
  SaleDate DATE,
  SalePrice DECIMAL(10, 2),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate, SalePrice)
VALUES 
(1, 101, 5, '2024-09-01', 150.00),
(2, 102, 2, '2024-09-03', 300.00),
(3, 103, 1, '2024-09-05', 500.00),
(4, 104, 3, '2024-09-08', 200.00),
(5, 101, 7, '2024-09-10', 120.00);

SELECT SUM(SalePrice * Quantity) AS TotalRevenue
FROM Sales;

SELECT AVG(SalePrice) AS AverageSalePrice
FROM Sales;

SELECT COUNT(*) AS TotalSales
FROM Sales;

SELECT MIN(SalePrice) AS MinimumSalePrice
FROM Sales;

SELECT MAX(SalePrice) AS MaximumSalePrice
FROM Sales;

SELECT CONCAT(ProductName, ' - ', Category) AS ProductDetails
FROM Products;

SELECT ProductName, SUBSTRING(ProductName, 1, 5) AS ShortName
FROM Products;

SELECT ProductName, LENGTH(ProductName) AS NameLength
FROM Products;

SELECT UPPER(ProductName) AS UpperCaseName, LOWER(ProductName) AS LowerCaseName 
FROM Products;

SELECT NOW() AS CurrentDateTime;

SELECT CURDATE() AS CurrentDate;

SELECT SaleID, SaleDate, DATE_ADD(SaleDate, INTERVAL 30 DAY) AS NewDate
FROM Sales;

SELECT SaleID, DATEDIFF(CURDATE(), SaleDate) AS DaysSinceSale
FROM Sales;

SELECT SaleID, EXTRACT(YEAR FROM SaleDate) AS SaleYear
FROM Sales;

SELECT SaleID, DATE_FORMAT(SaleDate, '%m-%d-%Y') AS FormattedDate
FROM Sales;

SELECT SaleID, ROUND(SalePrice, 2) AS RoundedPrice
FROM Sales;

SELECT SaleID, FLOOR(SalePrice) AS FlooredPrice
FROM Sales;

SELECT SaleID, CEIL(SalePrice) AS CeilingPrice
FROM Sales;

SELECT ABS(300 - SalePrice) AS PriceDifference
FROM Sales;