DROP DATABASE IF EXISTS krautundrueben;
CREATE DATABASE IF NOT EXISTS krautundrueben;
USE krautundrueben;


CREATE TABLE KUNDE (
    KUNDENNR        INTEGER NOT NULL,
    NACHNAME        VARCHAR(50),
    VORNAME         VARCHAR(50),
    GEBURTSDATUM	  DATE,
	 STRASSE         VARCHAR(50),
	 HAUSNR			  VARCHAR(6),			
    PLZ             VARCHAR(5),
    ORT             VARCHAR(50),
    TELEFON         VARCHAR(25),
    EMAIL           VARCHAR(50)
    );

CREATE TABLE ZUTAT(
    ZUTATENNR			INTEGER NOT NULL,
    BEZEICHNUNG      VARCHAR(50),
    EINHEIT        	VARCHAR (25),
    NETTOPREIS       DECIMAL(10,2),
    BESTAND          INTEGER,
    LIEFERANT			INTEGER,
	 KALORIEN			INTEGER,
	 KOHLENHYDRATE		DECIMAL (10,2),
	 PROTEIN				DECIMAL(10,2)
);

CREATE TABLE BESTELLUNG (
    BESTELLNR        INTEGER AUTO_INCREMENT NOT NULL,
    KUNDENNR         INTEGER,
    BESTELLDATUM     DATE,
    RECHNUNGSBETRAG  DECIMAL(10,2),
    PRIMARY KEY (BESTELLNR)
);

CREATE TABLE BESTELLUNGZUTAT (
    BESTELLNR       INTEGER NOT NULL,
    ZUTATENNR       INTEGER,
    MENGE     		  INTEGER
);

CREATE TABLE LIEFERANT (
    LIEFERANTENNR   INTEGER NOT NULL,
    LIEFERANTENNAME VARCHAR(50),
    STRASSE         VARCHAR(50),
    HAUSNR			  VARCHAR(6),
    PLZ             VARCHAR(5),
    ORT             VARCHAR(50),
    TELEFON			  VARCHAR(25),
    EMAIL           VARCHAR(50)
);

CREATE TABLE REZEPT (
   REZEPTNR         INTEGER AUTO_INCREMENT NOT NULL,
   TITEL            VARCHAR(250),
   INHALT           TEXT 
);

CREATE TABLE KATEGORIE (
    KATEGORIENR     INTEGER AUTO_INCREMENT NOT NULL,
    NAME            VARCHAR(50)
);

CREATE TABLE REZEPTKATEGORIE (
    REZEPTNR        INTEGER NOT NULL,
    KATEGORIENR     INTEGER NOT NULL         
);

CREATE TABLE UNVERTRAEGLICHKEIT (
    UNVERNR         INTEGER AUTO_INCREMENT NOT NULL,
    NAME            VARCHAR(50)
);

CREATE TABLE ZUTATUNVERTRAEGLICHKEIT (
    ZUTATENNR       INTEGER NOT NULL,
    UNVERNR         INTEGER NOT NULL
);


/******************************************************************************/
/***                              Primary Keys                              ***/
/******************************************************************************/


ALTER TABLE ZUTAT ADD PRIMARY KEY (ZUTATENNR);
ALTER TABLE KUNDE ADD PRIMARY KEY (KUNDENNR);
ALTER TABLE LIEFERANT ADD PRIMARY KEY (LIEFERANTENNR);
ALTER TABLE REZEPT ADD PRIMARY KEY (REZEPTNR);
ALTER TABLE KATEGORIE ADD PRIMARY KEY (KATEGORIENR);
ALTER TABLE UNVERTRAEGLICHKEIT ADD PRIMARY KEY (UNVERNR);
ALTER TABLE BESTELLUNGZUTAT ADD PRIMARY KEY (BESTELLNR,ZUTATENNR);
ALTER TABLE REZEPTKATEGORIE ADD PRIMARY KEY (REZEPTNR,KATEGORIENR);
ALTER TABLE ZUTATUNVERTRAEGLICHKEIT ADD PRIMARY KEY (ZUTATENNR,UNVERNR);


/******************************************************************************/
/***                              Foreign Keys                              ***/
/******************************************************************************/

ALTER TABLE ZUTAT ADD FOREIGN KEY (LIEFERANT) REFERENCES LIEFERANT (LIEFERANTENNR);
ALTER TABLE BESTELLUNGZUTAT ADD FOREIGN KEY (BESTELLNR) REFERENCES BESTELLUNG (BESTELLNR);
ALTER TABLE BESTELLUNG ADD FOREIGN KEY (KUNDENNR) REFERENCES KUNDE (KUNDENNR);
ALTER TABLE BESTELLUNGZUTAT ADD FOREIGN KEY (ZUTATENNR) REFERENCES ZUTAT (ZUTATENNR);
ALTER TABLE REZEPTKATEGORIE ADD FOREIGN KEY (REZEPTNR) REFERENCES REZEPT (REZEPTNR);
ALTER TABLE REZEPTKATEGORIE ADD FOREIGN KEY (KATEGORIENR) REFERENCES KATEGORIE (KATEGORIENR);
ALTER TABLE ZUTATUNVERTRAEGLICHKEIT ADD FOREIGN KEY (ZUTATENNR) REFERENCES ZUTAT (ZUTATENNR);
ALTER TABLE ZUTATUNVERTRAEGLICHKEIT ADD FOREIGN KEY (UNVERNR) REFERENCES UNVERTRAEGLICHKEIT (UNVERNR);