/******************************************************************************/
/***                        Rezepte nach Kategorie                          ***/
/******************************************************************************/

/* 1 Kategorie */
SELECT DISTINCT REZEPT.titel, REZEPT.inhalt, KATEGORIE.name FROM REZEPT, REZEPTKATEGORIE, KATEGORIE WHERE REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr AND KATEGORIE.kategorienr = 000

/* 2 Kategorien */
SELECT DISTINCT REZEPT.titel, REZEPT.inhalt, KATEGORIE.name FROM REZEPT, REZEPTKATEGORIE, KATEGORIE WHERE 
    REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr 
    AND (KATEGORIE.kategorienr = 000 OR KATEGORIE.kategorienr = 000) 

/* 3 Kategorien */
SELECT DISTINCT REZEPT.titel, REZEPT.inhalt, KATEGORIE.name FROM REZEPT, REZEPTKATEGORIE, KATEGORIE WHERE 
    REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr 
    AND (KATEGORIE.kategorienr = 000 OR KATEGORIE.kategorienr = 000 OR KATEGORIE.kategorienr = 000) 

/******************************************************************************/
/***                       Rezepte nach Unverträglichkeit                   ***/
/******************************************************************************/

/* 1 Unverträglichkeit */
SELECT DISTINCT REZEPT.titel, REZEPT.inhalt FROM REZEPT, REZEPTZUTAT, ZUTATUNVERTRAEGLICHKEIT, UNVERTRAEGLICHKEIT 
    WHERE REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr != UNVERTRAEGLICHKEIT.unvernr 
    AND UNVERTRAEGLICHKEIT.unvernr = 000

/* 2 Unverträglichkeiten */
SELECT DISTINCT REZEPT.titel, REZEPT.inhalt FROM REZEPT, REZEPTZUTAT, ZUTATUNVERTRAEGLICHKEIT, UNVERTRAEGLICHKEIT 
    WHERE REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr = UNVERTRAEGLICHKEIT.unvernr 
    AND (UNVERTRAEGLICHKEIT.unvernr != 000
    AND UNVERTRAEGLICHKEIT.unvernr != 000)

/* 3 Unverträglichkeiten */
SELECT DISTINCT REZEPT.titel, REZEPT.inhalt FROM REZEPT, REZEPTZUTAT, ZUTATUNVERTRAEGLICHKEIT, UNVERTRAEGLICHKEIT 
    WHERE REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr = UNVERTRAEGLICHKEIT.unvernr 
    AND (UNVERTRAEGLICHKEIT.unvernr != 000
    AND UNVERTRAEGLICHKEIT.unvernr != 000
    AND UNVERTRAEGLICHKEIT.unvernr != 000)  

/******************************************************************************/
/***                                Beides                                  ***/
/******************************************************************************/

/* 1 Unverträglichkeit, 1 Kategorie */
SELECT DISTINCT REZEPT.titel, REZEPT.inhalt FROM REZEPT, REZEPTZUTAT, ZUTATUNVERTRAEGLICHKEIT, UNVERTRAEGLICHKEIT, REZEPTKATEGORIE, KATEGORIE
    WHERE (REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr != UNVERTRAEGLICHKEIT.unvernr 
    AND UNVERTRAEGLICHKEIT.unvernr = 000)
    AND (REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr AND KATEGORIE.kategorienr = 000)

/* 2 Unverträglichkeit, 1 Kategorie */
SELECT DISTINCT REZEPT.titel, REZEPT.inhalt FROM REZEPT, REZEPTZUTAT, ZUTATUNVERTRAEGLICHKEIT, UNVERTRAEGLICHKEIT, REZEPTKATEGORIE, KATEGORIE
    WHERE (REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr = UNVERTRAEGLICHKEIT.unvernr 
    AND (UNVERTRAEGLICHKEIT.unvernr != 000
    AND UNVERTRAEGLICHKEIT.unvernr != 000))
    AND (REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr AND KATEGORIE.kategorienr = 000)

/* 1 Unverträglichkeit, 2 Kategorien */
SELECT DISTINCT REZEPT.titel, REZEPT.inhalt FROM REZEPT, REZEPTZUTAT, ZUTATUNVERTRAEGLICHKEIT, UNVERTRAEGLICHKEIT, REZEPTKATEGORIE, KATEGORIE
    WHERE (REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr != UNVERTRAEGLICHKEIT.unvernr 
    AND UNVERTRAEGLICHKEIT.unvernr = 000)
    AND (REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr 
    AND (KATEGORIE.kategorienr = 000 OR KATEGORIE.kategorienr = 000))

/* 2 Unverträglichkeit, 2 Kategorien */
SELECT DISTINCT REZEPT.titel, REZEPT.inhalt FROM REZEPT, REZEPTZUTAT, ZUTATUNVERTRAEGLICHKEIT, UNVERTRAEGLICHKEIT, REZEPTKATEGORIE, KATEGORIE
    WHERE (REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr = UNVERTRAEGLICHKEIT.unvernr 
    AND (UNVERTRAEGLICHKEIT.unvernr != 000
    AND UNVERTRAEGLICHKEIT.unvernr != 000))
    AND (REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr 
    AND (KATEGORIE.kategorienr = 000 OR KATEGORIE.kategorienr = 000))

/******************************************************************************/
/***                      Alle Zutaten nach Rezeptname                      ***/
/******************************************************************************/

SELECT ZUTAT.bezeichnung, ZUTAT.einheit, ZUTAT.nettopreis, ZUTAT.kalorien, ZUTAT.kohlenhydrate, ZUTAT.protein
    FROM REZEPT, ZUTAT, REZEPTZUTAT 
    WHERE ZUTAT.zutatennr = REZEPTZUTAT.zutatennr 
    AND REZEPTZUTAT.rezeptnr = REZEPT.rezeptnr
    AND REZEPT.rezeptnr IN
    (SELECT REZEPTNR FROM REZEPT WHERE TITEL = "Kaiserschmarrn")

/******************************************************************************/
/***      Durchschnittliche Nährwerte aller Bestellungen eines Kunden       ***/
/******************************************************************************/

SELECT KUNDE.KUNDENNR, KUNDE.VORNAME, KUNDE.NACHNAME, AVG(ZUTAT.KALORIEN) AS Kaloriendurchschnitt, AVG(ZUTAT.KOHLENHYDRATE) AS Kohlenhydratedurchschnitt, AVG(ZUTAT.PROTEIN) AS Proteindurchschnitt
    FROM ZUTAT
    LEFT JOIN BESTELLUNGZUTAT ON ZUTAT.ZUTATENNR = BESTELLUNGZUTAT.ZUTATENNR
    LEFT JOIN BESTELLUNG ON BESTELLUNGZUTAT.BESTELLNR = BESTELLUNG.BESTELLNR
    LEFT JOIN KUNDE ON BESTELLUNG.KUNDENNR = KUNDE.KUNDENNR
    WHERE KUNDE.KUNDENNR = 000

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
    ON R.REZEPTNR = rz.REZEPTNR
    JOIN ZUTAT AS Z
    ON Z.ZUTATENNR = RZ.ZUTATENNR
    GROUP BY R.REZEPTNR) KALORIEN
    WHERE Kaloriensumme < 10000

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
    AND REZEPTNR IN (SELECT REZEPTNR FROM REZEPTKATEGORIE WHERE KATEGORIENR IN (SELECT KATEGORIENR FROM KATEGORIE WHERE NAME = "Vegan"))

/******************************************************************************/
/***          Auswahl aller Zutaten eines Rezepts nach Rezeptname           ***/
/******************************************************************************/

SELECT DISTINCT REZEPT.TITEL, ZUTAT.BEZEICHNUNG, ZUTAT.EINHEIT, ZUTAT.NETTOPREIS, ZUTAT.KALORIEN, ZUTAT.KOHLENHYDRATE, ZUTAT.PROTEIN
    FROM ZUTAT
    INNER JOIN REZEPTZUTAT ON REZEPTZUTAT.ZUTATENNR = ZUTAT.ZUTATENNR
    INNER JOIN REZEPT ON REZEPT.REZEPTNR = REZEPTZUTAT.REZEPTNR
    WHERE REZEPT.TITEL = 'xxx'

/******************************************************************************/
/***        Auswahl aller Rezepte, die eine bestimme Zutat enthalten        ***/
/******************************************************************************/

SELECT * FROM REZEPT WHERE REZEPTNR IN 
   (SELECT REZEPTNR FROM REZEPTZUTAT WHERE ZUTATENNR IN 
   (SELECT ZUTATENNR FROM ZUTAT WHERE BEZEICHNUNG = "Zwiebel"))


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
    WHERE Preis < 3