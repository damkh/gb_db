-- Найти произведение чисел в столбце shop.products.catalog_id 
DROP PROCEDURE IF EXISTS mul_col;
delimiter //
CREATE PROCEDURE mul_col()
BEGIN
	SET @i = 1;
	SET @r = 1;

-- 	Создать временную таблицу tmp, в ней будет 2 стобца: id и num. В num скопировать даннные из shop.products.catalog_id
	DROP TEMPORARY TABLE IF EXISTS tmp; 
	CREATE TEMPORARY TABLE tmp (
		id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		num INT
	);
	INSERT INTO tmp(num) SELECT catalog_id FROM products;
-- 	SELECT * FROM tmp;
	SET @x = (SELECT COUNT(id) FROM tmp);
	
	REPEAT
		SET @r = @r * (SELECT num FROM tmp WHERE id = @i);
		SET @i = @i + 1;
	UNTIL @i > @x END REPEAT;
	
	SELECT @r;
	
	DROP TEMPORARY TABLE tmp;
END//
delimiter ;

CALL mul_col()

