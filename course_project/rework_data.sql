-- Генерация file_path в таблице files
UPDATE files SET files.file_path=CONCAT("https://fileshare/",FLOOR(1 + RAND() * 100),"/",FLOOR(1 + RAND() * 1000),"/",file_path,".",(SELECT name FROM file_types WHERE file_types.id = files.file_type_id));
-- Синхронизация id компаний в таблице deals и delivery_methods 
UPDATE deals SET deals.company_id = 
	(SELECT delivery_methods.company_id FROM delivery_methods WHERE deals.delivery_method_id = delivery_methods.id);
-- Обновление колонок request_id и offer_id, так как сделка должна проходить либо по предложению, либо по запросу.
UPDATE deals SET request_id = NULL WHERE offer_id % 2 <> 0;
UPDATE deals SET offer_id = NULL WHERE request_id IS NOT NULL;
-- Синхронизация company_id в таблице deals, requests и offers, чтобы id компании в deals совпадал с id компании в requests или offers
UPDATE offers SET offers.company_id = COALESCE((SELECT deals.company_id FROM deals WHERE deals.offer_id = offers.id LIMIT 1), offers.company_id);
UPDATE requests SET requests.company_id = COALESCE((SELECT deals.company_id FROM deals WHERE deals.request_id = requests.id LIMIT 1), requests.company_id);
-- Синхронизация company_id в offers и products
UPDATE products SET products.company_id = COALESCE(
(SELECT offers.company_id FROM offers WHERE offers.product_id = products.id LIMIT 1), 
FLOOR(1 + RAND() * 100));
-- В таблице deals в колонке delivery_term не попали числовы значения, вся колонка заполнена NULL. 
-- Сгенерируем рандомные значения от 1 до 10
UPDATE deals SET delivery_term = FLOOR(1 + RAND() * 10);
