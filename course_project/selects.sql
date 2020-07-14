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
	
-- 5.
-- Вывести список файлов компании.
SELECT DISTINCT files.id 
	FROM 
	files 
	JOIN 
	offers_files 
	JOIN
	offers
ON offers.company_id = 72 AND offers.id = offers_files.offer_id AND offers_files.file_id = files.id
UNION
(SELECT DISTINCT files.id 
	FROM 
	files 
	JOIN 
	requests_files 
	JOIN
	requests
ON requests.company_id = 72 AND requests.id = requests_files.request_id AND requests_files.file_id = files.id)
UNION 
(SELECT DISTINCT files.id 
	FROM 
	files 
	JOIN 
	products_files 
	JOIN
	products 
ON products.company_id = 72 AND products.id = products_files.product_id AND products_files.file_id = files.id)
;

-- 6.
-- Найти количество сделок каждой компании, где она являлась получателем (company_status_in_deal='RECIPIENT')
SELECT 
	company_id, 
	COUNT(*) AS total_deals 
FROM deals 
WHERE company_status_in_deal='RECIPIENT' 
GROUP BY company_id;

-- 7.
-- Найти среднюю цену сделки по каждой компании, в которой компания являлась поставщиком (company_status_in_deal='PROVIDER')
SELECT 
	company_id, 
	AVG(price) AS avg_price
FROM deals 
WHERE company_status_in_deal='PROVIDER' 
GROUP BY company_id; 

