USE krautundrueben;

/******************************************************************************/
/***                   Trigger Kunden Tabelle                               ***/
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
	NEUE_EMAIL VARCHAR (50));
    
CREATE TRIGGER TRIGGER_KUNDE_AENDERUNG AFTER
UPDATE ON KUNDE FOR EACH ROW INSERT INTO KUNDE_AENDERUNG (KUNDENR, AENDERUNGSDATUM, ALTER_NACHNAME, NEUER_NACHNAME, ALTER_VORNAME, NEUER_VORNAME, ALTES_GEBURTSDATUM, NEUES_GEBURTSDATUM, ALTE_STRASSE, NEUE_STRASSE, ALTE_HAUSNR, NEUE_HAUSNR, ALTE_PLZ, NEUE_PLZ, ALTER_ORT, NEUER_ORT, ALTE_TELEFON, NEUE_TELEFON, ALTE_EMAIL, NEUE_EMAIL) 
VALUES (old.KUNDENNR, now(), old.NACHNAME, new.NACHNAME, old.VORNAME, new.VORNAME, old.GEBURTSDATUM, new.GEBURTSDATUM, old.STRASSE, new.STRASSE, old.HAUSNR, new.HAUSNR, old.PLZ, new.PLZ, old.ORT, new.ORT, old.TELEFON, new.TELEFON, old.EMAIL, new.EMAIL); 

/******************************************************************************/
/***                   Trigger Bestellung Tabelle                               ***/
/******************************************************************************/


/******************************************************************************/
/***                   Trigger Kategorie Tabelle                               ***/
/******************************************************************************/


/******************************************************************************/
/***                   Trigger Lieferant Tabelle                               ***/
/******************************************************************************/


/******************************************************************************/
/***                   Trigger Rezept Tabelle                               ***/
/******************************************************************************/


/******************************************************************************/
/***                   Trigger Zutat Tabelle                               ***/
/******************************************************************************/
