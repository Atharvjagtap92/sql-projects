

DELIMITER $$
CREATE PROCEDURE GetStock(IN productID INT, OUT availableStock INT)
BEGIN
  SELECT Stock INTO availableStock
  FROM Products
  WHERE ProductID = productID;
END $$
DELIMITER ;

-- Call the procedure
CALL GetStock(101, @stock);
SELECT @stock;

DROP PROCEDURE IF EXISTS GetStock;






DELIMITER $$
CREATE PROCEDURE PlaceOrder(IN productID INT, IN quantity INT)
BEGIN
  START TRANSACTION;
  
  -- Update the product stock
  UPDATE Products 
  SET Stock = Stock - quantity 
  WHERE ProductID = productID;

  -- Log the order in the OrderLogs table
  INSERT INTO OrderLogs(ProductID, Quantity, Action) 
  VALUES (productID, quantity, 'Ordered');
  
  -- Commit the transaction
  COMMIT;
END $$
DELIMITER ;

-- Call the procedure
CALL PlaceOrder(101, 5);

SET SQL_SAFE_UPDATES = 0;
SET GLOBAL SQL_SAFE_UPDATES = 1;

DROP PROCEDURE IF EXISTS PlaceOrder;








DELIMITER $$
CREATE PROCEDURE SafeUpdateStock(IN productID INT, IN newQuantity INT)
BEGIN
  -- Declare error handler to manage any SQL exceptions
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;  -- Roll back the transaction in case of an error
DELIMITER $$
CREATE PROCEDURE SafeUpdateStock(IN productID INT, IN newQuantity INT)
BEGIN
  -- Declare error handler to manage any SQL exceptions
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;  -- Roll back the transaction in case of an error
    SELECT 'Error: Transaction Failed';  -- Return an error message
  END;
  
  -- Start the transaction block
  START TRANSACTION;
  
  -- Update the stock for the specified product
  UPDATE Products 
  SET Stock = newQuantity 
  WHERE ProductID = productID;
  
  -- Commit the transaction if no error occurs
  COMMIT;
END $$
DELIMITER ;

-- Call the procedure
CALL SafeUpdateStock(101, 50);


DROP PROCEDURE IF EXISTS SafeUpdateStock;
