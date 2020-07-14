-- В таблице deals есть два поля: offer_id и request_id указывающие на предложение или запрос, по которому заключается сделка.
-- Допустимо только одно из них, т.е. сделка может заключаться либо по запросу, либо по предложению.
-- Недопустимо, чтобы оба поля были пустыми (NULL)
-- При попытке присвоить обоим полям определенные значения или присвоить обоим полям NULL-значения необходимо отменить операцию.
DROP TRIGGER IF EXISTS deal_offer_request_both_insert;
DROP TRIGGER IF EXISTS deal_offer_request_both_update;
DROP TRIGGER IF EXISTS deal_offer_request_null_insert;
DROP TRIGGER IF EXISTS deal_offer_request_null_update;
DELIMITER //

CREATE TRIGGER deal_offer_request_both_insert BEFORE INSERT ON deals
FOR EACH ROW 
BEGIN 
    IF (NEW.offer_id IS NOT NULL) AND (NEW.request_id IS NOT NULL)
    	THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'deals.offer_id and deals.request_id can not be defined together';
END IF;
END//

CREATE TRIGGER deal_offer_request_both_update BEFORE UPDATE ON deals
FOR EACH ROW 
BEGIN 
    IF (NEW.offer_id IS NOT NULL) AND (NEW.request_id IS NOT NULL)
    	THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'deals.offer_id and deals.request_id can not be defined together';
END IF;
END//

CREATE TRIGGER deal_offer_request_null_insert BEFORE INSERT ON deals
FOR EACH ROW 
BEGIN 
    IF (NEW.offer_id IS NULL) AND (NEW.request_id IS NULL)
    	THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'deals.offer_id and deals.request_id can not be NULL together';
END IF;
END//

CREATE TRIGGER deal_offer_request_null_update BEFORE UPDATE ON deals
FOR EACH ROW 
BEGIN 
    IF (NEW.offer_id IS NULL) AND (NEW.request_id IS NULL)
    	THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'deals.offer_id and deals.request_id can not be NULL together';
END IF;
END//