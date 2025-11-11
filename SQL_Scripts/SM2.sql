CREATE DATABASE my_database;

USE my_database;

CREATE TABLE Products (
  Product_id INT PRIMARY KEY,      
  URL VARCHAR(255),                
  Brand_Name VARCHAR(100),         
  Category VARCHAR(50),             
  Individual_category VARCHAR(50), 
  Category_by_Gender VARCHAR(20),  
  Description TEXT,                
  DiscountPrice DECIMAL(10, 2),    
  OriginalPrice DECIMAL(10, 2),      
  DiscountOffer VARCHAR(10),       
  SizeOption VARCHAR(50),          
  Ratings DECIMAL(3, 2),           
  Reviews INT                      
);

ALTER TABLE Products ADD Stock INT;

DROP TABLE Products;


CREATE TABLE Products (
  Product_id INT PRIMARY KEY,      
  URL VARCHAR(255),                
  Brand_Name VARCHAR(100),         
  Category VARCHAR(50),             
  Individual_category VARCHAR(50), 
  Category_by_Gender VARCHAR(20),  
  Description TEXT,                
  DiscountPrice DECIMAL(10, 2),    
  OriginalPrice DECIMAL(10, 2),      
  DiscountOffer VARCHAR(10),       
  SizeOption VARCHAR(50),          
  Ratings DECIMAL(3, 2),           
  Reviews INT                      
);

INSERT INTO Products (Product_id, URL, Brand_Name, Category, Individual_category, Category_by_Gender, Description, DiscountPrice, OriginalPrice, DiscountOffer, SizeOption, Ratings, Reviews)
VALUES
(1, 'http://example.com/product1', 'BrandX', 'Electronics', 'Laptops', 'Unisex', 'High-performance laptop with 16GB RAM.', 40000.00, 50000.00, '10%', '15 inches', 4.5, 150),
(2, 'http://example.com/product2', 'BrandY', 'Electronics', 'Smartphones', 'Unisex', 'Latest smartphone with excellent camera.', 30000.00, 40000.00, '25%', '6.1 inches', 4.2, 200),
(3, 'http://example.com/product3', 'BrandZ', 'Electronics', 'Tablets', 'Unisex', 'Lightweight tablet with 10 hours battery life.', 20000.00, 25000.00, '20%', '10 inches', 4.0, 100);

SELECT Product_id, Brand_Name, DiscountPrice 
FROM Products;

SELECT * 
FROM Products
WHERE Category = 'Electronics';

SELECT * 
FROM Products 
WHERE Brand_Name = 'BrandY';

UPDATE Products 
SET DiscountPrice = 38000 
WHERE Product_id = 1;

SELECT Product_id, Brand_Name, DiscountPrice 
FROM Products;


SELECT * 
FROM Products
ORDER BY DiscountPrice desc;

SELECT AVG(DiscountPrice) AS AverageDiscountPrice
FROM Products;

SELECT MAX(DiscountPrice) AS MaxDiscountPrice
FROM Products;

SELECT MIN(DiscountPrice) AS MinDiscountPrice
FROM Products;












