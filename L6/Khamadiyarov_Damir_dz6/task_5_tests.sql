-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
-- (критерии активности необходимо определить самостоятельно).

-- Показатель по лайкам по каждому пользователю
SELECT 
	user_id, 
	(COUNT(*) * 0.25) /(SELECT COUNT(*) FROM likes WHERE TO_DAYS(NOW()) - TO_DAYS(created_at) < 31) 
		AS factor_likes
FROM likes 
	WHERE TO_DAYS(NOW()) - TO_DAYS(created_at) < 31 
		GROUP BY user_id 
			ORDER BY user_id;

SELECT COUNT(*) FROM likes WHERE TO_DAYS(NOW()) - TO_DAYS(created_at) < 31;

-- Показатель по медиа-файлам
SELECT 
	user_id,
	(COUNT(*) * 0.25) / (SELECT COUNT(*) FROM media WHERE TO_DAYS(NOW()) - TO_DAYS(updated_at) < 31)
		AS factor_media
FROM media
	WHERE TO_DAYS(NOW()) - TO_DAYS(updated_at) < 31
		GROUP BY user_id ;
	
SELECT COUNT(*) FROM media WHERE TO_DAYS(NOW()) - TO_DAYS(updated_at) < 31

SELECT * FROM media;

-- Показатель по дружественным связям
SELECT * FROM friendship ;


-- Сумма показателей
SELECT id FROM users ORDER BY id;

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


SELECT COALESCE(SUM(5));
SELECT SUM(1,2);
		
