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
		
-- 3.
-- Возможный частый запрос - отобразить все товары в определенной категории
SELECT products.id 
	FROM
		products
		JOIN
		products_categories 
	ON products.category_id = products_categories.id AND products_categories.name = 'какая-нибудь категория';

-- 4.
-- Количество пользователей в каждой компании
SELECT CONCAT(companies.form," ",companies.name) , COUNT(users.company_id) AS users_num
	FROM 
		companies
		LEFT JOIN
		users
	ON users.company_id = companies.id
	GROUP BY companies.id
	ORDER BY users_num;
	