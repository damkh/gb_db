
SELECT 
	user_id
FROM profiles 
	WHERE user_id IN (
		SELECT 
			target_id
		FROM likes WHERE target_type_id IN (
			SELECT id FROM target_types WHERE name = 'users'
		)
	)
ORDER BY birthday DESC LIMIT 10;

SELECT 
			target_id
		FROM likes WHERE target_type_id IN (
			SELECT id FROM target_types WHERE name = 'users'
		) GROUP BY target_id;


SELECT user_id FROM profiles ORDER BY birthday DESC;
SELECT id FROM target_types WHERE name = 'users';
SELECT * FROM likes ;
SELECT * FROM target_types;

SELECT COUNT(*) FROM likes WHERE target_id IN (
	SELECT user_id FROM profiles WHERE user_id IN (
		SELECT target_id FROM likes WHERE target_type_id IN (
					SELECT id FROM target_types WHERE name = 'users'
				) GROUP BY target_id
			) ORDER BY birthday DESC LIMIT 10
	)
;

SELECT target_id, COUNT(*) AS c FROM likes WHERE target_type_id IN (
			SELECT id FROM target_types WHERE name = 'users'
		) GROUP BY target_id
	;


SELECT target_id, COUNT(*) FROM likes WHERE 
	target_type_id IN (
			SELECT id FROM target_types WHERE name = 'users'
		) GROUP BY target_id
	AND
	target_id IN (
		SELECT user_id FROM profiles ORDER BY birthday DESC
	)
;


SELECT user_id FROM profiles 
WHERE user_id IN 
	(SELECT target_id FROM likes WHERE target_type_id = (
			SELECT id FROM target_types WHERE name = 'users'
		) GROUP BY target_id
	)
ORDER BY birthday DESC;

SELECT * FROM likes;
SELECT * FROM target_types ;
INSERT INTO likes(user_id, target_id, target_type_id ) VALUES(67, 78, 2);

SELECT 
	(SELECT user_id FROM profiles WHERE user_id = likes.target_id ORDER BY birthday DESC LIMIT 10), 
	COUNT(*) 
FROM likes WHERE 
	target_type_id IN (
			SELECT id FROM target_types WHERE name = 'users'
		) GROUP BY target_id
		;
	
SELECT user_id, birthday FROM profiles ORDER BY birthday DESC;
SELECT user_id FROM profiles WHERE user_id = likes.target_id ORDER BY birthday DESC LIMIT 10;


SELECT 
	(SELECT user_id FROM profiles WHERE user_id = likes.target_id ORDER BY birthday DESC LIMIT 10), 
	COUNT(*) 
FROM likes WHERE 
	target_type_id = (
			SELECT id FROM target_types WHERE name = 'users'
		) GROUP BY target_id
		;
	
SELECT count(*) FROM likes WHERE user_id IN
(SELECT DISTINCT(user_id) FROM profiles ORDER BY birthday DESC LIMIT 10);


	

	



