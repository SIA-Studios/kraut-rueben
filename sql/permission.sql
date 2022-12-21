
/******************************************************************************/
/***              Lieferant Rolle (Rechte auf Kunden-View)                  ***/
/******************************************************************************/

CREATE ROLE lieferant;
GRANT SELECT ON krautundrueben.LIEFERUNG_ALLE_KUNDEN TO lieferant;

/******************************************************************************/
/***              Praktikanten Rolle (Select Zugriff)                       ***/
/******************************************************************************/

CREATE ROLE praktikant;
GRANT SELECT ON krautundrueben.* TO praktikant;

/******************************************************************************/
/***         Mitarbeiter Rolle (Select, Update & Insert Zugriff)            ***/
/******************************************************************************/

CREATE ROLE mitarbeiter;
GRANT SELECT ON krautundrueben.* TO mitarbeiter;
GRANT UPDATE ON krautundrueben.* TO mitarbeiter;
GRANT INSERT ON krautundrueben.* TO mitarbeiter;

/******************************************************************************/
/***                    Administrator Rolle (Vollzugriff)                   ***/
/******************************************************************************/

CREATE ROLE administrator;
GRANT ALL PRIVILEGES ON krautundrueben.* TO administrator;

/******************************************************************************/
/***                            Benutzer Erstellung                         ***/
/******************************************************************************/

CREATE USER 'tom'@'%' IDENTIFIED BY 'password';
GRANT lieferant TO 'tom'@'%';

CREATE USER 'till'@'%' IDENTIFIED BY 'password';
GRANT praktikant TO 'till'@'%';

CREATE USER 'tim'@'%' IDENTIFIED BY 'password';
GRANT mitarbeiter TO 'tim'@'%';

CREATE USER 'finn'@'%' IDENTIFIED BY 'password';
GRANT administrator TO 'finn'@'%';