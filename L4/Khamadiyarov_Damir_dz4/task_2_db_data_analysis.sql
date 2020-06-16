USE vk;


-- АНАЛИЗ И ДОРАБОТКА ДАННЫХ

SELECT * FROM users;
UPDATE users SET user_status = 2 WHERE id IN (2, 5, 7, 45, 67, 76, 81, 82, 83, 99, 132, 154, 166, 171, 172, 190);
UPDATE users SET user_status = 3 WHERE id IN (3, 6, 8, 46, 68, 77, 85, 86, 87, 95, 96, 97, 133, 155, 167, 174, 175, 191);
UPDATE users SET updated_at = CURRENT_TIMESTAMP WHERE created_at > updated_at ;

SELECT FLOOR(RAND() * 100 + 1)
UPDATE profiles SET photo_id = FLOOR(RAND() * 100 + 1);

CREATE TEMPORARY TABLE genders (name CHAR(1));
INSERT INTO genders VALUES ('m'), ('f'), ('t');
UPDATE profiles SET gender = (SELECT name FROM genders ORDER BY RAND() LIMIT 1 );
UPDATE profiles SET is_private = TRUE WHERE photo_id > FLOOR(RAND() * 100 + 1);
UPDATE messages SET media_id = FLOOR(RAND() * 100 + 1);
CREATE TEMPORARY TABLE extensions (name VARCHAR(50));
INSERT INTO extensions VALUES ('jpg'), ('png'), ('avi'), ('mp4'), ('mp3');
UPDATE media SET filename = CONCAT(
	'http://fileshare.lol/vk/',
	filename,
	'.',
	(SELECT name FROM extensions ORDER BY RAND() LIMIT 1 )
);
UPDATE media SET size =  FLOOR(RAND() * 1000000 + 10000) WHERE size < 1000;
UPDATE media SET metadata = CONCAT(
	'{"owner":"',
	(SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
	'"}'
);

ALTER TABLE media MODIFY COLUMN metadata JSON;

TRUNCATE media_types ;
INSERT INTO media_types (name) VALUES ('audio'), ('video'), ('photo'), ('emodzi');
UPDATE media SET media_type_id =  FLOOR(RAND() * 4 + 1);
UPDATE friendship SET declined_at = (SELECT updated_at FROM users ORDER BY RAND() LIMIT 1);
UPDATE friendship SET friend_id = friend_id + 1 WHERE user_id = friend_id ;
DELETE FROM communities WHERE id > 20;
DELETE FROM communities_users WHERE community_id > 20;
UPDATE communities_users SET 
	community_id = FLOOR(RAND() * 20 + 1),
	user_id = FLOOR(RAND() * 200 + 1)
	;


SELECT * FROM genders;
SELECT * FROM users;
SELECT * FROM profiles;
SELECT * FROM messages;
SELECT * FROM media;
SELECT * FROM media_types;
SELECT * FROM friendship;
SELECT * FROM friendship_statuses;
SELECT * FROM communities;
SELECT * FROM communities_users cu ;


DESC users;		
DESC profiles ;
DESC friendship ;
DESC messages ;
DESC media;

