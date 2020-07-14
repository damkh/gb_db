-- В таблицу users_logs необходимо записывать изменения, произведенные в пользователем в таблицах
DROP TRIGGER IF EXISTS users_insert_logs;
DROP TRIGGER IF EXISTS offers_insert_logs;
DROP TRIGGER IF EXISTS requests_insert_logs;
DROP TRIGGER IF EXISTS users_update_logs;
DROP TRIGGER IF EXISTS offers_update_logs;
DROP TRIGGER IF EXISTS requests_update_logs;
DROP TRIGGER IF EXISTS users_delete_logs;
DROP TRIGGER IF EXISTS offers_delete_logs;
DROP TRIGGER IF EXISTS requests_delete_logs;
DELIMITER //

-- INSERT
CREATE TRIGGER users_insert_logs AFTER INSERT ON users
  FOR EACH ROW 
  BEGIN 
      INSERT INTO users_logs(table_name, id_in_table, action_type) VALUES('users', NEW.id, 'INSERT');
END//

CREATE TRIGGER offers_insert_logs AFTER INSERT ON offers
  FOR EACH ROW 
  BEGIN 
      INSERT INTO users_logs(table_name, id_in_table, action_type) VALUES('offers', NEW.id, 'INSERT');
  END//

CREATE TRIGGER requests_insert_logs AFTER INSERT ON requests
  FOR EACH ROW 
  BEGIN 
      INSERT INTO users_logs(table_name, id_in_table, action_type) VALUES('requests', NEW.id, 'INSERT');
  END//
  
-- UPDATE
CREATE TRIGGER users_update_logs AFTER UPDATE ON users
  FOR EACH ROW 
  BEGIN 
      INSERT INTO users_logs(table_name, id_in_table, action_type) VALUES('users', NEW.id, 'UPDATE');
END//

CREATE TRIGGER offers_update_logs AFTER UPDATE ON offers
  FOR EACH ROW 
  BEGIN 
      INSERT INTO users_logs(table_name, id_in_table, action_type) VALUES('offers', NEW.id, 'UPDATE');
  END//

CREATE TRIGGER requests_update_logs AFTER UPDATE ON requests
  FOR EACH ROW 
  BEGIN 
      INSERT INTO users_logs(table_name, id_in_table, action_type) VALUES('requests', NEW.id, 'UPDATE');
  END//

-- DELETE
CREATE TRIGGER users_delete_logs AFTER DELETE ON users
  FOR EACH ROW 
  BEGIN 
      INSERT INTO users_logs(table_name, id_in_table, action_type) VALUES('users', OLD.id, 'DELETE');
END//

CREATE TRIGGER offers_delete_logs AFTER DELETE ON offers
  FOR EACH ROW 
  BEGIN 
      INSERT INTO users_logs(table_name, id_in_table, action_type) VALUES('offers', OLD.id, 'DELETE');
  END//

CREATE TRIGGER requests_delete_logs AFTER DELETE ON requests
  FOR EACH ROW 
  BEGIN 
      INSERT INTO users_logs(table_name, id_in_table, action_type) VALUES('requests', OLD.id, 'DELETE');
  END//