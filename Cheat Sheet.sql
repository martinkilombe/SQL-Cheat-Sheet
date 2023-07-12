SELECT * FROM electric;

--Filtering Output -
--Comparison Operators
SELECT "Model" FROM electric
WHERE "Electric_Range"

--Like
SELECT "Make", "Model" FROM electric
WHERE "Make" LIKE '%TESLA' 

--Counting the Number of Vehicles(COUNT) between 2015 AND 2021
SELECT COUNT("Model_Year") FROM electric
WHERE "Model_Year" BETWEEN 2015 AND 2021

