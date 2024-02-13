DROP TABLE IF EXISTS Travel

CREATE TABLE Travel
(
	[Name] varchar(10),
	[Date] datetime,
	Origin varchar(10),
	Destination varchar(10)
)

INSERT INTO Travel
VALUES 
('Steve','1-1-2024','India','US'),
('Steve','1-2-2024','US','UK'),
('Steve','1-3-2024','UK','Japan'),
('Steve','1-10-2024','Australia','China'),
('Steve','1-11-2024','Japan','Russia'),
('Robin','1-1-2024','Africa','Singapore'),
('Robin','1-2-2024','Singapore','UK'),
('Robin','1-9-2024','US','India')

 

SELECT * FROM Travel

;WITH CTE
AS
(
SELECT *,DATEDIFF(day,[Date],DATEADD(day,ROW_NUMBER() OVER(PARTITION BY Name ORDER BY Date),'' )) AS DN
FROM Travel
),
CTE2
AS
(
SELECT Name,Dn,MIN(Date)AS MinD,MAX(Date)AS MaxD
FROM CTE
GROUP BY Name,DN
),CTE3
AS
(
SELECT T.Name,T.DN,'Origin' AS Place,T.Origin  AS Country
FROM CTE T
INNER JOIN CTE2 CO
ON T.Name=CO.Name
AND T.Date=CO.MinD 
UNION ALL
SELECT T.Name,T.DN,'DESTINATION' AS Place,T.Destination
FROM CTE T
INNER JOIN CTE2 CO
ON T.Name=CO.Name
AND T.Date=CO.MaxD 
)
SELECT  A.Name,A.Country AS Origin,B.Country AS Destination
FROM CTE3 A
LEFT JOIN CTE3 B
ON A.Name=B.Name
AND A.DN=B.DN
WHERE A.Place = 'Origin' AND B.Place='Destination'
 