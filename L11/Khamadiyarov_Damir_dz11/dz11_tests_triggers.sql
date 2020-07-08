DROP TRIGGER IF EXISTS users_insert_logs;
DROP TRIGGER IF EXISTS products_insert_logs;
DROP TRIGGER IF EXISTS catalogs_insert_logs;
DELIMITER //


CREATE TRIGGER users_insert_logs AFTER INSERT ON users
FOR EACH ROW 
BEGIN 
	INSERT INTO logs(table_name, name) VALUES('users', NEW.name);
END//

CREATE TRIGGER products_insert_logs AFTER INSERT ON products
FOR EACH ROW 
BEGIN 
	INSERT INTO logs(table_name, name) VALUES('products', NEW.name);
END//

CREATE TRIGGER catalogs_insert_logs AFTER INSERT ON catalogs
FOR EACH ROW 
BEGIN 
	INSERT INTO logs(table_name, name) VALUES('catalogs', NEW.name);
END//

