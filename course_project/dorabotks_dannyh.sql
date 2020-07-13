SELECT COUNT(*) FROM users LIMIT 10;
SELECT companies.id, COUNT(users.company_id) AS users_num
	FROM 
		companies
		LEFT JOIN
		users
	ON users.company_id = companies.id
	GROUP BY companies.id
	ORDER BY users_num;


SELECT * FROM users WHERE users.company_id = 4;

SELECT COUNT(*) FROM business_lines;
SELECT company_id FROM companies_business_lines GROUP BY company_id ;
SELECT DISTINCT company_id FROM companies_business_lines;

SELECT * FROM files;
-- Генерация file_path в таблице files
UPDATE files SET files.file_path=CONCAT("https://fileshare/",FLOOR(1 + RAND() * 100),"/",FLOOR(1 + RAND() * 1000),"/",file_path,".",(SELECT name FROM file_types WHERE file_types.id = files.file_type_id));
-- Синхронизация id компаний в таблице deals и delivery_methods 
UPDATE deals SET deals.company_id = 
	(SELECT delivery_methods.company_id FROM delivery_methods WHERE deals.delivery_method_id = delivery_methods.id);
-- Обновление колонок request_id и offer_id, так как сделка должна проходить либо по предложению, либо по запросу.
UPDATE deals SET request_id = NULL WHERE offer_id % 2 <> 0;
UPDATE deals SET offer_id = NULL WHERE request_id IS NOT NULL;
-- Синхронизация company_id в таблице deals, requests и offers, чтобы id компании в ddeals совпадал с id компании в requests или offers
UPDATE offers SET offers.company_id = COALESCE((SELECT deals.company_id FROM deals WHERE deals.offer_id = offers.id LIMIT 1), offers.company_id);
UPDATE requests SET requests.company_id = COALESCE((SELECT deals.company_id FROM deals WHERE deals.request_id = requests.id LIMIT 1), requests.company_id);
-- Синхронизация company_id в offers и products
UPDATE products SET products.company_id = COALESCE(
(SELECT offers.company_id FROM offers WHERE offers.product_id = products.id LIMIT 1), 
FLOOR(1 + RAND() * 100));



SELECT * FROM deals;
SELECT company_id FROM delivery_methods;
SELECT deals.id, deals.company_id, delivery_methods.company_id 
	FROM 
		deals
		JOIN
		delivery_methods 
	WHERE delivery_methods.company_id  = 93;

SELECT * FROM delivery_methods WHERE company_id = 98;
SELECT * FROM deals WHERE company_id = 98;

SELECT * FROM delivery_methods WHERE company_id = 93;
SELECT * FROM deals WHERE company_id = 93;
SELECT * FROM deals;

SELECT * FROM offers WHERE id = 3;
SELECT * FROM requests WHERE id = 13;

SELECT * FROM products WHERE company_id = 1 ORDER BY company_id ;
SELECT * FROM offers WHERE company_id =1;
SELECT * FROM products;

UPDATE files SET files.company_id = 
	(SELECT products.company_id FROM 
		products
		JOIN
		products_files 
		JOIN 
		files
	ON products.id = products_files.product_id AND files.id = products_files.file_id);

SELECT products.company_id FROM 
	products
	JOIN
	products_files 
	JOIN 
	files
ON products.id = products_files.product_id AND files.id = products_files.file_id 
LIMIT 1;









