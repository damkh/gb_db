-- ЭТО ТЕСТОВЫЙ ФАЙЛ, ЕГО ПРОВЕРЯТЬ НЕ НУЖНО
-- 1. Определить кто больше поставил лайков (всего) - мужчины или женщины?
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

SELECT
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender,
	COUNT(*) AS total
    FROM likes
    GROUP BY gender
    ORDER BY total DESC
    LIMIT 1;
   

SELECT COUNT(*) FROM likes GROUP BY target_id ;

SELECT profiles.gender, COUNT(*) AS likes_num FROM 
	profiles JOIN likes
		ON likes.user_id = profiles.user_id
	GROUP BY profiles.gender
		ORDER BY likes_num DESC
		LIMIT 1;

SELECT * FROM likes;
SELECT * FROM users;
   
--2. Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей).
--    Смог только частично сделать, до конца не осилил:
SELECT 
(SELECT user_id FROM profiles WHERE user_id = likes.target_id ORDER BY birthday DESC LIMIT 10), 
COUNT(*) 
  FROM likes WHERE 
target_type_id = (
		SELECT id FROM target_types WHERE name = 'users'
) GROUP BY target_id
;

SELECT COUNT(*) FROM likes WHERE target_id IN
 (SELECT * FROM 
  (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10) AS s
 );

SELECT * FROM target_types ;

SELECT user_id FROM profiles 
				ORDER BY birthday DESC 
					LIMIT 10;


SELECT SUM(likes_all) AS likes_sum FROM
	(SELECT COUNT(*) AS likes_all
		FROM 
				profiles 
			JOIN 
				likes
			ON target_id = profiles.user_id
				AND likes.target_type_id = 2
				AND profiles.user_id IN 
					(
						SELECT * FROM 
						(SELECT profiles.user_id FROM profiles 
						ORDER BY birthday DESC 
							LIMIT 10) AS young_10_users
					)
			GROUP BY profiles.user_id) AS likes_per_user;

SELECT SUM(likes_all) AS likes_sum FROM
	(SELECT COUNT(*) AS likes_all
		FROM 
				likes
			JOIN
				(SELECT profiles.user_id FROM profiles 
						ORDER BY birthday DESC 
							LIMIT 10) AS young_10_users
			ON target_id = young_10_users.user_id
				AND likes.target_type_id = 2
			GROUP BY profiles.user_id) AS likes_per_user;
		
SELECT SUM(likes_all) AS likes_sum FROM
	(SELECT target_id, COUNT(*) AS likes_all
		FROM 
				likes
			JOIN
				(SELECT profiles.user_id FROM profiles 
						ORDER BY birthday DESC 
							LIMIT 10) AS young_10_users
			ON target_id = young_10_users.user_id
				AND likes.target_type_id = 2
		GROUP BY young_10_users.user_id) AS likes_per_user;
	
SELECT SUM(likes_all) AS likes_sum FROM 
	(SELECT young_10_users.user_id, IF (likes.target_id IS NULL, COUNT(*) - 1, COUNT(*)) AS likes_all
	FROM 
		(SELECT profiles.user_id FROM profiles 
		ORDER BY birthday DESC 
		LIMIT 10) AS young_10_users
	LEFT JOIN
		likes
	ON target_id = young_10_users.user_id
			AND likes.target_type_id = 2
	GROUP BY young_10_users.user_id) AS likes_per_user;



-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
-- (критерии активности необходимо определить самостоятельно).
--     Критерий активности: активность считается за последние 30 дней. Если за последние 30 дней не было никаких действий пользователя - значит активность равна 0. На активность влияют следующие факторы:
--         1) Количество лайков, поставленных за последние 30 дней. Вес данного фактора определим как w_likes = 0.25
--         2) Количество медиа-файлов, выложенных за последний 30 дней. Вес данного фактора определим как w_media = 0.25
--         3) Количество дружественных связей, заведенных за последние 30 дней. Вес данного фактора определим как w_friends = 0.25
--         4) Количество групп, в которые вступил пользователь за последние 30 дней. Вес данного фактора определим как w_communities = 0.25
--         
--     1) Возьмем количество лайков, поставленных пользователем, за последние 30 дней, за user_likes_num.
--     Возьмем общее количество лайков, поставленных всеми пользователями за 30 дней, за all_users_likes_num. Показатель активности по лайкам будет вычисляться выражением (user_likes_num/all_users_likes_num)*w_likes
--     2) По аналогии с пунктом 1, Показатель активности по медиа будет вычисляться выражением (user_media_num/all_users_media_num)*w_media
--     3) Показатель активности по дружбе будет вычисляться выражением (user_friendship_num/all_friendship_num)*w_friends
--     4) Показатель активности по группам будет вычисляться выражением (user_join_communities_num/all_join_communities_num)*w_communities
--     
--     Общая активность будет вычисляться как сумма всех показателей
SELECT 
	id, 
	(IFNULL((SELECT  
		(COUNT(*) * 0.25) /(SELECT COUNT(*) FROM likes WHERE TO_DAYS(NOW()) - TO_DAYS(created_at) < 31) 
	FROM likes 
		WHERE (TO_DAYS(NOW()) - TO_DAYS(created_at) < 31) AND (user_id = users.id)
			GROUP BY user_id 
	),0) +
	(IFNULL((SELECT 
	(COUNT(*) * 0.25) / (SELECT COUNT(*) FROM media WHERE TO_DAYS(NOW()) - TO_DAYS(updated_at) < 31)
		AS factor_likes
	FROM media
		WHERE (TO_DAYS(NOW()) - TO_DAYS(updated_at) < 31) AND (user_id = users.id)
			GROUP BY user_id
	),0))) AS media_likes_factor
	FROM users ORDER BY media_likes_factor LIMIT 10;

-- Вариант преподавателя
SELECT 
	id,
  CONCAT(first_name, ' ', last_name) AS user, 
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) + 
	(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) + 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) AS overall_activity 
	  FROM users
	  ORDER BY overall_activity
	 LIMIT 10;
	
	 
SELECT 
  CONCAT(first_name, ' ', last_name) AS user, 
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) AS overall_activity 
	  FROM users
	  ORDER BY user;
	 
	 
SELECT 
	CONCAT(first_name, ' ', last_name) AS full_user_name, 
				IF (full_user_name IS NULL, COUNT(*) - 1, COUNT(*)) AS overall_activity 
		FROM users LEFT JOIN likes 
			ON likes.user_id = users.id
		GROUP BY full_user_name
		ORDER BY full_user_name;
	
SELECT 
	CONCAT(first_name, ' ', last_name) AS full_user_name,
	users.first_name ,
	IF (likes.user_id IS NULL, COUNT(*) - 1, COUNT(*)) AS overall_activity 
		FROM users LEFT JOIN likes 
			ON likes.user_id = users.id
		GROUP BY users.id
		ORDER BY full_user_name;
	
SELECT 
	users.id,likes.user_id,media.user_id,messages.from_user_id,
	CONCAT(users.first_name, ' ', users.last_name) AS full_user_name,
	IF (likes.user_id IS NULL, COUNT(*) - 1, COUNT(*)) AS likes_activity, 
	IF (media.user_id IS NULL, COUNT(*) - 1, COUNT(*)) AS media_activity,
	IF (messages.from_user_id IS NULL, COUNT(*) - 1, COUNT(*)) AS messages_activity
		FROM users LEFT JOIN (likes JOIN media JOIN messages)
			ON likes.user_id = users.id AND media.user_id = users.id AND messages.from_user_id = users.id
		GROUP BY users.id
		ORDER BY full_user_name;

SELECT CONCAT(first_name, ' ', last_name) AS full_user_name FROM users ORDER BY full_user_name;

DESCRIBE messages;

SELECT 
	users.id,
	CONCAT(users.first_name, ' ', users.last_name) AS full_user_name
	FROM 
	(SELECT IF (likes.user_id IS NULL, COUNT(*) - 1, COUNT(*)) AS likes_activity
	FROM 
		users LEFT JOIN likes
			ON likes.user_id = users.id
	GROUP BY users.id),
	(SELECT IF (media.user_id IS NULL, COUNT(*) - 1, COUNT(*)) AS media_activity
	FROM 
		users LEFT JOIN media 
			ON media.user_id = users.id
	GROUP BY users.id)
	FROM users	
	ORDER BY users.id;

SELECT * FROM likes WHERE user_id = 2;

SELECT 
	likes_user_id AS user_id,
	(SELECT CONCAT(users.first_name, ' ', users.last_name) FROM users WHERE users.id = user_id) AS username,
	likes_activity + media_activity + messages_activity AS overall_activity 
		FROM
			(SELECT users.id AS likes_user_id, IF (likes.user_id IS NULL, COUNT(*) - 1, COUNT(*)) AS likes_activity
				FROM 
					users LEFT JOIN likes
						ON likes.user_id = users.id
				GROUP BY users.id) AS likes_num
		JOIN 
			(SELECT users.id as media_user_id, IF (media.user_id IS NULL, COUNT(*) - 1, COUNT(*)) AS media_activity
			FROM 
				users LEFT JOIN media 
					ON media.user_id = users.id
			GROUP BY media_user_id) AS media_num
		JOIN
			(SELECT users.id as messages_user_id, IF (messages.from_user_id IS NULL, COUNT(*) - 1, COUNT(*)) AS messages_activity
			FROM 
				users LEFT JOIN messages 
					ON messages.from_user_id = users.id
			GROUP BY messages_user_id) AS messages_num
			ON messages_user_id = media_user_id AND likes_user_id = media_user_id
			ORDER BY overall_activity
			LIMIT 10;
		
SELECT 
likes_user_id AS user_id,
(SELECT CONCAT(users.first_name, ' ', users.last_name) FROM users WHERE users.id = user_id) AS username,
likes_activity + media_activity + messages_activity AS overall_activity 
FROM
(SELECT users.id AS likes_user_id, IF (likes.user_id IS NULL, COUNT(*) - 1, COUNT(*)) AS likes_activity
FROM 
users LEFT JOIN likes
ON likes.user_id = users.id
GROUP BY users.id) AS likes_num
JOIN 
(SELECT users.id as media_user_id, IF (media.user_id IS NULL, COUNT(*) - 1, COUNT(*)) AS media_activity
FROM 
users LEFT JOIN media 
ON media.user_id = users.id
GROUP BY media_user_id) AS media_num
JOIN
(SELECT users.id as messages_user_id, IF (messages.from_user_id IS NULL, COUNT(*) - 1, COUNT(*)) AS messages_activity
FROM 
users LEFT JOIN messages 
ON messages.from_user_id = users.id
GROUP BY messages_user_id) AS messages_num
ON messages_user_id = media_user_id AND likes_user_id = media_user_id
ORDER BY overall_activity
LIMIT 10;


SELECT 
id,
CONCAT(first_name, ' ', last_name) AS user, 
(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) + 
(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) + 
(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) AS overall_activity 
FROM users
ORDER BY overall_activity
LIMIT 10;

	



	
