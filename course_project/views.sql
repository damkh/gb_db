-- Показать список предложений определенной компании, по которым заключена сделка. Вывести цену в предложении и в сделке
DROP VIEW IF EXISTS offers_deals;
CREATE VIEW offers_deals AS
	SELECT offers.summary AS offeer_summary, offers.price AS offer_price, deals.price AS deal_price
	FROM 
		offers
		JOIN
		deals
		ON offers.company_id = deals.company_id AND deals.offer_id = offers.id AND deals.company_id = 72;
	
SELECT * FROM offers_deals
	
-- Вывести список сделок по запросам с их статусами и сроками доставки с сортировкой по статусам
DROP VIEW IF EXISTS deals_by_statuses;
CREATE VIEW deals_by_statuses AS
	SELECT deals.id AS 'Deal ID', requests.summary AS 'Request', deal_statuses.name AS 'Status', deals.delivery_term AS 'Delivery Term' 
	FROM
		deals
		JOIN
		requests 
		JOIN
		deal_statuses 
		ON deals.request_id = requests.id AND deals.status_id = deal_statuses.id AND deals.company_id = 72
	ORDER BY deal_statuses.name;
	
		