CREATE DATABASE my_database;

USE my_database;

CREATE TABLE Products (
    Product_id INT PRIMARY KEY,
    Brand_Name VARCHAR(100),
    Category VARCHAR(50),
    DiscountPrice DECIMAL(10, 2)
);

INSERT INTO Products (Product_id, Brand_Name, Category, DiscountPrice)
VALUES (1, 'BrandA', 'Category1', 19.99);

INSERT INTO Products (Product_id, Brand_Name, Category, DiscountPrice)
VALUES (2, 'Laptop', 'Category2', 100.21), (3, 'SmartPhone', 'Category2', 25.61), (4, 'TV', 'Category3', 91.99);

SELECT * FROM Products;

UPDATE Products SET DiscountPrice = 15.99 WHERE Product_id = 1;

DELETE FROM Products WHERE Product_id = 1;

DROP TABLE Products;


