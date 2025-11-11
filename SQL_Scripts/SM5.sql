CREATE DATABASE my_database;

USE my_database;


CREATE TABLE Products (
  ProductID INT PRIMARY KEY,      
  ProductName VARCHAR(100), 
  Category VARCHAR(50),  
  Price DECIMAL(10, 2), 
  Stock INT, 
  Discount DECIMAL(5, 2), 
  Rating DECIMAL(3, 2)
);

INSERT INTO Products (ProductID, ProductName, Category, Price, Stock, Discount, Rating)
VALUES
  (101, 'Laptop', 'Electronics', 40000, 50, 10.00, 4.5),
  (102, 'Smartphone', 'Electronics', 30000, 40, 15.00, 4.2),
  (103, 'Shirt', 'Clothing', 2000, 100, 20.00, 3.8),
  (104, 'Shoes', 'Footwear', 5000, 30, 25.00, 4.0),
  (105, 'Tablet', 'Electronics', 25000, 20, 5.00, 4.1);

CREATE TABLE Orders (
  OrderID INT PRIMARY KEY, 
  CustomerID INT, 
  OrderDate DATE
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES
  (201, 1, '2024-09-10'),
  (202, 2, '2024-09-11'),
  (203, 3, '2024-09-12'),
  (204, 1, '2024-09-13'),
  (205, 2, '2024-09-14');

CREATE TABLE OrderDetails (
  OrderID INT, 
  ProductID INT, 
  Quantity INT, 
  Price DECIMAL(10, 2), 
  PRIMARY KEY (OrderID, ProductID)
);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES
  (201, 101, 2, 40000),
  (201, 103, 5, 2000),
  (202, 102, 1, 30000),
  (203, 104, 3, 5000),
  (204, 105, 2, 25000),
  (205, 101, 1, 40000);

CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY, 
  CustomerName VARCHAR(100), 
  Email VARCHAR(100)
);

INSERT INTO Customers (CustomerID, CustomerName, Email)
VALUES
  (1, 'Alice', 'alice@example.com'),
  (2, 'Bob', 'bob@example.com'),
  (3, 'Charlie', 'charlie@example.com');
  

CREATE TABLE OrderLogs (
  LogID INT AUTO_INCREMENT PRIMARY KEY,
  ProductID INT,
  Quantity INT,
  Action VARCHAR(50),
  LogDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




DELIMITER $$
CREATE PROCEDURE UpdateStock(IN productID INT, IN newQuantity INT)
BEGIN
  UPDATE Products
  SET Stock = newQuantity
  WHERE ProductID = productID;
END $$
DELIMITER ;

-- Call the procedure
CALL UpdateStock(101, 50);

select * from Products	


DELIMITER $$
CREATE FUNCTION CalculateTotal(orderID INT) RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
  DECLARE total DECIMAL(10,2);
  SELECT SUM(Price * Quantity) INTO total
  FROM OrderDetails
  WHERE OrderID = orderID;
  RETURN total;
END $$
DELIMITER ;

-- Call the function
SELECT CalculateTotal(101);



DELIMITER $$
CREATE TRIGGER UpdateStockOnOrder AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
  UPDATE Products
  SET Stock = Stock - NEW.Quantity
  WHERE ProductID = NEW.ProductID;
END $$
DELIMITER ;

SELECT * FROM Products WHERE ProductID = 101;
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) 
VALUES (206, 101, 3, 40000);  

-- Check the Products table to verify the stock update
SELECT * FROM Products WHERE ProductID = 101;





