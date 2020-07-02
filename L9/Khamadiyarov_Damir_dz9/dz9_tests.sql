-- TASK 1.1
INSERT INTO sample.users VALUES(5, 'sss','2020-06-03','2020-06-02 00:00:00.0','2020-06-01 00:00:00.0');
SELECT * FROM shop.users WHERE id = 1;
INSERT INTO sample.users 
	SELECT shop.users.id, shop.users.name, shop.users.birthday_at, shop.users.created_at, shop.users.updated_at FROM shop.users WHERE id = 1
;
DESCRIBE sample.users;
DESCRIBE shop.users;

USE sample;
DELETE FROM sample.users WHERE id = 1;

SELECT * FROM shop.users WHERE id = 1;
SELECT * FROM sample.users;

START TRANSACTION;
INSERT INTO sample.users 
	SELECT 
		id, 
		name, 
		birthday_at, 
		created_at, 
		updated_at 
	FROM shop.users WHERE id = 1
;

INSERT INTO sample.users 
SELECT 
id, 
name, 
birthday_at, 
created_at, 
updated_at 
FROM shop.users WHERE id = 1;


DELETE FROM shop.users WHERE id = 1;
COMMIT;

-- TASK 1.2

CREATE VIEW prod_cat AS
SELECT products.name AS prod_name, catalogs.name AS catalog_name
FROM 
products JOIN catalogs 
ON products.catalog_id = catalogs.id;

SELECT * FROM prod_cat;
DROP VIEW prod_cat ;

-- TASK 1.3
SELECT * FROM products;

UPDATE shop.products
	SET created_at=NULL
	WHERE id=1;
UPDATE shop.products
	SET created_at='2018-08-01 08:11:29.0'
	WHERE id=2;
UPDATE shop.products
	SET created_at=NULL
	WHERE id=4;
UPDATE shop.products
	SET created_at='2018-08-04 08:12:48.0'
	WHERE id=5;
UPDATE shop.products
	SET created_at='2018-08-16 08:13:01.0'
	WHERE id=6;
UPDATE shop.products
	SET created_at='2018-08-17 08:13:17.0'
	WHERE id=7;
UPDATE shop.products
	SET created_at=NULL
	WHERE id=8;

CREATE OR REPLACE VIEW products_08 AS 
	SELECT * FROM products 
		WHERE created_at < '2018-09-01 00:00:00.0' AND created_at > '2018-07-31-23:59:59.99' OR created_at IS NULL;

	
SELECT * FROM products_08;

DROP TABLE products_08 ;

SELECT * FROM products_08;

SELECT created_at, IF(created_at IS NULL, 0, 1) AS date_exists FROM products_08;

DROP VIEW products_08;

-- TASK 1.4

USE vk;
CREATE OR REPLACE VIEW users_task_1_4 AS 
SELECT * FROM users;

SET @date_5 = (SELECT created_at FROM
(SELECT created_at FROM users_task_1_4
ORDER BY created_at 
DESC LIMIT 5
) AS date_5th
ORDER BY created_at LIMIT 1);

DELETE FROM users_task_1_4 WHERE created_at < 
	(SELECT MIN(created_at ) FROM (SELECT created_at FROM users_task_1_4 ORDER BY created_at DESC LIMIT 3) AS created_at_dates);

SELECT @date_5

SELECT * FROM users_task_1_4 WHERE created_at < (SELECT * FROM users_task_1_4_date_5);

SELECT * FROM  users_task_1_4;


-- TASK 3.1
DROP FUNCTION IF EXISTS hello;
-- CREATE FUNCTION hello (curr_time TIME)
DELIMITER //
CREATE FUNCTION hello ()
RETURNS TEXT DETERMINISTIC
BEGIN
	RETURN VERSION(); 
END//

SELECT VERSION();

DELIMITER //

CREATE FUNCTION get_version ()
RETURNS TEXT DETERMINISTIC
BEGIN
  RETURN VERSION();
END//
-- 	DECLARE hello_phrase TEXT;
-- 
-- 
--   IF (curr_time >= '06:00' AND curr_time <= '11:59:59.999999') THEN
--     SET hello_phrase = 'Доброе утро';
--   ELSEIF (curr_time >= '12:00' AND curr_time <= '17:59:59.999999') THEN
--     SET hello_phrase = 'Добрый день';
--   ELSEIF curr_time >= '18:00' AND curr_time <= '23:59:59.999999' THEN
--     SET hello_phrase = 'Добрый вечер';
--   ELSEIF curr_time >= '00:00' AND curr_time <= '05:59:59.999999' THEN
--     SET hello_phrase = 'Доброй ночи';

--     RETURN hello_phrase;
-- END

-- CALL hello(CURRENT_TIME())

-- SELECT IF(TIME_FORMAT('00:00', '%H:%i') > '23:59', 1, 0);

-- TASK 3.2
SELECT * FROM products;

-- CREATE TRIGGER name_desc_not_null BEFORE INSERT on products
-- FOR EACH ROW 
-- BEGIN 
-- 	IF (NEW.name IS NULL) AND (NEW.description IS NULL) THEN 
-- 		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'products.name and products.description can not be NULL together';
--   END IF;
-- END;

INSERT INTO products (id, name, description , price, catalog_id ) VALUES(NULL, 'product 9_3_1', NULL, 20, 3);
INSERT INTO products (id, name, description , price, catalog_id ) VALUES(NULL, NULL, 'product 9_3_0 DESCRIPTION', 21, 3);
UPDATE products SET name = NULL WHERE id = 16;
UPDATE products SET description = NULL WHERE id = 17;




