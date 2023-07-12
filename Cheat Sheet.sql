SELECT * FROM electric;

--Filtering Output -
--Comparison Operators
SELECT "Model" FROM electric
WHERE "Electric_Range"

--Like
SELECT "Make", "Model" FROM electric
WHERE "Make" LIKE '%TESLA' 



--AGGREGATE FUNCTIONS
--(COUNT)
SELECT COUNT("Model_Year") FROM electric
WHERE "Model_Year" BETWEEN 2015 AND 2021
--DISTINCT(COUNT)
SELECT "Make", COUNT(DISTINCT "Make")FROM electric
GROUP BY "Make"

--MIN(),MAX()
SELECT MIN("Electric_Range")as Minimum_Mileage, Max("Electric_Range")as Maximum_Mileage FROM electric;

--AVG(), GROUP BY(), HAVING()
SELECT "Vehicle_ID", AVG("Electric_Range") FROM electric
GROUP BY "Vehicle_ID"
HAVING AVG("Electric_Range")>50;


--SUBQUERIES
SELECT ss