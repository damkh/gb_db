-- SELECT 3 + 5;
-- UPDATE catalogs SET id = id + 10;
-- SELECT '3' + '5';
-- SELECT 8 / 0, 5 DIV 2, 5 / 2;
-- SELECT TRUE, FALSE, TRUE + FALSE + TRUE;
-- SELECt 2 < 1, NULL IS NULL, NULL <=> NULL, NULL <=> 3;

-- INSERT INTO catalogs VALUES(NULL, 'Network equipment');
-- INSERT INTO catalogs VALUES(NULL, NULL);
-- UPDATE catalogs SET name = 'RAM' WHERE id = 15;
-- SELECT * FROM catalogs WHERE name IS NULL;

-- SELECT TRUE AND FALSE, TRUE OR FALSE;
-- DROP TABLE tbl;
-- CREATE TABLE tbl (
-- 	x INT,
-- 	y INT,
-- 	sum INT AS (x + y) STORED
-- );
-- INSERT INTO tbl(x,y) VALUES(1,2);
-- SELECT * FROM tbl;

-- SELECT * FROM catalogs WHERE id > 12 AND id < 14;
-- SELECT 5 BETWEEN 3 AND 5;
-- SELECT * FROM catalogs WHERE id IN(11, 13, 15);
-- SELECT 2 IN (1,4,'52', NULL);
-- SELECT * FROM catalogs WHERE name LIKE '%';
-- INSERT INTO users(name, birthday_at) VALUES
-- 	('Геннадий', '1990-10-05'),
-- 	('Наталья', '1984-11-12'),
-- 	('Александр', '1985-05-20'),
-- 	('Сергей', '1984-02-14'),
-- 	('Иван', '1998-01-12'),
-- 	('Мария', '1992-08-29'),
-- 	('Павел', '1971-01-01');
-- SELECT * FROM users WHERE birthday_at LIKE '199%';

-- SELECT 'qwertyuiop' RLIKE '^qwer$', 'tyuqweriop' RLIKE '^qwer$', 'tyuqwer' RLIKE 'qwer$'; 
-- SELECT 'qwertyuiop' RLIKE '^qwer|iop$', 'tyuqweriop' RLIKE '^qwer$', 'tyuqwer' RLIKE 'qwer$';
-- SELECT 'a' RLIKE '[abc]', 'b' RLIKE '[abc]', 'c' RLIKE '[abc]';
-- SELECT '3' RLIKE '[[:digit:]]' ;
-- SELECT 's' RLIKE '[[:alpha:]]' ;
-- SELECT '324.3' RLIKE '[0-9]*\\.[0-9]{2}$';
-- SELECT TO_DAYS(NOW()) / 365.25;
-- SELECT NOW();
INSERT INTO users(name, birthday_at) VALUES('Vasy', '1971-01-01');
-- SELECT * FROM users;
-- SELECT LAST_INSERT_ID();
-- SELECT CONCAT(name, ' ', TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS name FROM users;
-- SELECT 
-- 	CONCAT(name, ' ', TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS name, 
-- 	IF(TIMESTAMPDIFF(YEAR, birthday_at, NOW()) > 18, 'soversh', 'nesoversh') AS soversh
-- FROM users;
-- SELECT INET_NTOA(256 * 256 * 256 * 256 - 1); 
-- SELECT COUNT(*) FROM users;
-- SELECT 
-- 	GROUP_CONCAT(name SEPARATOR '...'),
-- 	SUBSTRING(birthday_at, 3, 2) AS Year_in_decade 
-- FROM users GROUP BY Year_in_decade ORDER BY Year_in_decade; 
-- SELECT * FROM users;
-- SELECT COUNT(DISTINCT name) FROM users;

-- SELECT MIN(birthday_at) FROM users;
SELECT AVG(birthday_at) FROM users;






