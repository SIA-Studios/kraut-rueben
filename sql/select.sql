/******************************************************************************/
/***                              Rezept Kategorie                          ***/
/******************************************************************************/

SELECT REZEPT.titel, REZEPT.inhalt, KATEGORIE.name FROM REZEPT, REZEPTKATEGORIE, KATEGORIE WHERE REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr AND KATEGORIE.kategorienr = 000

/******************************************************************************/
/***                              Rezept Unverträglichkeit                  ***/
/******************************************************************************/

SELECT REZEPT.titel, REZEPT.inhalt FROM REZEPT, REZEPTZUTAT, ZUTATUNVERTRAEGLICHKEIT, UNVERTRAEGLICHKEIT 
    WHERE REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr != UNVERTRAEGLICHKEIT.unvernr 
    AND UNVERTRAEGLICHKEIT.unvernr = 000

/******************************************************************************/
/***                              Beides                                    ***/
/******************************************************************************/

SELECT REZEPT.titel, REZEPT.inhalt FROM REZEPT, REZEPTZUTAT, ZUTATUNVERTRAEGLICHKEIT, UNVERTRAEGLICHKEIT, REZEPTKATEGORIE, KATEGORIE
    WHERE (REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr
    AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr 
    AND ZUTATUNVERTRAEGLICHKEIT.unvernr != UNVERTRAEGLICHKEIT.unvernr 
    AND UNVERTRAEGLICHKEIT.unvernr = 000)
    AND (REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr 
    AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr AND KATEGORIE.kategorienr = 000)

/******************************************************************************/
/***                              Rezept Zutaten                            ***/
/******************************************************************************/

SELECT ZUTAT.bezeichnung, ZUTAT.einheit, ZUTAT.nettopreis, ZUTAT.kalorien, ZUTAT.kohlenhydrate, ZUTAT.protein
    FROM REZEPT, ZUTAT, REZEPTZUTAT 
    WHERE ZUTAT.zutatennr = REZEPTZUTAT.zutatennr 
    AND REZEPTZUTAT.rezeptnr = REZEPT.rezeptnr
    AND REZEPT.rezeptnr = 000