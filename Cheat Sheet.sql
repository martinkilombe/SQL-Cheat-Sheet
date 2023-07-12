
---LOGICAL ORDER OF OPERATIONS IN SQL---
1. FROM, JOIN
2. WHERE
3. GROUP BY
4. aggregate functions
5. HAVING
6. window functions
7. SELECT
8. DISTINCT
9. UNION/INTERSECT/EXCEPT
10. ORDER BY
11. OFFSET
12. LIMIT/FETCH/TOP

SELECT * FROM electric;

--Filtering Output--
--Comparison Operators--
SELECT "Model" FROM electric
WHERE "Electric_Range"

--Like--
SELECT "Make", "Model" FROM electric
WHERE "Make" LIKE '%TESLA' 



--AGGREGATE FUNCTIONS--
--(COUNT)--
SELECT COUNT("Model_Year") FROM electric
WHERE "Model_Year" BETWEEN 2015 AND 2021
--DISTINCT(COUNT)
SELECT "Make", COUNT(DISTINCT "Make")FROM electric
GROUP BY "Make"

--MIN(),MAX()--
SELECT MIN("Electric_Range")as Minimum_Mileage, Max("Electric_Range")as Maximum_Mileage FROM electric;

--AVG(), GROUP BY(), HAVING()--
SELECT "Vehicle_ID", AVG("Electric_Range") FROM electric
GROUP BY "Vehicle_ID"
HAVING AVG("Electric_Range")>50;


--SUBQUERIES--
--Tesla vehicle millage >50 miles'--
SELECT "Electric_Range","Make" FROM electric
WHERE "Electric_Range" IN (
	SELECT "Electric_Range" 
	FROM electric
	WHERE "Electric_Range" > 50
);
--Vehicles made > 2020 and have a milleage > 100--
SELECT "Vehicle_ID","Model", "Make","Electric_Range" FROM electric
WHERE "Model_Year" > 2020 AND "Electric_Range" > 50

--Window Functions--
SELECT column1 , column2,....,
	Window_function() OVER (PARTITION BY column1, column2,...)
FROM Table;

--Example--
SELECT "Make","Model_Year","Electric_Range",
	AVG("Electric_Range") OVER (PARTITION BY "Make","Model_Year") AS Average_Mileage
FROM electric;



