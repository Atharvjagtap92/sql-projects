CREATE DATABASE my_database;

USE my_database;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    SubCategory VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT,
    Discount DECIMAL(5, 2),
    Rating DECIMAL(3, 2)
);

INSERT INTO Products (ProductID, ProductName, Category, SubCategory, Price, Stock, Discount, Rating) VALUES
(101, 'T-Shirt', 'Clothing', 'Shirts', 20.00, 50, 10.00, 4.5),
(102, 'Jeans', 'Clothing', 'Pants', 40.00, 30, 20.00, 4.2),
(103, 'Sneakers', 'Footwear', 'Shoes', 60.00, 15, 25.00, 4.7),
(104, 'Laptop', 'Electronics', 'Computers', 800.00, 5, 50.00, 4.8),
(105, 'Bag', 'Accessories', 'Bags', 30.00, 12, 15.00, 4.0),
(106, 'Smartphone', 'Electronics', 'Mobiles', 500.00, 20, 5.00, 4.6),
(107, 'Sweater', 'Clothing', 'Shirts', 35.00, 8, 30.00, 4.3),
(108, 'Watch', 'Accessories', 'Watches', 150.00, 25, 0.00, 4.1),
(109, 'Headphones', 'Electronics', 'Audio', 100.00, 40, 20.00, 4.4),
(110, 'Cap', 'Clothing', 'Hats', 15.00, 60, 0.00, 3.8);


SELECT * FROM Products 
WHERE Stock > 10 AND Category = 'Clothing';

SELECT * FROM Products 
WHERE Category = 'Clothing' OR Discount > 20;

SELECT * FROM Products 
WHERE NOT Category = 'Electronics';

SELECT * FROM Products 
WHERE (SubCategory = 'Shirts' OR Discount > 20)
AND Category != 'Electronics';

SELECT * FROM Products LIMIT 5;

SELECT ProductName, Discount 
FROM Products 
ORDER BY Discount DESC 
LIMIT 2;

SELECT * FROM Products 
ORDER BY ProductName ASC 
LIMIT 2 
OFFSET 2;

SELECT * FROM Products 
WHERE ProductName LIKE 'T%';

SELECT * FROM Products 
WHERE ProductName LIKE '%Bag%';

SELECT * FROM Products
WHERE ProductName LIKE '%Shoes';

SELECT * FROM Products 
WHERE Stock BETWEEN 10 AND 50;

SELECT * FROM Products 
WHERE ProductID IN (101, 102, 103);

SELECT * FROM Products 
WHERE Price BETWEEN 15 AND 100;

SELECT ProductName AS Name, Price AS Cost
FROM Products;

SELECT * FROM Products
WHERE Stock < 10;

SELECT ProductName, Price, (Price * Stock) AS TotalCost 
FROM Products;

SELECT Category, COUNT(*) AS ProductCount
FROM Products
GROUP BY Category;

SELECT Category, AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 30;

SELECT Category, COUNT(*) AS DiscountedProductCount 
FROM Products 
GROUP BY Category 
HAVING COUNT(*) > 2 AND AVG(Discount) > 15;

SELECT ProductID, ProductName, Stock, 
	CASE 
		WHEN Stock > 20 THEN 'In Stock' 
		WHEN Stock BETWEEN 1 AND 20 THEN 'Low Stock' 
		ELSE 'Out of Stock' 
	END AS StockStatus 
FROM Products;

SELECT ProductID, ProductName, Rating, 
	CASE 
		WHEN Rating >= 4.5 THEN 'Excellent' 
		WHEN Rating >= 3 THEN 'Good' 
		ELSE 'Needs Improvement' 
	END AS RatingCategory 
FROM Products;

SELECT ProductID, ProductName, Discount, 
	CASE 
		WHEN Discount >= 50 THEN 'High Discount' 
		WHEN Discount BETWEEN 20 AND 49 THEN 'Moderate Discount' 
		ELSE 'Low Discount' 
	END AS DiscountLevel 
FROM Products;





CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Country VARCHAR(50)
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
-- Inserting data into Customers table
INSERT INTO Customers (CustomerID, CustomerName, Country)
VALUES
(1, 'Alice', 'USA'),
(2, 'Bob', 'Canada'),
(3, 'Charlie', 'UK'),
(4, 'David', 'USA'),
(5, 'Eve', 'Australia');

-- Inserting data into Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount)
VALUES
(101, 1, '2024-01-10', 500.00),
(102, 2, '2024-01-15', 300.00),
(103, 1, '2024-01-20', 150.00),
(104, 4, '2024-01-25', 700.00),
(105, 3, '2024-01-30', 450.00),
(106, NULL, '2024-02-05', 200.00);  -- An order without a customer


SELECT Customers.CustomerName, Orders.OrderID, Orders.Amount
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT Customers.CustomerName, Orders.OrderDate
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.Amount > 400;

SELECT Customers.CustomerName, Orders.OrderID, Orders.Amount
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT Customers.CustomerName, Orders.Amount
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.Amount IS NULL;

SELECT Customers.CustomerName, Orders.OrderID, Orders.Amount
FROM Customers
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT Orders.OrderID, Orders.Amount, Customers.CustomerName 
FROM Customers 
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
WHERE Customers.CustomerName IS NULL;



SELECT CustomerName
FROM Customers
WHERE CustomerID = (SELECT CustomerID 
                    FROM Orders 
                    ORDER BY Amount DESC 
                    LIMIT 1);
                    
SELECT CustomerName
FROM Customers
WHERE CustomerID IN (SELECT CustomerID 
                     FROM Orders 
                     WHERE Amount > 400);
                     
     