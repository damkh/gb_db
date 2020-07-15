-- 1. 
-- При входе в систему будет проверяться соответсвие email паролю пользователя. Пример такого запроса:
SELECT id, email, passwd
 	FROM users
 		WHERE users.email = 'mail@mail.mail' AND users.passwd = MD5('*****');

-- Поэтому создадим индекс:
CREATE UNIQUE INDEX users_email_passwd_idx ON users(email, passwd);

-- 2.
-- Для запроса всех сделок компании
CREATE INDEX deals_id_company_id_idx ON deals(id, company_id);

-- 3.
-- Для запроса всех предложений с ограничениями по цене
CREATE INDEX offers_id_price_idx ON offers(id, price);
-- Для запроса всех запросов с ограничениями по цене
CREATE INDEX requests_id_price_idx ON requests(id, price);

-- 4.
-- Часто будет необходимость составлять полное имя пользователя (Имя и Фамилия)
-- Поэтому создадим составной интекс
CREATE INDEX users_first_name_last_name_idx ON users(first_name, last_name);

