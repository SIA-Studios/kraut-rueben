/******************************************************************************/
/***                            Rezepte Procedures                          ***/
/******************************************************************************/

DELIMITER // 

CREATE PROCEDURE get_all_recipes () 
BEGIN
SELECT * FROM REZEPT;
END;

// DELIMITER ;

DELIMITER // 

CREATE PROCEDURE get_recipe_by_id (recipe_id INTEGER) 
BEGIN
SELECT * FROM REZEPT WHERE REZEPTNR = recipe_id;
END;

// DELIMITER ;

DELIMITER // 

CREATE PROCEDURE get_recipe_by_title (recipe_title VARCHAR(250)) 
BEGIN
SELECT * FROM REZEPT WHERE TITEL = recipe_title;
END;

// DELIMITER ;

/******************************************************************************/
/***                            Kunden Procedures                          ***/
/******************************************************************************/

DELIMITER // 

CREATE PROCEDURE get_customer_information (customer_id INTEGER) 
BEGIN
SELECT * FROM KUNDE WHERE KUNDENR = customer_id;
END;

// DELIMITER ;

DELIMITER // 

CREATE PROCEDURE delete_all_customer_information (customer_id INTEGER) 
BEGIN
UPDATE KUNDE SET VORNAME = null, NACHNAME = null, GEBURTSDATUM = null, STRASSE = null, HAUSNR = null, PLZ = null, ORT = null, TELEFON = null, EMAIL = null WHERE KUNDENNR = customer_id;
END;

// DELIMITER ;