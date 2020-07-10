-- 1.
-- Система будет уведомлять пользователей компании о новых заказах (откликах на запросы). 
-- Поэтому будет выполняться запрос на поиск пользователей, на компании (deals.provider_company_id) которых пришли новые заказы. 
-- Пример такого запроса:
SELECT users.id, deals.id, deals.status_id
	FROM 
		users 
		JOIN
		companies 
		JOIN
		deals
	ON users.company_id = companies.id AND deals.provider_company_id = companies.id;

-- 2.
-- Менеджеры компаний будут постоянно запрашивать заказы с определнным статусом (например, "новый" или "в пути")
SELECT deals.id 
	FROM
		deals
		JOIN
		deal_statuses 
		ON deal_statuses.name = 'new' AND deals.company_id = 111;