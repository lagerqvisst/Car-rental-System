--Grupp 1: Adam Wadheden Adam Ågestedt, Alexander Lagerqvist, Daniel Ward, Emilit Trujillo Diaz
--Uppgift 4

--a) 
--We use an aggregated function Count in the SELECT clause to act as the amount of customers for certain cities. 
--WHERE "IN" is utilized to compare two values in the ORT column. We only want to produce results where a customer is from Stockholm or Gothenburg.
--When working with aggregated functions, we need to use GROUP BY on the column that the aggregated function derives from, in this case Ort. 

SELECT Ort, count(Ort) as [Antal Kunder]
FROM Kund
WHERE ORT IN ('Stockholm', 'Göteborg')
GROUP BY Ort
ORDER BY Ort


--b)
--We discussed this specific question in our zoom session on Sep 14 monday 09:00 where we determined that the instruction to show vehicle type code (Fordonstypskod)
--would produce an error and that we should rather list AntalPassagerare which the aggregated function is dervied from. 
--Generally this assignment is similar to a). 

SELECT AntalPassagerare, avg(Dagshyra) as [Genomsnittlig Dagshyra]
FROM Fordon
GROUP BY AntalPassagerare
ORDER BY AntalPassagerare

--c) 
--To build on the previous assignment we want to exclude some records that impacts the caluclation the average daily rent. 
--In the WHERE caluse we exclude those vehicles with a daily rent above 3000. 
--Initially we thought about using HAVING after caluclation was made but that only filters the already made calculations on all records, hence using WHERE to exclude. 

SELECT AntalPassagerare, avg(Dagshyra) as [Genomsnittlig Dagshyra]
FROM Fordon
WHERE Dagshyra <3000
GROUP BY AntalPassagerare
ORDER BY AntalPassagerare

--d)
--Similar but slighly different to the previous question, we get to utilize the HAVING function to filter the aggregated function. 
--In the WHERE clause we use <> to achieve a " != " (not equal to) operator to exclude results where the the vehicle was returned at a different place than where it was rented orginally.
--The HAVING clause filters the amount of cars that satisfy the condition in the WHERE clause. 
--This query does not produce any results as there are bookings with more than one instance of the return place being different to the orginal rental place.
--**This was also discussed in the discussions forum where you clarified that it's correct that this query should not return any results.

--***updated instructions as per Sep 19 to have Uthamtningsstalle nummer = to Aterlamningstalle, previously stated as not equal to each other.

SELECT Registreringsnummer, count(Registreringsnummer) AS [Antal Bokningar], Uthamtningsstallenummer
FROM Bokning
WHERE Uthamtningsstallenummer = Aterlamningsstallenummer --updated from <> to = 
GROUP by Registreringsnummer, Uthamtningsstallenummer
HAVING count(Registreringsnummer) > 1
ORDER BY Uthamtningsstallenummer
