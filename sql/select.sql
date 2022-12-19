/******************************************************************************/
/***                              Rezept Kategorie                          ***/
/******************************************************************************/

/* 1 Kategorie */
SELECT DISTINCT REZEPT.titel, REZEPT.inhalt, KATEGORIE.name FROM REZEPT, REZEPTKATEGORIE, KATEGORIE WHERE REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr AND KATEGORIE.kategorienr = 000

/* 2 Kategorien */
SELECT DISTINCT REZEPT.titel, REZEPT.inhalt, KATEGORIE.name FROM REZEPT, REZEPTKATEGORIE, KATEGORIE WHERE 
    (REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr AND KATEGORIE.kategorienr = 000)
    OR (REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr AND KATEGORIE.kategorienr = 000)

/* 3 Kategorien */
SELECT DISTINCT REZEPT.titel, REZEPT.inhalt, KATEGORIE.name FROM REZEPT, REZEPTKATEGORIE, KATEGORIE WHERE 
    (REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr AND KATEGORIE.kategorienr = 000)
    OR (REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr AND KATEGORIE.kategorienr = 000)
    OR (REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr AND KATEGORIE.kategorienr = 000)

/******************************************************************************/
/***                              Rezept Unverträglichkeit                  ***/
/******************************************************************************/

/* 1 Unverträglichkeit */
SELECT DISTINCT REZEPT.titel, REZEPT.inhalt FROM REZEPT, REZEPTZUTAT, ZUTATUNVERTRAEGLICHKEIT, UNVERTRAEGLICHKEIT 
    WHERE REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr != UNVERTRAEGLICHKEIT.unvernr 
    AND UNVERTRAEGLICHKEIT.unvernr = 000

/* 2 Unverträglichkeiten */
SELECT DISTINCT REZEPT.titel, REZEPT.inhalt FROM REZEPT, REZEPTZUTAT, ZUTATUNVERTRAEGLICHKEIT, UNVERTRAEGLICHKEIT 
    WHERE (REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr != UNVERTRAEGLICHKEIT.unvernr 
    AND UNVERTRAEGLICHKEIT.unvernr = 000)
    AND (REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr != UNVERTRAEGLICHKEIT.unvernr 
    AND UNVERTRAEGLICHKEIT.unvernr = 000)

/* 3 Unverträglichkeiten */
SELECT DISTINCT REZEPT.titel, REZEPT.inhalt FROM REZEPT, REZEPTZUTAT, ZUTATUNVERTRAEGLICHKEIT, UNVERTRAEGLICHKEIT 
    WHERE (REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr != UNVERTRAEGLICHKEIT.unvernr 
    AND UNVERTRAEGLICHKEIT.unvernr = 000)
    AND (REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr != UNVERTRAEGLICHKEIT.unvernr 
    AND UNVERTRAEGLICHKEIT.unvernr = 000)   
    AND (REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr != UNVERTRAEGLICHKEIT.unvernr 
    AND UNVERTRAEGLICHKEIT.unvernr = 000)   

/******************************************************************************/
/***                              Beides                                    ***/
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
    WHERE ((REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr != UNVERTRAEGLICHKEIT.unvernr 
    AND UNVERTRAEGLICHKEIT.unvernr = 000)
    AND (REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr != UNVERTRAEGLICHKEIT.unvernr 
    AND UNVERTRAEGLICHKEIT.unvernr = 000))
    AND (REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr AND KATEGORIE.kategorienr = 000)

/* 1 Unverträglichkeit, 2 Kategorien */
SELECT DISTINCT REZEPT.titel, REZEPT.inhalt FROM REZEPT, REZEPTZUTAT, ZUTATUNVERTRAEGLICHKEIT, UNVERTRAEGLICHKEIT, REZEPTKATEGORIE, KATEGORIE
    WHERE (REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr != UNVERTRAEGLICHKEIT.unvernr 
    AND UNVERTRAEGLICHKEIT.unvernr = 000)
    AND ((REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr AND KATEGORIE.kategorienr = 000)
    OR (REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr AND KATEGORIE.kategorienr = 000))

/* 2 Unverträglichkeit, 2 Kategorien */
SELECT DISTINCT REZEPT.titel, REZEPT.inhalt FROM REZEPT, REZEPTZUTAT, ZUTATUNVERTRAEGLICHKEIT, UNVERTRAEGLICHKEIT, REZEPTKATEGORIE, KATEGORIE
    WHERE ((REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr != UNVERTRAEGLICHKEIT.unvernr 
    AND UNVERTRAEGLICHKEIT.unvernr = 000)
    AND (REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr != UNVERTRAEGLICHKEIT.unvernr 
    AND UNVERTRAEGLICHKEIT.unvernr = 000))
    AND ((REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr AND KATEGORIE.kategorienr = 000)
    OR (REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr AND KATEGORIE.kategorienr = 000))

/******************************************************************************/
/***                              Rezept Zutaten                            ***/
/******************************************************************************/

SELECT ZUTAT.bezeichnung, ZUTAT.einheit, ZUTAT.nettopreis, ZUTAT.kalorien, ZUTAT.kohlenhydrate, ZUTAT.protein
    FROM REZEPT, ZUTAT, REZEPTZUTAT 
    WHERE ZUTAT.zutatennr = REZEPTZUTAT.zutatennr 
    AND REZEPTZUTAT.rezeptnr = REZEPT.rezeptnr
    AND REZEPT.rezeptnr = 000