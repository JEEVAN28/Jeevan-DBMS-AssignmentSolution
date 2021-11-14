
CREATE SCHEMA TravelOnTheGo;
USE TravelOnTheGo;

CREATE TABLE `PASSENGER` (
	`Passenger_name` VARCHAR(100) NULL DEFAULT NULL,
	`Category` VARCHAR(100) NULL DEFAULT NULL,
	`Gender` VARCHAR(10) NULL DEFAULT NULL,
	`Boarding_City` VARCHAR(100) NULL DEFAULT NULL,
	`Destination_City` VARCHAR(100) NULL DEFAULT NULL,
	`Distance` INT NULL DEFAULT NULL,
	`Bus_Type` VARCHAR(50) NULL DEFAULT NULL
)
COLLATE='utf8_general_ci'
;

CREATE TABLE `PRICE` (
	`Bus_Type` VARCHAR(50) NULL DEFAULT NULL,
	`Distance` INT NULL DEFAULT NULL,
	`Price` INT NULL DEFAULT NULL
)
COLLATE='utf8_general_ci'
;

INSERT INTO passenger VALUES ('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper');
INSERT INTO passenger VALUES ('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting');
INSERT INTO passenger VALUES ('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper');
INSERT INTO passenger VALUES ('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper');
INSERT INTO passenger VALUES ('Udit', 'Non-AC', 'M', 'Trivandrum', 'Panaji', 1000, 'Sleeper');
INSERT INTO passenger VALUES ('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting');
INSERT INTO passenger VALUES ('Hemant', 'Non-AC', 'M', 'Panaji', 'Mumbai', 700, 'Sleeper');
INSERT INTO passenger VALUES ('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting');
INSERT INTO passenger VALUES ('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');

INSERT INTO price VALUES ('Sleeper', 350, 770);
INSERT INTO price VALUES ('Sleeper', 500, 1100);
INSERT INTO price VALUES ('Sleeper', 600, 1320);
INSERT INTO price VALUES ('Sleeper', 700, 1540);
INSERT INTO price VALUES ('Sleeper', 1000, 2200);
INSERT INTO price VALUES ('Sleeper', 1200, 2640);
INSERT INTO price VALUES ('Sleeper', 350, 434);
INSERT INTO price VALUES ('Sitting', 500, 620);
INSERT INTO price VALUES ('Sitting', 500, 620);
INSERT INTO price VALUES ('Sitting', 600, 744);
INSERT INTO price VALUES ('Sitting', 700, 868);
INSERT INTO price VALUES ('Sitting', 1000, 1240);
INSERT INTO price VALUES ('Sitting', 1200, 1488);
INSERT INTO price VALUES ('Sitting', 1500, 1860);

-- How many females and how many male passengers travelled for a minimum distance of 600 KM s?
SELECT t.gender, COUNT(Passenger_name) AS Passenger_Count FROM passenger t WHERE t.Distance >= 600 GROUP BY t.gender;

-- Find the minimum ticket price for Sleeper Bus
SELECT min(t.Price) AS Minimum_Ticket FROM price t WHERE t.Bus_Type = 'Sleeper';

-- Select passenger names whose names start with character 'S'
SELECT t.Passenger_name FROM passenger t WHERE t.Passenger_name LIKE 'S%';

-- Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output
SELECT t.Passenger_name, t.Boarding_City, t.Destination_City, t.Bus_Type, p.Price FROM passenger t Left Join price p ON p.Bus_Type = t.Bus_Type AND p.Distance = t.Distance;

-- What is the passenger name and his/her ticket price who travelled in Sitting bus for a distance of 1000 KMs
SELECT t.Passenger_name, p.Price FROM passenger t Left Join price p ON p.Bus_Type = t.Bus_Type AND p.Distance = t.Distance WHERE t.Distance >= 1000 AND t.Bus_Type = 'Sitting';

-- What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
SELECT p.Bus_Type, p.Price FROM price p WHERE p.Distance = (SELECT t1.distance FROM passenger t1 where t1.Boarding_City = 'Panaji' AND t1.Destination_City = 'Bengaluru');

-- List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order
SELECT distinct t.Distance FROM passenger t ORDER BY t.Distance DESC;

-- Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables
SELECT t.passenger_name, (t.Distance / (SELECT SUM(distance) AS s FROM passenger) * 100) AS `percent of total`  FROM passenger t;

/*
 Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise
*/
SELECT t.Distance, t.Price, 
Case 
	When t.Price > 1000 THEN 'Expensive' 
	When t.Price > 500 THEN 'Average Cost' 
	ELSE 'Cheap' 
END
FROM price t;