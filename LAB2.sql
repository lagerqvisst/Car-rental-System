--Grupp 1 Adam Wadheden, Adam Ågestedt,Alexander Lagerqvist,Daniel Ward, Emilit Trujillo Diaz


--Uppgift 2a)

--KUNDDATA
INSERT INTO Kund (Kundnummer, Fornamn,Efternamn, Adress, Postnummer, Ort, Telefonnummer)
VALUES (1,'Maria','Svensson','Solbacken 5','50636','Borås','033123456')
INSERT INTO Kund VALUES (2,'Anna',  'Olsson', 'Kyrkogatan 11','50912','Borås','033112233')
INSERT INTO Kund VALUES (3,'Anders','Andersson','Sandvägen 7','41137','Göteborg','031332211')
INSERT INTO Kund VALUES (4,'Ulf','Toresson', 'Sjögatan 3','50812','Borås','033542312')
INSERT INTO Kund VALUES (5,'Sten','Larsson','Fågelvägen 15','40625','Göteborg','033247278')
INSERT INTO Kund VALUES (6,'Bror','Svantesson', 'Kungsgatan 1','50711','Borås','033772058')
INSERT INTO Kund VALUES (7,'Lena','Johansson', 'Karlavägen 23','10342','Stockholm','086305112')

--UTHYRNINGSSTALLE
INSERT INTO Uthyrningsstalle (Uthyrningsstallenummer,Namn,Adress,Postnummer,Ort,Telefonnummer,Email,Webbsida)
VALUES (1,'BU Borås','Grågatan 5','50700','Borås','033500500', 'info@bu.se','www.bu.se/bs')
INSERT INTO Uthyrningsstalle VALUES (2,'BU Göteborg','Solgatan 2','40100','Göteborg','031303031','info@bu.se','www.bu.se/gbg')
INSERT INTO Uthyrningsstalle VALUES (3,'BU Stockholm','Sengatan 6','10425','Stockholm','080101010','info@bu.se',NULL)

--FORDONSTYP
INSERT INTO Fordonstyp (Fordonstypkod, Typ) VALUES(1,'Liten')
INSERT INTO Fordonstyp VALUES(2,'Mellan')
INSERT INTO Fordonstyp VALUES(3,'Stor')
INSERT INTO Fordonstyp VALUES(4,'Minibuss')
INSERT INTO Fordonstyp VALUES(5,'Miljöbil')

--FORDONSSTATUS
INSERT INTO Fordonsstatus (Fordonsstatuskod, [Status]) VALUES (1,'Tillgänglig')
INSERT INTO Fordonsstatus VALUES (2,'Underhåll')
INSERT INTO Fordonsstatus VALUES (3,'Utgått')

--FORDON
INSERT INTO Fordon (Registreringsnummer,Fordonstypkod,Modell,Miltal,Dagshyra,AntalPassagerare,Automat,Fordonsstatuskod)
VALUES ('ABC123', 1, 'Toyota Aygo 1.0',1000,1000.00,4,0,1)
INSERT INTO Fordon VALUES ('ADN274', 2, 'Volkswagen Passat 2.0',1000,1000.00,5,0,2)
INSERT INTO Fordon VALUES ('AVE693', 2, 'Polestar 2',300,3000.00,4,1,1)
INSERT INTO Fordon VALUES ('BUS104', 4, 'Volkswagen Sharan',3000,1000.00,7,0,2)
INSERT INTO Fordon VALUES ('GPS935', 3, 'Hyundai Sonata',1500,1750.00,5,1,1)
INSERT INTO Fordon VALUES ('HAP555', 3, 'Volvo V60 Plug-In',750,1750.00,5,1,1)
INSERT INTO Fordon VALUES ('KAD395', 4, 'Volkswagen Transporter',2500,1750.00,9,1,1)
INSERT INTO Fordon VALUES ('LJF599', 1, 'Volkswagen Golf 1.6',3700,1350.00,5,1,3)
INSERT INTO Fordon VALUES ('PPP409', 5, 'Tesla Modell S',500,2500.00,4,1,1)

--BOKNINGSSTATUS
INSERT INTO Bokningsstatus (Bokningsstatuskod,[Status]) VALUES (1, 'Bokad')
INSERT INTO Bokningsstatus VALUES (2, 'Uthämtad')
INSERT INTO Bokningsstatus VALUES (3, 'Återlämnad')

--BOKNING
--Verified with Liran that TillDatum should be 2021 and not 2020. 
INSERT INTO Bokning (Bokningsnummer,Kundnummer,Registreringsnummer,Bokningsstatuskod,FranDatum,TillDatum,Uthamtningsstallenummer,Aterlamningsstallenummer)
VALUES (1,1,'ADN274',3,'2021-03-25 09:00','2021-04-05 09:00',1,1)
INSERT INTO Bokning VALUES (2,2,'KAD395',3,'2021-05-01 18:00','2021-05-15 18:00',1,2)
INSERT INTO Bokning VALUES (3,3,'PPP409',3,'2021-05-03 10:00','2021-05-05 18:00',2,2)
INSERT INTO Bokning VALUES (4,5,'PPP409',3,'2021-05-11 18:00','2021-05-13 18:00',2,2)
INSERT INTO Bokning VALUES (5,4,'GPS935',3,'2021-05-07 08:00','2021-05-09 19:00',1,1)
INSERT INTO Bokning VALUES (6,1,'AVE693',3,'2021-05-15 06:00','2021-05-15 19:00',3,3)
INSERT INTO Bokning VALUES (7,5,'HAP555',1,'2021-05-20 09:00','2021-05-27 09:00',2,1)
INSERT INTO Bokning VALUES (8,3,'BUS104',1,'2021-06-03 09:00','2021-06-17 09:00',2,2)
INSERT INTO Bokning VALUES (9,1,'ADN274',1,'2021-06-13 09:00','2021-06-15 15:00',1,1)
INSERT INTO Bokning VALUES (10,6,'AVE693',1,'2021-06-14 09:00','2021-06-14 17:00',2,2)

--FORDONSLÄGE
INSERT INTO Fordonslage (Registreringsnummer, FranDatum, Uthyrningsstallenummer)
VALUES ('ABC123','2021-01-01 00:00',2)
INSERT INTO Fordonslage VALUES ('ADN274','2021-01-01 00:00',1)
INSERT INTO Fordonslage VALUES ('AVE693','2021-05-11 00:00',3)
INSERT INTO Fordonslage VALUES ('BUS104','2021-01-01 00:00',2)
INSERT INTO Fordonslage VALUES ('GPS935','2021-01-01 00:00',1)
INSERT INTO Fordonslage VALUES ('HAP555','2021-01-01 00:00',2)
INSERT INTO Fordonslage VALUES ('KAD395','2021-01-01 00:00',1)
INSERT INTO Fordonslage VALUES ('LJF599','2021-01-01 00:00',1)
INSERT INTO Fordonslage VALUES ('PPP409','2021-05-01 00:00',2)
INSERT INTO Fordonslage VALUES ('KAD395','2021-04-15 18:00',2)
INSERT INTO Fordonslage VALUES ('HAP555','2021-07-12 09:00',1)



