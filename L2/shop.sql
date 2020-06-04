DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название раздела',
	UNIQUE unique_name(name(10))
) COMMENT 'Разделы интернет магазина';

INSERT IGNORE INTO catalogs VALUES
	(NULL, 'Процессоры AMD'),
	(NULL, 'Процессоры Intel'),
	(NULL, 'Мат.платы'),
	(NULL, 'Видеокарты');

-- DELETE FROM catalogs WHERE id > 1 LIMIT 1;
DELETE FROM catalogs;
TRUNCATE catalogs;

INSERT IGNORE INTO catalogs VALUES
	(NULL, 'Процессоры AMD'),
	(NULL, 'Мат.платы'),
	(NULL, 'Видеокарты');

UPDATE
	catalogs 
SET
	name = 'Процессоры (Intel)'
WHERE 
	name = 'Процессоры AMD';

DROP TABLE IF EXISTS cat;
CREATE TABLE cat (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название раздела',
	UNIQUE unique_name(name(10))
) COMMENT 'Разделы интернет магазина';

INSERT INTO
	cat
SELECT 
	*
FROM 
	catalogs;

SELECT * FROM cat;
 
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL,
	name VARCHAR(255) COMMENT 'Имя покупателя',
	birthday_at DATE COMMENT 'ДР покупателя',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата регистрации пользователя',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления данных пользователя'
) COMMENT 'Покупатели';

INSERT INTO users (id, name, birthday_at) VALUES (1, 'Dima', '2000-01-02');
-- SELECT * FROM users;

DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название товара',
	description TEXT COMMENT 'Описани товара', 
	price DECIMAL COMMENT 'Цена товара',
	catalog_id INT UNSIGNED,
	KEY index_of_catalog_id(catalog_id),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Товарные позиции';

-- CREATE INDEX index_of_catalog_id ON products (catalog_id);
-- DROP INDEX index_of_catalog_id ON products;


DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	user_id INT UNSIGNED,
	KEY index_of_user_id(user_id),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
	id SERIAL PRIMARY KEY,
	order_id INT UNSIGNED,
	product_id INT UNSIGNED,
	total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных позиций'
) COMMENT 'Состав заказа';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
	id SERIAL PRIMARY KEY,
	user_id INT UNSIGNED,
	product_id INT UNSIGNED,
	discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
	started_at DATETIME COMMENT 'Дата регистрации пользователя',
	finished_at DATETIME COMMENT 'Дата обновления данных пользователя',
	KEY index_of_user_id(user_id),
	KEY index_of_product_id(product_id),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания скидки',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления данных скидки'
) COMMENT 'Скидки';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название склада',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания склада',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления данных склада'
) COMMENT 'Запасы товара';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
	id SERIAL PRIMARY KEY,
	storehouse_id INT UNSIGNED,
	product_id INT UNSIGNED,
	value INT UNSIGNED COMMENT 'Запас товаран а складе',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата появления записи',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления записи'
) COMMENT 'Запасы товара';





