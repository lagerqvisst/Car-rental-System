--Grupp 1: Adam Wadheden Adam Ågestedt, Alexander Lagerqvist, Daniel Ward, Emilit Trujillo Diaz
--Uppgift 3 

--A)
--Since we need data from two different tables we include the required tables in the FROM clause. 
--We connect the tables by using the FK in Fordon and point to the PK in Fordonsstatuskod.
--We set the condition to only produce results on "Available" vehicles. 
--Since ascending order is set on default we specify we want a decending order.

SELECT Registreringsnummer, Modell, Miltal
FROM Fordon f, Fordonsstatus fs
WHERE f.Fordonsstatuskod = fs.Fordonsstatuskod
AND fs.[Status] = 'Tillgänglig'
ORDER BY Miltal DESC; 

--B)
--We use " * " to instruct we want all data from the table Bokning. 
--The only condition is to display bookings where the licence plate is "PPP409"
--Like the previous assignemnt we declare a decending order.

SELECT * 
FROM Bokning
WHERE Registreringsnummer = 'PPP409'
ORDER BY Kundnummer DESC;

--C) 
--The difference in approach compared to the previous assignments is the use of BETWEEN to create a date interval as a conditional statement in the WHERE clause.
--This makes it possble to display all bookings within this interval
--Updated the query as per the updated lab-file where its now ORDER BY FranDatum in ascending order.

SELECT Bokningsnummer, Registreringsnummer,Bokningsstatuskod, FranDatum,TillDatum 
FROM Bokning
WHERE FranDatum BETWEEN '2021-05-01' AND '2021-05-30'
ORDER BY FranDatum; 

--D) 
--Instead of SELECT we need to use UPDATE to alter values in an exisiting table. 
--We could simply hardcode the value 3 in the SET statemenet. But to showecase the power of relational datebases,
-- we utilize a subquery to get the value 3 through the Status instead.
-- The final SELECT statement is used to verify that the result was produced as expected. 
UPDATE Bokning
SET Bokningsstatuskod = (SELECT Bokningsstatuskod FROM Bokningsstatus WHERE [Status] = 'Återlämnad')
WHERE Registreringsnummer = 'HAP555'

SELECT Registreringsnummer, Bokningsstatuskod
FROM Bokning
WHERE Registreringsnummer = 'HAP555'

--E)
--A fairly simple SELECT query where was ask to see some information from the rental store (uthyrningstalle)
--As we did not add a website to one of the stores and accepted null values for that column we can add "IS NOT NULL"
--to our conditional statement in the WHERE caluse to only produce results of the rental stores that does infact have a website. 

SELECT Namn, Ort,Email
FROM Uthyrningsstalle
WHERE Webbsida IS NOT NULL


