-- Grupp 1: Alexander Lagerqvist, Daniel Ward, Adam Wadheden, Adam Ågestedt, Emilit Trujillo Diaz
-- Uppgift 1a)

--Kund (Kundnummer, Fornamn, Efternamn, Adress, Postnummer, Ort, Telefonnummer)
--The table "Kund contains details" about the clients that are renting cars. The Kundnummer (client/customernumber) is the primary key. 
--All attributes does not accpet NULL values.


CREATE TABLE Kund(
    Kundnummer INT PRIMARY KEY,
    Fornamn VARCHAR(20) NOT NULL,
    Efternamn VARCHAR(25) NOT NULL,
    Adress VARCHAR(50) NOT NULL,
    Postnummer CHAR(5) NOT NULL,
    Ort VARCHAR(20) NOT NULL,
    Telefonnummer VARCHAR(10) NOT NULL
)
GO

--Uthyrningsstalle (Uthyrningsstallenummer, Namn, Adress, Postnummer, Ort, Telefonnummer, Email, Webbsida)
--The table "Uthyrningstalle" contains details about the rental facility. The Uthyrningsstallenummer is the primary key
--All attributes does not accpet NULL values with the exception of the website.


CREATE TABLE Uthyrningsstalle(
    Uthyrningsstallenummer INT PRIMARY KEY,
    Namn VARCHAR(30) NOT NULL,
    Adress VARCHAR(50) NOT NULL,
    Postnummer CHAR(5) NOT NULL,
    Ort VARCHAR(20) NOT NULL,
    Telefonnummer VARCHAR(10) NOT NULL,
    Email VARCHAR(40) NOT NULL,
    Webbsida VARCHAR(50)
)
GO
--Fordonstyp (Fordonstypkod, Typ)
--The table "Fordonstyp" contains information about the vehichle type, for eg. small, medium, large etc. Fordonstypskod (Vehicle type code) is the primary key and all columns does not accept NULL values

CREATE TABLE Fordonstyp(
    Fordonstypkod INT PRIMARY KEY,
    Typ VARCHAR(20) NOT NULL
)
GO
--Fordonsstatus (Fordondsstatuskod, Status)
--The table "Fordonsstatuskod" contains information about the state of a vehicle. For eg. available, service, obsolete. Fordonsstatuskod (Vehicle status code) is the primary key.
--Note the brackets around Status which is needed due to status being a reserved word in SQL. No columns accepts null values. 

CREATE TABLE Fordonsstatus(
    Fordonsstatuskod INT PRIMARY KEY,
    [Status] VARCHAR(20)
)
GO
--Fordon (Registreringsnummer, Fordonstypkod, Modell, Miltal, Dagshyra, AntalPassagerare, Automat, Fordonsstatuskod)
--The table "Fordon" (vehicle) contains information about the different vehicles that are potentially available to be booked for renting. 
--The primary key is the registreringsnummer (licenceplate) and there are also 2 foreign keys pointing to 2 different primary keys that
-- were created in the previous two tables. No null values are accepted.

CREATE TABLE Fordon(
    Registreringsnummer CHAR(6) PRIMARY KEY,
    Fordonstypkod INT NOT NULL, -- FOREIGN KEY TO "FORDONSTYP"
    Modell VARCHAR(50) NOT NULL,
    Miltal INT NOT NULL,
    Dagshyra DECIMAL (7,2) NOT NULL,
    AntalPassagerare INT NOT NULL,
    Automat BIT NOT NULL, -- 1/0 FÖR BOOLEANSK VÄRDE
    Fordonsstatuskod INT NOT NULL, -- FOREIGN KEY TILL FORDONSSTATUS
    FOREIGN KEY (Fordonstypkod) REFERENCES Fordonstyp (Fordonstypkod),
    FOREIGN KEY (Fordonsstatuskod) REFERENCES Fordonsstatus (Fordonsstatuskod)
)
GO
--Bokningsstatus (Bokningsstatuskod, Status)
--The table Bokningsstatus (booking status) contains information about a certain rental booking where the users of the booking system will be able to see 
-- if a certain rental car is booked, returned etc. The bokningsstatus code is the primary key, no null values are accepted.

CREATE TABLE Bokningsstatus(
    Bokningsstatuskod INT PRIMARY KEY,
    Status VARCHAR(15) NOT NULL
)
GO
--Bokning (Bokningsnummer, Kundnummer, Registreringsnummer, Bokningsstatuskod, FranDatum, TillDatum, Uthamntningsstallenummer, Aterlamningsstallenummer)
--The table Bokning (Bookings) contains a great deal of information regarding different bookings. The table contains mostly attributes as foreign keys pointing to
--other already created tables, 5 total foreign keys. 

CREATE TABLE Bokning(
    Bokningsnummer INT PRIMARY KEY,
    Kundnummer INT NOT NULL, -- FK
    Registreringsnummer CHAR(6) NOT NULL, -- FK
    Bokningsstatuskod INT NOT NULL, -- FK
    FranDatum DATETIME NOT NULL,
    TillDatum DATETIME NOT NULL,
    Uthamtningsstallenummer INT NOT NULL, -- FK
    Aterlamningsstallenummer INT NOT NULL, --FK

    FOREIGN KEY (Kundnummer) REFERENCES Kund (Kundnummer),
    FOREIGN KEY (Registreringsnummer) REFERENCES Fordon (Registreringsnummer),
    FOREIGN KEY (Bokningsstatuskod) REFERENCES Bokningsstatus (Bokningsstatuskod),
    FOREIGN KEY (Uthamtningsstallenummer) REFERENCES Uthyrningsstalle (Uthyrningsstallenummer),
    FOREIGN KEY (Aterlamningsstallenummer) REFERENCES Uthyrningsstalle (Uthyrningsstallenummer),

)
GO
--Fordonslage (Registreringsnummer, FranDatum, Uthyrningsstallenummer)
--The talbe Fordonsläge (Vehicle state) contains information on which rental store a certain vechicle is located on a certain date and time. 
--The unique part of this table compared to other tables is the use of a composite key where we combine registreringsnummer and frandatum to uniqley identify each row.

CREATE TABLE Fordonslage(
    Registreringsnummer CHAR(6) NOT NULL,
    FranDatum DATETIME NOT NULL,
    Uthyrningsstallenummer INT NOT NULL, 

    PRIMARY KEY (Registreringsnummer, FranDatum),
    FOREIGN KEY (Registreringsnummer) REFERENCES Fordon (Registreringsnummer),
    FOREIGN KEY (Uthyrningsstallenummer) REFERENCES Uthyrningsstalle (Uthyrningsstallenummer)
)
GO
-- Uppgift 1b)

--Skriv SQL-kod (en ALTER TABLE sats) som lägger till ett villkor vilket ser till att TillDatum är senare än FranDatum i tabellen Bokning.
-- Alter table is used to make changes to an already created table. The goal is to add a constraint to the table in order to prevent unlogical bookings.
-- A user of the system should not be albe to set the return date earlier the the start date of the rental. 

ALTER TABLE Bokning
ADD CONSTRAINT Valid_Date_Booking CHECK(TillDatum >= FranDatum)
GO

--c) Skriv SQL-kod som skapar vyn [Tillgängliga Fordon] som listar samtliga tillgängliga fordon (dvs. visa inte fordon som har utgått eller som det pågår underhåll på). 
-- Visa Registreringsnummer, Modell, AntalPassagerare samt Automat.
-- We use "CREATE VIEW" followed by the name of the view in brackets to declare the creation of a view.
-- Then we simply follow up by a SELECT query. Instead of hardcoding the value behind "Tillgänglig" -
-- we exercise the power of relational databases by utilzing a subquery to access the number. 

CREATE VIEW [Tillgängliga Fordon]

AS

SELECT Registreringsnummer, Modell, AntalPassagerare,Automat
FROM Fordon f
WHERE f.Fordonsstatuskod = (SELECT Fordonsstatuskod FROM Fordonsstatus WHERE [Status] = 'Tillgänglig')
GO