DROP TABLE IF EXISTS tbl;
CREATE  TABLE tbl (
  name CHAR(10) DEFAULT 'anonymous',
  description VARCHAR(255)
);
INSERT INTO tbl VALUES (DEFAULT, 'Новый пользователь');
INSERT INTO tbl VALUES ('Саша ', 'Саша Петров');
SELECT * FROM  tbl;