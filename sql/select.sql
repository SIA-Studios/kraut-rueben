/******************************************************************************/
/***          Auswahl aller Zutaten eines Rezepts nach Rezeptname           ***/
/******************************************************************************/

SELECT REZEPT.TITEL, ZUTAT.BEZEICHNUNG, ZUTAT.EINHEIT, ZUTAT.NETTOPREIS, ZUTAT.KALORIEN, ZUTAT.KOHLENHYDRATE, ZUTAT.PROTEIN
    FROM ZUTAT
    INNER JOIN REZEPTZUTAT ON REZEPTZUTAT.ZUTATENNR = ZUTAT.ZUTATENNR
    INNER JOIN REZEPT ON REZEPT.REZEPTNR = REZEPTZUTAT.REZEPTNR
    WHERE REZEPT.TITEL = 'xxx';

/******************************************************************************/
/***       Auswahl aller Rezepte einer bestimmten Ernährungskategorie       ***/
/******************************************************************************/

/* 1 Kategorie */
SELECT DISTINCT REZEPT.TITEL, REZEPT.INHALT, KATEGORIE.NAME FROM REZEPT, REZEPTKATEGORIE, KATEGORIE WHERE REZEPT.REZEPTNR = REZEPTKATEGORIE.REZEPTNR 
    AND REZEPTKATEGORIE.KATEGORIENR = KATEGORIE.KATEGORIENR AND KATEGORIE.NAME = 'xxx';

/* 2 Kategorien */
SELECT DISTINCT REZEPT.TITEL, REZEPT.INHALT, KATEGORIE.name FROM REZEPT, REZEPTKATEGORIE, KATEGORIE WHERE 
    REZEPT.REZEPTNR = REZEPTKATEGORIE.REZEPTNR 
    AND REZEPTKATEGORIE.KATEGORIENR = KATEGORIE.KATEGORIENR 
    AND (KATEGORIE.NAME = 'xxx' OR KATEGORIE.NAME = 'xxx') ;
    
/******************************************************************************/
/***        Auswahl aller Rezepte, die eine bestimme Zutat enthalten        ***/
/******************************************************************************/

SELECT * FROM REZEPT WHERE REZEPTNR IN 
   (SELECT REZEPTNR FROM REZEPTZUTAT WHERE ZUTATENNR IN 
   (SELECT ZUTATENNR FROM ZUTAT WHERE BEZEICHNUNG = "xxx"))    

/******************************************************************************/
/***      Durchschnittliche Nährwerte aller Bestellungen eines Kunden       ***/
/******************************************************************************/

SELECT KUNDE.KUNDENNR, KUNDE.VORNAME, KUNDE.NACHNAME, AVG(ZUTAT.KALORIEN) AS Kaloriendurchschnitt, AVG(ZUTAT.KOHLENHYDRATE) AS Kohlenhydratedurchschnitt, AVG(ZUTAT.PROTEIN) AS Proteindurchschnitt
    FROM ZUTAT
    LEFT JOIN BESTELLUNGZUTAT ON ZUTAT.ZUTATENNR = BESTELLUNGZUTAT.ZUTATENNR
    LEFT JOIN BESTELLUNG ON BESTELLUNGZUTAT.BESTELLNR = BESTELLUNG.BESTELLNR
    LEFT JOIN KUNDE ON BESTELLUNG.KUNDENNR = KUNDE.KUNDENNR
    WHERE KUNDE.KUNDENNR = 000;

/******************************************************************************/
/***               Zutaten, die keinem Rezept zugeordnet sind               ***/
/******************************************************************************/

SELECT * FROM ZUTAT
WHERE ZUTAT.ZUTATENNR NOT IN (SELECT BESTELLUNGZUTAT.ZUTATENNR FROM BESTELLUNGZUTAT); 

/******************************************************************************/
/***        Alle Rezepte, die eine Kalorienmenge nicht überschreiten        ***/
/******************************************************************************/

SELECT * FROM
    (SELECT R.TITEL, SUM(Z.KALORIEN * RZ.MENGE) AS Kaloriensumme FROM REZEPT AS R
    JOIN REZEPTZUTAT AS RZ
    ON R.REZEPTNR = RZ.REZEPTNR
    JOIN ZUTAT AS Z
    ON Z.ZUTATENNR = RZ.ZUTATENNR
    GROUP BY R.REZEPTNR) KALORIEN
    WHERE Kaloriensumme < 10000;

/******************************************************************************/
/***                   Rezepte mit weniger als 5 Zutaten                    ***/
/******************************************************************************/

SELECT * FROM REZEPT
    WHERE 5 > (SELECT COUNT(*) FROM REZEPTZUTAT WHERE REZEPTZUTAT.REZEPTNR = REZEPT.REZEPTNR);

/******************************************************************************/
/***       Rezepte mit weniger als 5 Zutaten und bestimmter Kategorie       ***/
/******************************************************************************/

SELECT * FROM REZEPT
    WHERE (5 > (SELECT COUNT(*) FROM REZEPTZUTAT WHERE REZEPTZUTAT.REZEPTNR = REZEPT.REZEPTNR))
    AND REZEPTNR IN (SELECT REZEPTNR FROM REZEPTKATEGORIE WHERE KATEGORIENR IN (SELECT KATEGORIENR FROM KATEGORIE WHERE NAME = "xxx"));

/******************************************************************************/
/***       Auswahl aller Rezepte, die einen Preis nicht überschreiten       ***/
/******************************************************************************/

SELECT * FROM
    (SELECT R.TITEL, SUM(Z.NETTOPREIS * RZ.MENGE) AS Preis FROM REZEPT AS R
    JOIN REZEPTZUTAT AS RZ
    ON R.REZEPTNR = RZ.REZEPTNR
    JOIN ZUTAT AS Z
    ON Z.ZUTATENNR = RZ.ZUTATENNR
    GROUP BY R.REZEPTNR) KALORIEN
    WHERE Preis < 3;

/******************************************************************************/
/***                       Rezepte nach Unverträglichkeit                   ***/
/******************************************************************************/

/* 1 Unverträglichkeit */
SELECT DISTINCT REZEPT.TITEL, REZEPT.INHALT FROM REZEPT, REZEPTZUTAT, ZUTATUNVERTRAEGLICHKEIT, UNVERTRAEGLICHKEIT 
    WHERE REZEPT.REZEPTNR = REZEPTZUTAT.REZEPTNR
    AND REZEPTZUTAT.ZUTATENNR = ZUTATUNVERTRAEGLICHKEIT.ZUTATENNR 
    AND ZUTATUNVERTRAEGLICHKEIT.UNVERNR != UNVERTRAEGLICHKEIT.UNVERNR 
    AND UNVERTRAEGLICHKEIT.NAME = 'xxx';

/* 2 Unverträglichkeiten */
SELECT DISTINCT REZEPT.TITEL, REZEPT.INHALT FROM REZEPT, REZEPTZUTAT, ZUTATUNVERTRAEGLICHKEIT, UNVERTRAEGLICHKEIT 
    WHERE REZEPT.REZEPTNR = REZEPTZUTAT.REZEPTNR
    AND REZEPTZUTAT.ZUTATENNR = ZUTATUNVERTRAEGLICHKEIT.ZUTATENNR 
    AND ZUTATUNVERTRAEGLICHKEIT.UNVERNR = UNVERTRAEGLICHKEIT.UNVERNR 
    AND (UNVERTRAEGLICHKEIT.NAME != 'xxx'
    AND UNVERTRAEGLICHKEIT.NAME != 'xxx');

/******************************************************************************/
/***                     Anzahl der Rezepte nach Kategorie                  ***/
/******************************************************************************/

SELECT KATEGORIE.NAME, COUNT(REZEPTKATEGORIE.REZEPTNR) FROM KATEGORIE INNER JOIN REZEPTKATEGORIE ON REZEPTKATEGORIE.KATEGORIENR = KATEGORIE.KATEGORIENR GROUP BY KATEGORIE.NAME ORDER BY COUNT(REZEPTKATEGORIE.REZEPTNR) DESC;
