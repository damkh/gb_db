-- 1. 
-- При входе в систему будет проверяться соответсвие email паролю пользователя. Пример такого запроса:
SELECT id, email, passwd
 	FROM users
 		WHERE users.email = 'mail@mail.mail' AND users.passwd = MD5('*****');

-- Поэтому создадим индекс:
CREATE UNIQUE INDEX users_email_passwd_idx ON users(email, passwd);

-- 2.
-- Менеджеры (аналитики, руководство) компаний будут часто запрашивать 
-- список своих сделок с определенным статусом
SELECT deals.id, deals.company_status_in_deal_id
	FROM deals
		WHERE deals.recipient_company_id = 111;

-- Поэтому создадим индекс:
CREATE UNIQUE INDEX deals_id_company_status_in_deal_id_idx ON deals(id, company_status_in_deal_id);

-- 3.
-- Для запроса всех предложений с ограничениями по цене
