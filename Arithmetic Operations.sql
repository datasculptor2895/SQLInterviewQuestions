DROP TABLE IF EXISTS Operation;

CREATE TABLE Operation
(
	[Index] INT,
	[Value] INT,
	[Formula] nvarchar(10)

)

INSERT INTO Operation
VALUES
(1,10,'4+5'),
(2,20,'7-3'),
(3,30,'9-6'),
(4,40,'2+8'),
(5,50,'7+6'),
(6,60,'6-8'),
(7,70,'9*10'),
(8,80,'3*7'),
(9,90,'7/10'),
(10,100,'10/3')

SELECT * FROM Operation

;WITH CTE
AS(
SELECT *
,CASE WHEN Formula LIKE '%+%' THEN SUBSTRING(Formula,0,CHARINDEX('+',Formula))
 WHEN Formula LIKE '%-%' THEN SUBSTRING(Formula,0,CHARINDEX('-',Formula))
 WHEN Formula LIKE '%*%' THEN SUBSTRING(Formula,0,CHARINDEX('*',Formula))
 WHEN Formula LIKE '%/%' THEN SUBSTRING(Formula,0,CHARINDEX('/',Formula))
 END AS LeftN
,CASE WHEN Formula LIKE '%+%' THEN SUBSTRING(Formula,CHARINDEX('+',Formula)+1,LEN(Formula))
 WHEN Formula LIKE '%-%' THEN SUBSTRING(Formula,CHARINDEX('-',Formula)+1,LEN(Formula))
 WHEN Formula LIKE '%*%' THEN SUBSTRING(Formula,CHARINDEX('*',Formula)+1,LEN(Formula))
 WHEN Formula LIKE '%/%' THEN SUBSTRING(Formula,CHARINDEX('/',Formula)+1,LEN(Formula))
 END AS RightN
FROM Operation
)

SELECT CT.[Index],CT.Value,CT.Formula,L.Value,R.Value, 
CASE WHEN CT.Formula LIKE '%+%' THEN CONVERT(varchar,L.Value+R.Value)
WHEN CT.Formula LIKE '%-%' THEN CONVERT(varchar,L.Value-R.Value)
WHEN CT.Formula LIKE '%*%' THEN CONVERT(varchar,L.Value*R.Value)
WHEN CT.Formula LIKE '%/%' THEN CONVERT(varchar,L.Value*1.0/R.Value)
END AS NewValue
FROM CTE CT
LEFT JOIN Operation L
ON CT.LeftN = L.[Index]
LEFT JOIN Operation R
ON CT.RightN = R.[Index]