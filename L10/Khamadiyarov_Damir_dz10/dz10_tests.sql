-- TASK 1

SHOW INDEX FROM users;
CREATE UNIQUE INDEX users_email_idx ON users(email);
DROP INDEX users_email_idx ON users;

SHOW INDEX FROM profiles;
SELECT * FROM users LIMIT 1;
SELECT * FROM profiles;


-- ALTER TABLE users ADD COLUMN password VARCHAR(255) NOT NULL COMMENT "Пароль";
-- ALTER TABLE profiles DROP COLUMN password;
UPDATE users SET password = MD5((1 + RAND() * 100)*(1 + RAND() * 100)); 
UPDATE users SET password = MD5('123456') WHERE users.email = 'skiles.william@example.org';

SELECT id, email, password 
 	FROM users
 		WHERE users.email = 'skiles.william@example.org' AND users.password = MD5('123456');
 			
CREATE UNIQUE INDEX users_email_password_idx ON users(email, password);

SELECT * FROM friendship_statuses;
SELECT * FROM friendship;

SELECT friendship.friend_id, friendship.status_id 
	FROM 
		friendship 
			JOIN
		friendship_statuses 
	ON friendship_statuses.id = friendship.status_id AND friendship_statuses.name = 'pending'
	ORDER BY friendship.friend_id;

CREATE INDEX friendship_friend_id_status_id ON friendship(friend_id, status_id);

SELECT * FROM messages;
SELECT * FROM messages 
	WHERE (from_user_id = 74 AND to_user_id = 59) OR (from_user_id = 59 AND to_user_id = 74)
	ORDER BY created_at DESC;


SELECT from_user_id + to_user_id - 59 AS chat_with  FROM messages
	WHERE (from_user_id = 59 OR to_user_id = 59);

CREATE INDEX messages_trollolo ON messages(from_user_id + to_user_id)

SELECT * FROM communities;
SELECT * FROM communities_users ;

SELECT * FROM media;
SELECT * FROM media_types;
SELECT * FROM media WHERE user_id = 64;
CREATE INDEX media_media_id_media_type_ip ON media(user_id,media_type_id);

SELECT user_id, target_id, target_type_id 
	FROM 
		likes
			WHERE target_id = 2 AND target_type_id = 4;
;

SHOW INDEX FROM ;
SELECT DISTINCT
    TABLE_NAME,
    INDEX_NAME
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'vk';

-- TASK 2

SELECT DISTINCT media_types.name, 
  SUM(media.size) OVER(PARTITION BY media.media_type_id) AS total_by_type,
  SUM(media.size) OVER() AS total,
  SUM(media.size) OVER(PARTITION BY media.media_type_id) / SUM(media.size) OVER() * 100 AS "%%"
    FROM media
      JOIN media_types
        ON media.media_type_id = media_types.id;

SELECT * FROM communities;
SELECT * FROM communities_users;
SELECT * FROM profiles;

SELECT * 
	FROM communities JOIN (communities_users JOIN profiles) 
		ON communities.id = communities_users.community_id 
			AND communities.id = 7 
			AND profiles.user_id = communities_users.user_id 
			AND profiles.user_id IN (64, 91, 104,184);

-- Список пользователей в каждой группе
SELECT communities.name, communities_users.community_id, profiles.user_id, profiles.birthday 
	FROM 
		communities LEFT JOIN (communities_users JOIN profiles)
			ON profiles.user_id = communities_users.user_id AND communities.id = communities_users.community_id 
		ORDER BY communities.name , profiles.birthday DESC;
	
SELECT * FROM profiles WHERE profiles.user_id IN (64, 91, 104,184);
SELECT * FROM communities_users;
INSERT INTO communities_users(community_id, user_id ) VALUES(19, 106);


SELECT
	DISTINCT communities.name,
	COUNT(communities_users.user_id) OVER () / (SELECT COUNT(*) FROM communities) AS avg_in_groups,
	FIRST_VALUE(communities_users.user_id) OVER (PARTITION BY communities.name ORDER BY profiles.birthday DESC) AS youngest,
	FIRST_VALUE(communities_users.user_id) OVER (PARTITION BY communities.name ORDER BY profiles.birthday) AS oldest,
	COUNT(communities_users.user_id) OVER(PARTITION BY communities.name) AS quantity_in_group,
	(SELECT COUNT(*) FROM users) AS quantity_all,
	100 * COUNT(communities_users.user_id) OVER (PARTITION BY communities.name) / (SELECT COUNT(*) FROM users) AS '%'
		FROM communities LEFT JOIN (profiles JOIN communities_users)
			ON communities.id = communities_users.community_id AND profiles.user_id = communities_users.user_id
				WINDOW communities_name_win AS (PARTITION BY communities.name)
			ORDER BY communities.name;

SELECT
-- 		*
		COUNT(DISTINCT communities.name)
-- 	COUNT(communities.name) OVER(PARTITION BY communities.id )
-- 	COUNT(communities_users.user_id) OVER (),
-- 	COUNT(communities.name) OVER (),
-- 	COUNT(communities_users.user_id) OVER () / COUNT(communities.id) OVER () AS avg_in_groups
-- 	FIRST_VALUE(communities_users.user_id) OVER (PARTITION BY communities.name ORDER BY profiles.birthday DESC) AS youngest,
-- 	FIRST_VALUE(communities_users.user_id) OVER (PARTITION BY communities.name ORDER BY profiles.birthday) AS oldest,
-- 	COUNT(communities_users.user_id) OVER(PARTITION BY communities.name) AS quantity_in_group,
-- 	COUNT(profiles.user_id) OVER() AS all_quantity
		FROM communities LEFT JOIN (profiles JOIN communities_users )
			ON communities.id = communities_users.community_id
-- 			AND profiles.user_id = communities_users.user_id
				WINDOW communities_name_win AS (PARTITION BY communities.name)
-- 			ORDER BY communities_users.user_id 
		;



