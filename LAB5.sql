--GRUPP 1 Adam Wadheden Adam Ågestedt Alexander Lagerqvist Daniel Ward Emilit Trujillo Diaz
--LABB 5

--A)
--To extract the requested information we need to access 3 tables: Bokning, Fordon, & Kund. 
--We connect the booking table with the client table on the client number (kundnummer).
--This will allow for the WHERE clause conditional statement to only get the booking from 'Maria Svensson'
--We also connect the vehicle table with the booking table on the licence plate in order to access the vehicle car model. 
--With the TIP in the assignment we utilize "DATEDIFF" in order to display the amount of days the vehicle was booked for.

SELECT b.Bokningsnummer, b.Registreringsnummer, f.Modell, b.FranDatum, b.TillDatum, DATEDIFF(day, b.FranDatum, b.TillDatum) AS [Antal hyrda dygn]
FROM Bokning b
JOIN Kund k ON b.Kundnummer = k.Kundnummer
JOIN Fordon f ON f.Registreringsnummer = b.Registreringsnummer
WHERE k.Efternamn = 'Svensson' AND k.Fornamn = 'Maria'
ORDER BY Bokningsnummer


--B)
-- To extract the requested information we again need to access 3 tables: Bokning, Fordon, & Kund. 
-- This is a two-part question where 
-- ** A: Exclude bookings from the city of Gothenburg
-- ** B: Include instances of vehicles that does NOT apperar in the booking table. 
-- By "LEFT-JOIN"ing the Booking talbe onto the Vehicle table we resolve the question of seeing which vehicles that does not have a booking.
-- This allows for us to include "IS NULL" as a part of the WHERE clause to show which vehicles that does not have a booking.
-- *** -> NOTE that we included Bokningsnummer to really highlight that this is the case by showing that they are infact NULL. 
-- By "LEFT-JOIN"ing the Kund talbe we ensure that we continue to show the NULL results from the booking as an INNER JOIN would require a match in both tables.
-- *** -> NOTE that we also included the client's city to better demonstrate that we do infact show the exclusions of bookings with clients from Gothenburg. 
-- Some vehichles might return duplicated returns due to different customers from the city of Borås has booked the same car. 

--After the ZOOM session with Liran we had discussed the WHERE clause which gave us some issues due to us using AND instead of OR. 
--We concluded that it was logical to use OR in this case as the use of "AND" would not produce any results at all. 

SELECT f.Registreringsnummer,f.Modell, f.Miltal, b.Bokningsnummer, k.Ort as [Kundens ort]
FROM Fordon f 
LEFT JOIN Bokning b ON f.Registreringsnummer = b.Registreringsnummer
LEFT JOIN Kund k ON b.Kundnummer = k.Kundnummer
WHERE k.Ort != 'Göteborg' OR b.Bokningsnummer IS NULL


--C) 
-- To extract the requested information we  need to access 3 tables: Bokning, Kund, and Uthyrningsstalle. 
-- Uthyrningsstallenummer & Aterlamningsstalle nummer in Bokning both reference the same primary key in the home relation "Uthyrningsstalle".
-- As we are only interested in the return place (Aterlamningsstallenummer) we connect the tables using this key.
-- This allows us to get the name of the city the vehicle was returned and we can use this to compare to the clients city
-- once we also connected the client table with the booking table. In the WHERE clause we can easily say "give us the clients whom have returned their vehicle in a city they are not from"
-- As we aggregated the amount on days rented, we filter the results accordinly to only show results of bookings with more than 3 days. 

SELECT k.Kundnummer, k.Fornamn, k.Efternamn,k.Ort as [Kundens ort], us.Namn, us.Ort as [Återlämningsstallets ort], DATEDIFF(day, b.FranDatum, b.TillDatum) AS [Antal hyrda dygn]
FROM Bokning b
JOIN Uthyrningsstalle us ON us.Uthyrningsstallenummer = b.Aterlamningsstallenummer
JOIN Kund k ON b.Kundnummer = k.Kundnummer
WHERE us.Ort != k.Ort AND DATEDIFF(day, b.FranDatum, b.TillDatum) > 3


--D) 
--This assignment requires extraction from multiple tables: Fordon, Fordonstyp, Fordonslage, Fordonsstatus, Uthyrningsstalle
--The assignment is broken down into parts: 

--** 1: Indentify the unique vehicles (as there are duplicates in Fordonslage) and retrieve the vehicles with the latest date (closest to 2021-05-07)
--      By aggregating the dates using Max and then utilizing GROUP BY we exclude duplicates and also ensure the latest date. 
--      Save this result in an alias called "Bilar" in our case
--** 2: Reconnect the alias result with the orginal table "Fordonslage". 
--      Note that we JOIN on 2 keys, this is due to the fact that the table is made out of a composite PK.
--** 3: JOIN multiple tables in order to extract, filter and display the end result 
--** 4:  To ensure these vehicles are not already booked we use a second subquery to verify this. 
--      Before the subquery we utilize NOT EXIST to say "exclude" results if the following is true.
--      The interval ensures the booking does not overlap. 
--** 5: The final condition is based on vehicle status where we want to exclude any vehicle that is not "tillgänglig" (available)

--***Updated instructions as per Sep 19. Changed date 2020-05-15 to *2021-05-15.

SELECT f.Registreringsnummer, ft.Typ, f.Modell, f.Dagshyra, f.AntalPassagerare, f.Automat, u.Ort
FROM Fordon f
JOIN (
    SELECT fl.Registreringsnummer, MAX(fl.FranDatum) AS SenasteFranDatum --Aggregat på FranDaum så vi kan använda GROUP BY för unika reg. nummer
    FROM Fordonslage fl
    WHERE fl.FranDatum <= '2021-05-07 09:00'
    GROUP BY fl.Registreringsnummer --GROUP BY i delfrågan eftersom vi behöver unika registreringsnummer
) Bilar ON f.Registreringsnummer = Bilar.Registreringsnummer --Delfrågans resultat går under alias "Bilar" så den kan återanvändas nedan
JOIN Fordonslage fl ON Bilar.Registreringsnummer = fl.Registreringsnummer
AND Bilar.SenasteFranDatum = fl.FranDatum -- Pågrund av sammansatt PK-nyckel
JOIN Uthyrningsstalle u ON fl.Uthyrningsstallenummer = u.Uthyrningsstallenummer --Få tillgång tilluthyrningens ort.
JOIN Fordonstyp ft ON f.Fordonstypkod = ft.Fordonstypkod --Tillgång till fordonets typ (liten, stor miljö osv.)
JOIN Fordonsstatus fs ON f.Fordonsstatuskod = fs.Fordonsstatuskod --Används för att i slutet filtrera bort icke tillgängla forodn. 
WHERE Bilar.SenasteFranDatum <= '2021-05-07 09:00'
    AND NOT EXISTS ( 
        SELECT * -- Om det finns någon matchning nedan exkluderas fordon från resultatet.
        FROM Bokning b
        WHERE b.Registreringsnummer = Bilar.Registreringsnummer 
        AND (b.FranDatum <= '2021-05-15 19:00' AND b.TillDatum >= '2021-05-07 09:00') 
    )
AND fs.[Status] = 'Tillgänglig'  -- Filtrera att endast via "tillgängliga" bilar
ORDER BY f.AntalPassagerare, f.Dagshyra;


--E)
--This assignment provides some polishing to the previous one by transforming the previous date intervals into 2 separate variables. 
--After we exchange the hardcoded dates with the new variables which are now also adjusted according to the clients needs we recieve one more result in our query.
--** See new comments in the code where we have interchanged the dates with the new values
--Due to the earliest date in the interval being May 6th, we can see in the booking table that the Tesla with licence plate PPP409 is available after May 5th.


DECLARE @FranDatum AS DATE = '2021-05-06 09:00';
DECLARE @TillDatum AS DATE = '2021-05-10 19:00';


SELECT f.Registreringsnummer, ft.Typ, f.Modell, f.Dagshyra, f.AntalPassagerare, f.Automat, u.Ort
FROM Fordon f
JOIN (
    SELECT fl.Registreringsnummer, MAX(fl.FranDatum) AS SenasteFranDatum 
    FROM Fordonslage fl
    WHERE fl.FranDatum <= @TillDatum --INCLUDED NEW VARIABLE
    GROUP BY fl.Registreringsnummer 
) Bilar ON f.Registreringsnummer = Bilar.Registreringsnummer 
JOIN Fordonslage fl ON Bilar.Registreringsnummer = fl.Registreringsnummer
AND Bilar.SenasteFranDatum = fl.FranDatum 
JOIN Uthyrningsstalle u ON fl.Uthyrningsstallenummer = u.Uthyrningsstallenummer 
JOIN Fordonstyp ft ON f.Fordonstypkod = ft.Fordonstypkod 
JOIN Fordonsstatus fs ON f.Fordonsstatuskod = fs.Fordonsstatuskod 
WHERE Bilar.SenasteFranDatum <= @TillDatum --INCLUDED NEW VARIABLE
    AND NOT EXISTS ( 
        SELECT * 
        FROM Bokning b
        WHERE b.Registreringsnummer = Bilar.Registreringsnummer
        AND (b.FranDatum <= @TillDatum AND b.TillDatum >= @FranDatum) --INCLUDED NEW VARIABLE(s)
    )
AND fs.[Status] = 'Tillgänglig'
ORDER BY f.AntalPassagerare, f.Dagshyra;







    





