(SELECT name FROM catalogs LIMIT 3)
UNION ALL
(SELECT name FROM rubrics LIMIT 2)
ORDER BY name LIMIT 3;

SELECT * FROM products WHERE price < (SELECT AVG(price) FROM products)

SELECT 
	name,
	price,
	(SELECT name FROM catalogs WHERE id = products.catalog_id ) AS cat_name 
FROM products 

SELECT
	name,
	price,
	catalog_id 
FROM products
	WHERE 
		catalog_id = (SELECT id FROM catalogs WHERE name = 'Мат.платы' )
		AND 
		price <  ALL (
			SELECT price FROM products WHERE
				catalog_id = (SELECT id FROM catalogs WHERE name = 'Процессоры')
		);

SELECT * FROM catalogs;
SELECT * FROM products ORDER BY catalog_id ; 

INSERT INTO catalogs(id, name) VALUES(NULL, 'Диски');

SELECT * FROM catalogs
	WHERE NOT EXISTS 
		(SELECT 1 FROM products WHERE catalogs.id = products.catalog_id );
	
SELECT * FROM products
	WHERE ROW(catalog_id, 5060) IN (SELECT id, price FROM catalogs);

SELECT id, products.price FROM catalogs;

SELECT AVG(min_price)
FROM
	(SELECT MIN(price) AS min_price 
	FROM products 
		GROUP BY catalog_id
	) AS sfdsf;

SELECT MIN(price) AS min_price 
	FROM products 
		GROUP BY catalog_id
		
SELECT * FROM tbl1 JOIN tbl2 ORDER BY tbl1.value ;

SELECT 
	p.name AS 'p-n', 
	p.price, 
	c.name AS 'c-n'
FROM 
	products AS p 
RIGHT JOIN 
	catalogs AS c
ON c.id = p.catalog_id ;

SELECT * FROM catalogs JOIN products ;

UPDATE
	catalogs 
JOIN
	products
ON 
	catalogs.id = products.catalog_id
SET price = 0.9 * price
	WHERE catalogs.name = 'Мат.платы'


SELECT * FROM products ORDER BY catalog_id ;
SELECT * FROM catalogs;

DELETE 
	products, catalogs
FROM 
	catalogs 
JOIN
	products 
ON 
	catalogs.id = products.catalog_id
WHERE catalogs.name = 'Мат.платы'

SHOW CREATE TABLE catalogs ;
DESC products;
DESC catalogs;

ALTER TABLE products 
	CHANGE catalog_id
	catalog_id BIGINT UNSIGNED DEFAULT NULL;

ALTER TABLE products 
	ADD CONSTRAINT products_catalog_id_fk
	FOREIGN KEY (catalog_id)
		REFERENCES catalogs(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE;

ALTER TABLE products DROP FOREIGN KEY products_catalog_id_fk;

SELECT * FROM products ;
SELECT * FROM orders;
SELECT * FROM orders_products;

INSERT INTO orders(user_id) VALUES(7);
INSERT INTO orders_products(order_id, product_id, total) VALUES(3, 2, 9);

SELECT DISTINCT(users.id), users.name 
	FROM
		users JOIN orders 
	ON users.id = orders.user_id 
	
SELECT * FROM products;
SELECT * FROM catalogs;

SELECT products.name, catalogs.name 
FROM products JOIN catalogs
ON products.catalog_id = catalogs.id
	ORDER BY products.name;


DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  city_from VARCHAR(255) COMMENT 'Откуда',
  city_to VARCHAR(255) COMMENT 'Куда'
) COMMENT = 'Полеты';

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(255) COMMENT 'English',
  name VARCHAR(255) COMMENT 'Русский'
) COMMENT = 'Города';

INSERT INTO flights(city_from, city_to) VALUES 
('moscow', 'omsk'),
('novgorod', 'kazan'),
('irkutsk', 'moscow'),
('omsk', 'irkutsk'),
('moscow', 'kazan')
;

SELECT * FROM flights ;

INSERT INTO cities(label, name) VALUES 
('moscow', 'Москва'),
('irkutsk', 'Иркутск'),
('novgorod', 'Новгород'),
('kazan', 'Казань'),
('omsk', 'Омск')
;

SELECT * FROM cities;

SELECT  , city_to 
	FROM flights JOIN cities 
WHERE city_from = 
;

SELECT 
	(SELECT name FROM cities WHERE cities.label = flights.city_from ) AS 'from',
	(SELECT name FROM cities WHERE cities.label = flights.city_to ) AS 'to'
FROM flights;


SELECT c1.name, c2.name
FROM 
	cities AS c1
JOIN 
	cities AS c2
JOIN
	flights AS f
ON c1.label = f.city_from AND c2.label = f.city_to ;



