/******************************************************************************/
/***                   Kunden-Konto View                                    ***/
/******************************************************************************/


CREATE OR REPLACE VIEW KUNDEN_KONTO AS SELECT * FROM KUNDE WHERE KUNDENNR = 2001;

/******************************************************************************/
/***                   Kunden-Konto View für Lieferant                      ***/
/******************************************************************************/


CREATE OR REPLACE VIEW LIEFERUNG_KUNDE AS SELECT KUNDE.VORNAME, KUNDE.NACHNAME, KUNDE.STRASSE, KUNDE.HAUSNR, KUNDE.PLZ, KUNDE.ORT FROM KUNDE WHERE KUNDENNR = 2001;

/******************************************************************************/
/***                   Kunden-Konton View für Lieferant                      ***/
/******************************************************************************/


CREATE OR REPLACE VIEW LIEFERUNG_ALLE_KUNDEN AS SELECT KUNDE.VORNAME, KUNDE.NACHNAME, KUNDE.STRASSE, KUNDE.HAUSNR, KUNDE.PLZ, KUNDE.ORT FROM KUNDE;

