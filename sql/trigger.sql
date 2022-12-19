USE krautundrueben;

/******************************************************************************/
/***                        Trigger Kunden Tabelle                          ***/
/******************************************************************************/

CREATE TABLE KUNDE_AENDERUNG (
	KUNDENR INTEGER NOT NULL,
    AENDERUNGSDATUM DATE,
    ALTER_NACHNAME VARCHAR (50),
    NEUER_NACHNAME VARCHAR (50),
    ALTER_VORNAME VARCHAR (50),
    NEUER_VORNAME VARCHAR (50),
    ALTES_GEBURTSDATUM DATE,
    NEUES_GEBURTSDATUM DATE,
    ALTE_STRASSE VARCHAR (50),
    NEUE_STRASSE VARCHAR (50),
    ALTE_HAUSNR VARCHAR (6),
    NEUE_HAUSNR VARCHAR (6),
    ALTE_PLZ VARCHAR (5),
    NEUE_PLZ VARCHAR (5),
    ALTER_ORT VARCHAR (50),
	NEUER_ORT VARCHAR (50),
	ALTE_TELEFON VARCHAR (25),
    NEUE_TELEFON VARCHAR (25),
	ALTE_EMAIL VARCHAR (50),
	NEUE_EMAIL VARCHAR (50),
    PRIMARY KEY(KUNDENNR));
    
CREATE TRIGGER TRIGGER_KUNDE_AENDERUNG AFTER
UPDATE ON KUNDE FOR EACH ROW INSERT INTO KUNDE_AENDERUNG (KUNDENR, AENDERUNGSDATUM, ALTER_NACHNAME, NEUER_NACHNAME, ALTER_VORNAME, NEUER_VORNAME, ALTES_GEBURTSDATUM, NEUES_GEBURTSDATUM, ALTE_STRASSE, NEUE_STRASSE, ALTE_HAUSNR, NEUE_HAUSNR, ALTE_PLZ, NEUE_PLZ, ALTER_ORT, NEUER_ORT, ALTE_TELEFON, NEUE_TELEFON, ALTE_EMAIL, NEUE_EMAIL) 
VALUES (old.KUNDENNR, now(), old.NACHNAME, new.NACHNAME, old.VORNAME, new.VORNAME, old.GEBURTSDATUM, new.GEBURTSDATUM, old.STRASSE, new.STRASSE, old.HAUSNR, new.HAUSNR, old.PLZ, new.PLZ, old.ORT, new.ORT, old.TELEFON, new.TELEFON, old.EMAIL, new.EMAIL); 

/******************************************************************************/
/***                     Trigger Bestellung Tabelle                         ***/
/******************************************************************************/

CREATE TABLE BESTELLUNG_AENDERUNG (
	BESTELLNR INTEGER NOT NULL,
    AENDERUNGSDATUM DATE,
    ALTE_KUNDENNR INTEGER,
    NEUE_KUNDENNR INTEGER,
    ALTES_BESTELLDATUM DATE,
    NEUES_BESTELLDATUM DATE,
    ALTER_RECHNUNGSBETRAG DECIMAL (10,2),
    NEUER_RECHNUNGSBETRAG DECIMAL (10,2),
    PRIMARY KEY(BESTELLNR)
);
    
CREATE TRIGGER TRIGGER_BESTELLUNG_AENDERUNG AFTER
UPDATE ON BESTELLUNG FOR EACH ROW INSERT INTO BESTELLUNG_AENDERUNG (BESTELLNR, AENDERUNGSDATUM, ALTE_KUNDENNR, NEUE_KUNDENNR, ALTES_BESTELLDATUM, NEUES_BESTELLDATUM, ALTER_RECHNUNGSBETRAG, NEUER_RECHNUNGSBETRAG) 
VALUES (old.BESTELLNR, now(), old.KUNDENNR, new.KUNDENNR, old.BESTELLDATUM, new.BESTELLDATUM, old.RECHNUNGSBETRAG, new.RECHNUNGSBETRAG); 

/******************************************************************************/
/***                   Trigger Lieferant Tabelle                               ***/
/******************************************************************************/

CREATE TABLE LIEFERANT_AENDERUNG (
	LIEFERANTENNR INTEGER NOT NULL,
    AENDERUNGSDATUM DATE,
    ALTER_LIEFERANTENNAME VARCHAR (50),
    NEUER_LIEFERANTENNAME VARCHAR (50),
    ALTE_STRASSE VARCHAR (50),
    NEUE_STRASSE VARCHAR (50),
    ALTE_HAUSNR VARCHAR (6),
    NEUE_HAUSNR VARCHAR (6),
    ALTE_PLZ VARCHAR (5),
    NEUE_PLZ VARCHAR (5),
    ALTER_ORT VARCHAR (50),
	NEUER_ORT VARCHAR (50),
	ALTE_TELEFON VARCHAR (25),
    NEUE_TELEFON VARCHAR (25),
	ALTE_EMAIL VARCHAR (50),
	NEUE_EMAIL VARCHAR (50),
    PRIMARY KEY(LIEFERANTENNR));
    
CREATE TRIGGER TRIGGER_LIEFERANT_AENDERUNG AFTER
UPDATE ON LIEFERANT FOR EACH ROW INSERT INTO LIEFERANT_AENDERUNG (LIEFERANTENNR, AENDERUNGSDATUM, ALTER_LIEFERANTENNAME, NEUER_LIEFERANTENNAME, ALTE_STRASSE, NEUE_STRASSE, ALTE_HAUSNR, NEUE_HAUSNR, ALTE_PLZ, NEUE_PLZ, ALTER_ORT, NEUER_ORT, ALTE_TELEFON, NEUE_TELEFON, ALTE_EMAIL, NEUE_EMAIL) 
VALUES (old.LIEFERANTENNR, now(), old.LIEFERANTENNAME, new.LIEFERANTENNAME, old.STRASSE, new.STRASSE, old.HAUSNR, new.HAUSNR, old.PLZ, new.PLZ, old.ORT, new.ORT, old.TELEFON, new.TELEFON, old.EMAIL, new.EMAIL);

/******************************************************************************/
/***                   Trigger Rezept Tabelle                               ***/
/******************************************************************************/

CREATE TABLE REZEPT_AENDERUNGEN (
    REZEPTNR INTEGER AUTO_INCREMENT NOT NULL,
    AENDERUNGSDATUM DATE,
    ALTER_TITEL VARCHAR(250),
    NEUER_TITEL VARCHAR(250),
    ALTER_INHALT TEXT,
    NEUER_INHALT TEXT,
    PRIMARY KEY(REZEPTNR));

CREATE TRIGGER TRIGGER_REZEPT_AENDERUNGEN AFTER
UPDATE ON REZEPT FOR EACH ROW INSERT INTO REZEPT_AENDERUNGEN (REZEPTNR, AENDERUNGSDATUM, ALTER_TITEL, NEUER_TITEL, ALTER_INHALT, NEUER_INHALT) 
VALUES (old.REZEPTNR, now(), old.TITEL, new.TITEL, old.INHALT, new.INHALT);

/******************************************************************************/
/***                   Trigger Zutat Tabelle                               ***/
/******************************************************************************/

CREATE TABLE ZUTAT_AENDERUNGEN (
    ZUTATENNR INTEGER NOT NULL,
    AENDERUNGSDATUM DATE,
    ALTE_BEZEICHNUNG VARCHAR (50),
    NEUE_BEZEICHNUNG VARCHAR(50),
    ALTE_EINHEIT VARCHAR (25),
    NEUE_EINHEIT VARCHAR (25),
    ALTER_NETTOPREIS DECIMAL(10,2),
    NEUER_NETTOPREIS DECIMAL(10,2),
    ALTER_BESTAND INTEGER,
    NEUER_BESTAND INTEGER,
    ALTER_LIEFERANT INTEGER,
    NEUER_LIEFERANT INTEGER,
    ALTE_KALORIEN INTEGER,
    NEUE_KALORIEN INTEGER,
    ALTE_KOHLENHYDRATE DECIMAL (10,2),
    NEUE_KOHLENHYDRATE DECIMAL (10,2),
    ALTE_PROTEIN DECIMAL(10,2),
    NEUE_PROTEIN DECIMAL(10,2),
    PRIMARY KEY(ZUTATENNR));

CREATE TRIGGER TRIGGER_ZUTAT_AENDERUNGEN AFTER
UPDATE ON ZUTAT FOR EACH ROW INSERT INTO ZUTAT_AENDERUNGEN (ZUTATENNR, AENDERUNGSDATUM, ALTE_BEZEICHNUNG, NEUE_BEZEICHNUNG, ALTE_EINHEIT, NEUE_EINHEIT, ALTER_NETTOPREIS, NEUER_NETTOPREIS, ALTER_BESTAND, NEUER_BESTAND, ALTER_LIEFERANT, NEUER_LIEFERANT, ALTE_KALORIEN, NEUE_KALORIEN, ALTE_KOHLENHYDRATE, NEUE_KOHLENHYDRATE, ALTE_PROTEIN, NEUE_PROTEIN) 
VALUES (old.ZUTATENNR, now(), old.BEZEICHNUNG, new.BEZEICHNUNG, old.EINHEIT, new.EINHEIT, old.NETTOPREIS, new.NETTOPREIS, old.BESTAND, new.BESTAND, old.LIEFERANT, new.LIEFERANT, old.KALORIEN, new.KALORIEN, old.KOHLENHYDRATE, new.KOHLENHYDRATE, old.PROTEIN, new.PROTEIN);