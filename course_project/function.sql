-- Рассчет доходы-расходы за определенный год. Вычисляется сумма сделок, где компания выступала поставщиком. 
-- Из нее вычитается сумма сделок, где компания выступала получатаелем

DELIMITER //

DROP FUNCTION IF EXISTS year_chash_flow//

CREATE FUNCTION year_chash_flow (the_year INT, the_company INT)
RETURNS FLOAT DETERMINISTIC
BEGIN
-- 	USE marketplace;
	DECLARE incomes FLOAT;
	DECLARE expenses FLOAT;
	
	SET incomes = (
		SELECT SUM(price) FROM deals WHERE YEAR(complete_date) = 
			the_year 
			AND company_status_in_deal = 'PROVIDER'
			AND company_id = the_company
	);
	SET expenses = (
		SELECT SUM(price) FROM deals WHERE YEAR(complete_date) = 
			the_year 
			AND company_status_in_deal = 'RECIPIENT'
			AND company_id = the_company
	);

  RETURN incomes - expenses;
   
END//

SELECT year_chash_flow(2019, 1) AS profit

