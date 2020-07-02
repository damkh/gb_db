DELIMITER //


DROP FUNCTION IF EXISTS hello//

CREATE FUNCTION hello (curr_time TIME)
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	DECLARE hello_phrase TEXT;
  IF (curr_time >= '06:00' AND curr_time <= '11:59:59.999999') THEN
    SET hello_phrase = 'Доброе утро';
  ELSEIF (curr_time >= '12:00' AND curr_time <= '17:59:59.999999') THEN
    SET hello_phrase = 'Добрый день';
  ELSEIF (curr_time >= '18:00' AND curr_time <= '23:59:59.999999') THEN
    SET hello_phrase = 'Добрый вечер';
  ELSEIF (curr_time >= '00:00' AND curr_time <= '05:59:59.999999') THEN
    SET hello_phrase = 'Доброй ночи';
	END IF;

    RETURN hello_phrase;
   
END//

SELECT hello('12:00')
