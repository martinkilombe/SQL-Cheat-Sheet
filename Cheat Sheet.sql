
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


SELECT "Make", "Electric_Vehicle_Type","Model_Year",AVG("Electric_Range") 
OVER (PARTITION BY "Electric_Vehicle_Type" 
	  ORDER BY "Model_Year")
FROM electric;


--Ranking Functions--
--row_number() − unique number for each row within partition, with different numbers for tied values.--
--rank() − ranking within partition, with gaps and same ranking for tied values--
--dense_rank() − ranking within partition, with no gaps and same ranking for tied values.


--ROW_NUMBER()
ROW_NUMBER() OVER (PARTITION BY column1, column2, ... ORDER BY column3 [ASC|DESC])
--Example
SELECT "Make", "Electric_Vehicle_Type","Model_Year",
ROW_NUMBER () OVER (PARTITION BY "Electric_Vehicle_Type" 
					ORDER BY "Model_Year")
FROM electric;


--DENSE_RANK()
DENSE_RANK() OVER (PARTITION BY column1, column2,... ORDER BY column3 [ASC|DESC])
--Example
SELECT "Make","Electric_Vehicle_Type","Model_Year",
DENSE_RANK() OVER (PARTITION BY "Electric_Vehicle_Type" ORDER BY "Model_Year" ) FROM electric;


--RANK()
RANK()OVER (PARTITION BY column1, column2,... ORDER BY column3 [ASC|DESC])
--Example
SELECT "Make", "Electric_Vehicle_Type","Model_Year",
RANK() OVER (PARTITION BY "Electric_Vehicle_Type" ORDER BY "Model_Year" ) FROM electric;



--JOINS(Code ONLY)
SELECT col1.table1 , col1.table2
FROM table1
JOIN/LEFT/RIGHT/FULL/CROSS table2
ON table1.id = table2.id

--Examples
--1) INNER JOIN:The INNER JOIN returns only the matching rows between the tables being joined, based on the specified join condition. 
--It filters out any non-matching rows.
SELECT columns
FROM table1
INNER JOIN table2 ON table1.column = table2.column;
 
--2) LEFT JOIN (or LEFT OUTER JOIN):The LEFT JOIN returns all rows from the left (or first) table and the matching rows from the right (or second) table. 
--If there are no matching rows in the right table, NULL values are returned for the right table's columns.
SELECT columns
FROM table1
LEFT JOIN table2 ON table1.column = table2.column;


--3) RIGHT JOIN (or RIGHT OUTER JOIN):
--The RIGHT JOIN returns all rows from the right (or second) table and the matching rows from the left (or first) table. 
--If there are no matching rows in the left table, NULL values are returned for the left table's columns.
SELECT columns
FROM table1
RIGHT JOIN table2 ON table1.column = table2.column;

--4) FULL JOIN (or FULL OUTER JOIN):
--The FULL JOIN returns all rows from both tables, regardless of whether they have matching rows or not. 
--If there is no match, NULL values are returned for the columns of the non-matching table.
SELECT columns
FROM table1
FULL JOIN table2 ON table1.column = table2.column;



--TEXT FUNCTIONS
--CONCATENATION
SELECT 'Hi ' || 'there!';

--USEFUL FUNCTIONS
--Get the count of characters in a string:
SELECT LENGTH('LearnSQL.com');
-- result: 12


--Convert all letters to lowercase:
SELECT LOWER('LEARNSQL.COM');
-- result: learnsql.com

--Convert all letters to uppercase:
SELECT UPPER('LearnSQL.com');
-- result: LEARNSQL.COM


--Convert all letters to lowercase and all first letters to uppercase(not implemented in MySQL and SQL Server):
SELECT INITCAP('edgar frank ted cODD');
-- result: Edgar Frank Ted Codd

--Get just a part of a string:
SELECT SUBSTRING('LearnSQL.com', 9);
-- result: .com

SELECT SUBSTRING('LearnSQL.com', 0, 6);
-- result: Learn

--Replace part of a string:
SELECT REPLACE('LearnSQL.com', 'SQL', 
'Python');
-- result: LearnPython.com

--CASTING -From time to time, you need to change the type of a number. TheCAST() function is there to help you out. 
--It lets you change thetype of value to almost anything (integer, numeric, doubleprecision, varchar, and many more).
SELECT CAST (1234.567 AS integer)

SELECT CAST (COLUMN1 AS double precision)

--Rounding off -ROUND(number, decimal point)
SELECT ROUND(1234.56789)
SELECT ROUND(1234.56789, 2)

--Round upper - SELECT CEIL()
SELECT CEIL(13.1)
SELECT CEIL(13.5)

--Round down - SELECT FLOOR()
SELECT FLOOR(13.1)
SELECT FLOOR(13.5)

--To get the absolute value of a number:
SELECT ABS(-12); -- result: 12

--To get the square root of a number:
SELECT SQRT(9); -- result: 3


--CASE WHEN --The basic version of CASE WHEN checks if the values are equal.
--EXAMPLE 1
SELECT "Make","Model", "Model_Year",
	CASE
	WHEN "Electric_Range" <50 THEN 'Low Milleage'
	WHEN "Electric_Range" >100 THEN 'High Milleage'
	WHEN "Electric_Range" >=50 AND "Electric_Range" <=100 THEN 'Medium Milleage'
	ELSE 'NO Milleage'
	END AS vehicle_Milleage
FROM electric;

--EXAMPLE 2
SELECT "Make", "Model", "Model_Year",
    CASE
        WHEN AVG("Electric_Range") < 50 THEN 'Low Average Mileage'
        WHEN AVG("Electric_Range") > 100 THEN 'High Average Mileage'
        WHEN AVG("Electric_Range") >= 50 AND AVG("Electric_Range") <= 100 THEN 'Medium Average Mileage'
        ELSE 'No Mileage'
    END AS Vehicle_Average_Mileage
FROM electric
GROUP BY "Make", "Model", "Model_Year";


--MANAGING TABLES --
--CTE--
--Basic CTE example --
WITH EmployeeManagers AS (
    SELECT e.first_name AS employee_name, m.first_name AS manager_name
    FROM employees e
    JOIN employees m ON e.manager_id = m.employee_id
)
SELECT * FROM EmployeeManagers;


















