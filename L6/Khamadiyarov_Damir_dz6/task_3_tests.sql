SELECT * FROM likes;
SELECT * FROM users;
SELECT * FROM profiles;

-- UPDATE profiles SET gender = 'm' WHERE photo_id < 25 OR photo_id > 75;

SELECT
	user_id, 'likes'
FROM profiles
		WHERE gender = 'm';
	
SELECT 
	user_id,
	(SELECT target_type_id FROM likes WHERE user_id = 69)
FROM profiles
	WHERE gender = 'm';

SELECT 
	user_id, 
	COUNT(*)
FROM likes
GROUP BY user_id ;


SELECT 
	(SELECT first_name FROM users WHERE id = profiles.user_id), 
	gender 
FROM profiles 
	WHERE gender = 'f';
	
SELECT 
	(SELECT user_id FROM likes WHERE user_id = profiles.user_id GROUP BY user_id ), 
	gender
FROM profiles 
	WHERE gender = 'f';

SELECT 
	(SELECT user_id FROM profiles WHERE gender = 'm' GROUP BY user_id )
FROM likes;

SELECT user_id FROM likes GROUP BY user_id ;

SELECT user_id FROM profiles p WHERE gender = 'f';

SELECT 
	IF (
		(SELECT COUNT(*) FROM likes
			WHERE user_id IN (SELECT user_id FROM profiles WHERE gender = 'f')
			) >
		(SELECT COUNT(*) FROM likes 
			WHERE user_id IN (SELECT user_id FROM profiles WHERE gender = 'm')),
		'f', 'm'
		) AS likes_champion
;
--  TASK 3 END -------




