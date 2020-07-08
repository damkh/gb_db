-- TASK 11.1
CREATE TABLE logs (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  table_name VARCHAR(100) NOT NULL COMMENT "Имя таблицы",
  name VARCHAR(100) NOT NULL COMMENT "Содержимое поля name из таблиц users, catalogs и products",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки"
) COMMENT="Журнал действий пользователя" ENGINE=Archive; 

SELECT * FROM users;
SELECT * FROM catalogs;
SELECT * FROM products;
SELECT * FROM logs;
INSERT INTO users(name, birthday_at) VALUES('Татьяна', DATE('2000-01-01'));
INSERT INTO catalogs(name) VALUES('Кабели');
INSERT INTO products(name, description, price, catalog_id) VALUES('product_11_1', 'product_11_1 DESCRIPTION', 111, 17);

-- TASK 11.2
INSERT INTO users (name, birthday_at )
SELECT CONCAT('user_', k), DATE(CONCAT(2020 - FLOOR(1 + RAND() * 120),'-',FLOOR(1 + RAND() * 12),'-',FLOOR(1 + RAND() * 28)))
  FROM
	(
	SELECT a.N + b.N * 10 AS k
	FROM (select 0 as N union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) a,
	     (select 0 as N union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) b
	) t
	
SELECT DATE(CONCAT(2020 - FLOOR(1 + RAND() * 120),'-',FLOOR(1 + RAND() * 12),'-',FLOOR(1 + RAND() * 28)));

INSERT INTO users(name, birthday_at ) 
CONCAT('user_', k), DATE(CONCAT(2020 - FLOOR(1 + RAND() * 120),'-',FLOOR(1 + RAND() * 12),'-',FLOOR(1 + RAND() * 28)))
FROM
	(SELECT a1.n + 10 * a2.n + 100 * a3.n + 1000 * a4.n + 10000 * a5.n + 100000 * a6.n AS k
		FROM
			(SELECT 9 AS n
				UNION SELECT 8 
				UNION SELECT 7 
				UNION SELECT 6 
				UNION SELECT 5 
				UNION SELECT 4 
				UNION SELECT 3 
				UNION SELECT 2 
				UNION SELECT 1 
				UNION SELECT 0) AS a1
				JOIN
			(SELECT 0 AS n
				UNION SELECT 1 
				UNION SELECT 2 
				UNION SELECT 3 
				UNION SELECT 4 
				UNION SELECT 5 
				UNION SELECT 6 
				UNION SELECT 7 
				UNION SELECT 8 
				UNION SELECT 9) AS a2
				JOIN
			(SELECT 9 AS n
				UNION SELECT 8 
				UNION SELECT 7 
				UNION SELECT 6 
				UNION SELECT 5 
				UNION SELECT 4 
				UNION SELECT 3 
				UNION SELECT 2 
				UNION SELECT 1 
				UNION SELECT 0) AS a3
				JOIN
			(SELECT 0 AS n
				UNION SELECT 1 
				UNION SELECT 2 
				UNION SELECT 3 
				UNION SELECT 4 
				UNION SELECT 5 
				UNION SELECT 6 
				UNION SELECT 7 
				UNION SELECT 8 
				UNION SELECT 9) AS a4
				JOIN
			(SELECT 9 AS n
				UNION SELECT 8 
				UNION SELECT 7 
				UNION SELECT 6 
				UNION SELECT 5 
				UNION SELECT 4 
				UNION SELECT 3 
				UNION SELECT 2 
				UNION SELECT 1 
				UNION SELECT 0) AS a5
				JOIN
			(SELECT 0 AS n
				UNION SELECT 1 
				UNION SELECT 2 
				UNION SELECT 3 
				UNION SELECT 4 
				UNION SELECT 5 
				UNION SELECT 6 
				UNION SELECT 7 
				UNION SELECT 8 
				UNION SELECT 9) AS a6);
	
SELECT * 
	FROM 
		(SELECT 1 AS n UNION SELECT 0) AS a1 
		JOIN 
		(SELECT 0 AS n UNION SELECT 1) AS a2 
		JOIN 
		(SELECT 1 AS n UNION SELECT 0) AS a3 
		JOIN 
		(SELECT 0 AS n UNION SELECT 1) AS a4
		JOIN 
		(SELECT 1 AS n UNION SELECT 0) AS a5
		JOIN 
		(SELECT 0 AS n UNION SELECT 1) AS a6

SELECT a + b
	FROM 
		


	
	
	
	
	
	
	
	
	