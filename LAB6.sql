--GRUPP 1 Adam Wadheden Adam Ågestedt Alexander Lagerqvist Daniel Ward Emilit Trujillo Diaz
--LABB 6

--a) Skriv en SQL-sats som ändrar adressen på kunden med kundnummer 5 till ’Kviststigen 23’ med postnummer ’332 31’ i  orten ’Gislaved’.
-- This is a fairly simple update query where we update 3 columns on the client record with client number "3"

UPDATE Kund
SET Adress = 'Kviststigen 23', Postnummer = '33231', Ort = 'Gislaved'
WHERE Kundnummer = 5;


--b) Skriv en SQL-sats som adderar 100 mil till Miltal för bilarna med registreringsnummer ADN274 och ABC123.
-- Compared to the previous query, we only update on column but we update values for two records.
-- We also increment the current milage (miltal) by 100.
-- To ensure we update the 2 records, we use the "IN" statement to be able to handle multiple values that we want to match.

UPDATE Fordon
SET Miltal = Miltal + 100
WHERE Registreringsnummer IN ('ADN274','ABC123')


--c)Skriv en SQL-sats som lägger till hemsideadressen ’www.bu.se/sthlm’ för uthyrningsställe nummer 3.
-- This is a simple update query where set the rental stores website to an actual website (it was NULL when orginally created)
-- This is a similar approach as question a) but shorter.
UPDATE Uthyrningsstalle
SET Webbsida = 'www.bu.se/sthlm'
WHERE Uthyrningsstallenummer = 3


--d)Skriv en SQL-sats som ändrar samtliga bokade bilar i tabellen Bokning till uthämtade.
-- We could approach this assignment in multiple ways. An easy way would be to hard code the values that represents "Uthämtad" & "Bokad".
-- But to utilize the power of relational databases we try a sub-query for this instance to get the statuscode. 
UPDATE Bokning 
SET Bokningsstatuskod = (SELECT Bokningsstatuskod FROM Bokningsstatus WHERE [Status] = 'Uthämtad') 
WHERE Bokningsstatuskod = (SELECT Bokningsstatuskod FROM Bokningsstatus WHERE [Status] = 'Bokad') 


