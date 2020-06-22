-- Урок 6
-- Операторы, фильтрация, сортировка и ограничение

-- Разбор ДЗ

-- Тема Операции, задание 1
-- Пусть в таблице users поля created_at и updated_at оказались незаполненными.
-- Заполните их текущими датой и временем.
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME,
  updated_at DATETIME
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', NULL, NULL),
  ('Наталья', '1984-11-12', NULL, NULL),
  ('Александр', '1985-05-20', NULL, NULL),
  ('Сергей', '1988-02-14', NULL, NULL),
  ('Иван', '1998-01-12', NULL, NULL),
  ('Мария', '2006-08-29', NULL, NULL);

UPDATE
  users
SET
  created_at = NOW(),
  updated_at = NOW();
  
  
-- Тема Операции, задание 2
-- Таблица users была неудачно спроектирована.
-- Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались
-- значения в формате "20.10.2017 8:10".
-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', '07.01.2016 12:05', '07.01.2016 12:05'),
  ('Наталья', '1984-11-12', '20.05.2016 16:32', '20.05.2016 16:32'),
  ('Александр', '1985-05-20', '14.08.2016 20:10', '14.08.2016 20:10'),
  ('Сергей', '1988-02-14', '21.10.2016 9:14', '21.10.2016 9:14'),
  ('Иван', '1998-01-12', '15.12.2016 12:45', '15.12.2016 12:45'),
  ('Мария', '2006-08-29', '12.01.2017 8:56', '12.01.2017 8:56');

UPDATE
  users
SET
  created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
  updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

ALTER TABLE
  users
CHANGE
  created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE
  users
CHANGE
  updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

DESCRIBE users;


-- Тема Операции, задание 3
-- В таблице складских запасов storehouses_products в поле value могут встречаться самые
-- разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения
-- значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO
  storehouses_products (storehouse_id, product_id, value)
VALUES
  (1, 543, 0),
  (1, 789, 2500),
  (1, 3432, 0),
  (1, 826, 30),
  (1, 719, 500),
  (1, 638, 1);

SELECT
  *
FROM
  storehouses_products
ORDER BY
  IF(value > 0, 0, 1),
  value;


SELECT
  *
FROM
  storehouses_products
ORDER BY
  value = 0, value;


-- Тема Операции, задание 4
-- (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в
-- августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')

SELECT name  
  FROM users
  WHERE DATE_FORMAT(birthday_at, '%M') IN ('may', 'august');

-- Тема Операции, задание 5
-- (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса.
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2);
-- Отсортируйте записи в порядке, заданном в списке IN.

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

SELECT
  *
FROM
  catalogs
WHERE
  id IN (5, 1, 2)
ORDER BY
  FIELD(id, 5, 1, 2);

-- Тема Агрегация, задание 1
-- Подсчитайте средний возраст пользователей в таблице users
SELECT
  AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS age
FROM
  users;
	  
-- Тема Агрегация, задание 2
-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.
SELECT
  DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
  COUNT(*) AS total
FROM
  users
GROUP BY
  day
ORDER BY
  total DESC;

-- Тема Агрегация, задание 3
-- (по желанию) Подсчитайте произведение чисел в столбце таблицы
INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

SELECT ROUND(EXP(SUM(LN(id)))) FROM catalogs;



-- Предложенные варианты реализации лайков и публикаций (только для анализа, не для создания!)

-- Вариант 1
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  name VARCHAR(150) NOT NULL,
  description VARCHAR(250),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки"
);

CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  post_id INT UNSIGNED NOT NULL,
  couner INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки"
);

-- Вариант 2
-- Таблица Постов
CREATE TABLE post(
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор поста",
from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на автора поста",
body TEXT NOT NULL COMMENT "Текст поста",
media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на медиафайл",
created_at DATETIME DEFAULT NOW() COMMENT "Время создания поста"
reaction_id INT UNSIGNED NOT NULL COMMENT "Ссылка на таблицу реакций"
);
-- Таблица реакций
CREATE TABLE reaction(
from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя оставившего реакцию",
type_reaction_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип реакции",
);
-- Таблица типов реакций
CREATE TABLE type_reaction(
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор реакции",
name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название реакции",
):

-- Вариант 3
-- ЛАЙКИ

-- user_id - кто лайкнул
-- user_liked_id - чей контент лайкнули
-- media_id - понравившийся контент

CREATE TABLE likes (
  user_id INT UNSIGNED NOT NULL,
  media_id INT UNSIGNED NOT NULL,
  user_liked_id INT UNSIGNED NOT NULL,
  liked_at datetime DEFAULT CURRENT_TIMESTAMP,
);

-- ПОСТЫ

CREATE TABLE blogs (
  user_id INT UNSIGNED NOT NULL,
  letter_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255),
  body TEXT,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Вариант 4
-- Таблица постов
CREATE TABLE posts (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT UNSIGNED NOT NULL COMMENT "Id пользователя, разместившего пост",
	header VARCHAR(100) COMMENT "Заголовок поста",
	body TEXT NOT NULL COMMENT "Тело (текст) поста",
	media_id INT UNSIGNED COMMENT "Связанные медиа-данные", -- Как вариант - таблица связи (media_posts) вместо этого столбца (см. ниже),
	post_updated_at DATETIME COMMENT "Timestamp обновления поста (не строки в БД, а поста!)",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
); 

-- Таблица связи - позволит сопоставить одному посту несколько медиа-файлов
CREATE TABLE media_posts (
	post_id INT UNSIGNED NOT NULL,
	media_id INT UNSIGNED NOT NULL,
	PRIMARY KEY (post_id, media_id),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
);

-- Таблица хэштегов (если хэштеги хранить в таблице posts, то поиск по хэштегам будет сложным и ресурсоемким)
CREATE TABLE hashtags (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100),
	user_id INT UNSIGNED NOT NULL COMMENT "Id пользователя, разместившего хэштег",
	content_id INT UNSIGNED NOT NULL COMMENT "Id контента, к которому указан хэштег",
	content_type_id INT UNSIGNED NOT NULL COMMENT "Тип контента",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
);

-- Таблица лайков
CREATE TABLE likes (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	is_dislike BOOLEAN DEFAULT FALSE COMMENT "Если дизлайк, TRUE",
	user_id INT UNSIGNED NOT NULL COMMENT "Id пользователя, поставившего (диз)лайк",
	content_id INT UNSIGNED NOT NULL COMMENT "Id контента, которому поставлен (диз)лайк",
	content_type_id INT UNSIGNED NOT NULL COMMENT "Тип контента, который был оценен",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
);

-- Таблица типов контента (посты, новости, медиа-файлы, и тд)
-- Пояснение. Объектов, которым можно поставить лайк или сопоставить хэштег может быть много.
-- И все они различных типов. Чтобы можно было производить поиск контента по лайкам или хэштегам, нужно знать где искать.
-- Для этого и нужна таблица типов контента.  
CREATE TABLE content_types (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) COMMENT "Название типа контента", -- Или использовать ENUM
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"	
);

-- Вариант 5 (финальный)
-- Применим вариант с таблицей типов лайков
-- (применяем к базе vk только этот вариант!)

-- Таблица лайков
DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  target_id INT UNSIGNED NOT NULL,
  target_type_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Таблица типов лайков
DROP TABLE IF EXISTS target_types;
CREATE TABLE target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO target_types (name) VALUES 
  ('messages'),
  ('users'),
  ('media'),
  ('posts');

-- Заполняем лайки
INSERT INTO likes 
  SELECT 
    id, 
    FLOOR(1 + (RAND() * 100)), 
    FLOOR(1 + (RAND() * 100)),
    FLOOR(1 + (RAND() * 4)),
    CURRENT_TIMESTAMP 
  FROM messages;

-- Проверим
SELECT * FROM likes LIMIT 10;

-- Создадим таблицу постов
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  community_id INT UNSIGNED,
  head VARCHAR(255),
  body TEXT NOT NULL,
  media_id INT UNSIGNED,
  is_public BOOLEAN DEFAULT TRUE,
  is_archived BOOLEAN DEFAULT FALSE,
  views_counter INT UNSIGNED DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Добавляем внешние ключи в БД vk
-- Для таблицы профилей

-- Смотрим структуру таблицы
DESC profiles;

-- Добавляем внешние ключи
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL;

-- Изменяем тип столбца при необходимости
ALTER TABLE profiles DROP FOREIGN KEY profiles_user_id_fk;
ALTER TABLE profiles MODIFY COLUMN photo_id INT(10) UNSIGNED;
      
-- Для таблицы сообщений

-- Смотрим структурв таблицы
DESC messages;

-- Добавляем внешние ключи
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);

-- Смотрим диаграмму отношений в DBeaver (ERDiagram)


-- Если нужно удалить
ALTER TABLE table_name DROP FOREIGN KEY constraint_name;



-- Примеры на основе базы данных vk
USE vk;

-- Получаем данные пользователя
SELECT * FROM users WHERE id = 7;

SELECT first_name, last_name, 'main_photo', 'city' FROM users WHERE id = 7;

SELECT
  first_name,
  last_name,
  (SELECT filename FROM media WHERE id = 
    (SELECT photo_id FROM profiles WHERE user_id = 7)
  ) AS file_path,
  (SELECT city FROM profiles WHERE user_id = 7) AS city
  FROM users
    WHERE id = 7;  

-- Дорабатывем условия    
SELECT
  first_name,
  last_name,
  (SELECT filename FROM media WHERE id = 
    (SELECT photo_id FROM profiles WHERE user_id = users.id)
  ) AS file_path,
  (SELECT city FROM profiles WHERE user_id = users.id) AS city
  FROM users
    WHERE id = 7;          

-- Получаем фотографии пользователя
SELECT filename FROM media
  WHERE user_id = 7
    AND media_type_id = (
      SELECT id FROM media_types WHERE name = 'photo'
    );
    
SELECT * FROM media_types;

-- Выбираем историю по добавлению фотографий пользователем
SELECT CONCAT(
  'Пользователь ', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = media.user_id),
  ' добавил фото ', 
  filename, ' ', 
  created_at) AS news 
    FROM media 
    WHERE user_id = 7 AND media_type_id = (
        SELECT id FROM media_types WHERE name LIKE 'photo'
);

-- Найдём кому принадлежат 10 самых больших медиафайлов
SELECT user_id, filename, size 
  FROM media 
  ORDER BY size DESC
  LIMIT 10;

-- Улучшим запрос и используем алиасы для имён таблиц
SELECT 
  (SELECT CONCAT(first_name, ' ', last_name) 
    FROM users u WHERE u.id = m.user_id) AS owner,
  filename, 
  size 
    FROM media m
    ORDER BY size DESC
    LIMIT 10;
  
 -- Выбираем друзей пользователя с двух сторон отношения дружбы
(SELECT friend_id FROM friendship WHERE user_id = 7)
UNION
(SELECT user_id FROM friendship WHERE friend_id = 7);

-- Выбираем только друзей с активным статусом
SELECT * FROM friendship_statuses;

(SELECT friend_id 
  FROM friendship 
  WHERE user_id = 7 AND status_id = (
      SELECT id FROM friendship_statuses WHERE name = 'Confirmed'
    )
)
UNION
(SELECT user_id 
  FROM friendship 
  WHERE friend_id = 7 AND status_id = (
      SELECT id FROM friendship_statuses WHERE name = 'Confirmed'
    )
);


-- Выбираем медиафайлы друзей
SELECT filename FROM media WHERE user_id IN (
  (SELECT friend_id 
  FROM friendship 
  WHERE user_id = 7 AND status_id = (
      SELECT id FROM friendship_statuses WHERE name = 'Confirmed'
    )
  )
  UNION
  (SELECT user_id 
    FROM friendship 
    WHERE friend_id = 7 AND status_id = (
      SELECT id FROM friendship_statuses WHERE name = 'Confirmed'
    )
  )
);

-- Определяем пользователей, общее занимаемое место медиафайлов которых 
-- превышает 100МБ
SELECT user_id, SUM(size) AS total
  FROM media
  GROUP BY user_id
  HAVING total > 100000000
  ORDER BY total DESC;
    
-- Выбираем сообщения от пользователя и к пользователю
SELECT from_user_id, to_user_id, body, is_delivered, created_at 
  FROM messages
    WHERE from_user_id = 7 OR to_user_id = 7
    ORDER BY created_at DESC;
    
-- Сообщения со статусом
SELECT from_user_id, 
  to_user_id, 
  body, 
  IF(is_delivered, 'delivered', 'not delivered') AS status 
    FROM messages
      WHERE (from_user_id = 7 OR to_user_id = 7)
    ORDER BY created_at DESC;
    
 -- Выводим друзей пользователя с преобразованием пола и возраста 
SELECT 
    (SELECT CONCAT(first_name, ' ', last_name) 
      FROM users 
      WHERE id = user_id) AS friend,            -- имя пользователя
    CASE (gender)                       
      WHEN 'm' THEN 'man'
      WHEN 'w' THEN 'woman'
    END AS gender,                              -- пол
    TIMESTAMPDIFF(YEAR, birthday, NOW()) AS age -- возраст
  FROM profiles
  WHERE user_id IN (
    SELECT friend_id FROM friendship
      WHERE user_id = 7 
        AND status_id IN (
          SELECT id FROM friendship_statuses WHERE name = 'Confirmed'
          )
      UNION
      SELECT user_id 
      FROM friendship
      WHERE friend_id = 7
        AND status_id IN (
          SELECT id FROM friendship_statuses WHERE name = 'Confirmed'
          )
  );
    
-- Поиск пользователя по шаблонам имени  
SELECT CONCAT(first_name, ' ', last_name) AS fullname  
  FROM users
  WHERE first_name LIKE 'M%';
  
-- Используем регулярные выражения
SELECT CONCAT(first_name, ' ', last_name) AS fullname  
  FROM users
  WHERE last_name RLIKE '^S.*t$';
  
  
-- Дорабатываем данные photo_id таблицы профилей  

-- Проанализируем таблицу профилей  
SELECT * FROM profiles LIMIT 10;  

-- Создадим запрос на обновление photo_id
UPDATE profiles SET photo_id = 
  (SELECT id FROM media 
    WHERE media.user_id = profiles.user_id AND media_type_id = 1 
    LIMIT 1)
;

-- Проверим
SELECT user_id, photo_id FROM profiles;

  
  
-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение. 
-- Агрегация данных”

-- Работаем с БД vk и тестовыми данными, которые вы сгенерировали ранее:

-- 1. Создать все необходимые внешние ключи и диаграмму отношений.

-- 2. Создать и заполнить таблицы лайков и постов.

-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

-- 4. Подсчитать количество лайков которые получили 10 самых молодых пользователей. 

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в
-- использовании социальной сети
-- (критерии активности необходимо определить самостоятельно).
