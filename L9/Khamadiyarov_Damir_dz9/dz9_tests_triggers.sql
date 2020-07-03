DROP TRIGGER IF EXISTS name_desc_not_null_insert;
DROP TRIGGER IF EXISTS name_desc_not_null_update;
DELIMITER //


CREATE TRIGGER name_desc_not_null_insert BEFORE INSERT ON products
FOR EACH ROW 
BEGIN 
	IF (NEW.name IS NULL) AND (NEW.description IS NULL) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'products.name and products.description can not be NULL together';
  END IF;
END//

CREATE TRIGGER name_desc_not_null_update BEFORE UPDATE ON products
FOR EACH ROW 
BEGIN 
	IF (NEW.name IS NULL) AND (NEW.description IS NULL) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'products.name and products.description can not be NULL together';
  END IF;
END//