DROP TABLE IF EXISTS Products;
GO
 
CREATE TABLE Products
(
Product				VARCHAR(100),
Quantity            INTEGER NOT NULL
) 

INSERT INTO Products
VALUES
('Mobile',3),
('TV',5),
('Tablet',4)

SELECT * FROM Products
 
SELECT PRoduct,Quantity FROM Products
UNION ALL
SELECT Product,Quantity-1 FROM Products
UNION ALL
SELECT Product,Quantity-1 FROM (SELECT Product,Quantity-1 AS Quantity FROM Products) A

;WITH CTE
AS
(
SELECT Product,Quantity FROM Products
UNION ALL
SELECT Product,Quantity - 1 FROM CTE
WHERE Quantity>1
)
SELECT Product,1 AS Quantity FROM CTE
ORDER BY 1,2 DESC
 