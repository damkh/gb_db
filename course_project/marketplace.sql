DROP DATABASE IF EXISTS marketplace;
CREATE DATABASE marketplace;
-- 
-- USE marketplace;

-- Таблица пользователей
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор пользовтеля", 
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",
  middle_name VARCHAR(100) COMMENT "Отчество",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(100) COMMENT "Телефон",
  company_id INT UNSIGNED COMMENT "Ссылка на компанию",
  passwd VARCHAR(256) NOT NULL COMMENT "Пароль пользователя",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT="Пользователи";  


-- Таблица компаний
DROP TABLE IF EXISTS companies;
CREATE TABLE companies (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор компании",
  name VARCHAR(150) NOT NULL COMMENT "Название компании",
  form VARCHAR(10) NOT NULL COMMENT "Форма компании (ООО, ПАО и т.д.)",
  inn VARCHAR(20) COMMENT "ИНН компании",
  country VARCHAR(150) COMMENT "Страна расположения компании",
  city VARCHAR(150) COMMENT "Город расположения компании",
  address VARCHAR(200) COMMENT "Адрес",
  postcode VARCHAR(20) COMMENT "Индекс компании",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT="Компании";


-- Таблица способов доставки компаний
DROP TABLE IF EXISTS delivery_methods;
CREATE TABLE delivery_methods (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(150) NOT NULL COMMENT "Название способа доставки",
  company_id INT UNSIGNED COMMENT "Ссылка на компанию, которая добавила способ доставки",
  status BOOLEAN COMMENT "Статус метода доставки, активен или нет",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT="Способы доставки компаний";

-- Таблица сфер деятельности компаний - справочник
DROP TABLE IF EXISTS business_lines ;
CREATE TABLE business_lines (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор сферы деятельности",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название сферы деятельности",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT="Сферы дейтельности компаний";

-- Таблица связи компаний и сфер деятельности
DROP TABLE IF EXISTS companies_business_lines ;
CREATE TABLE companies_business_lines (
  company_id INT UNSIGNED NOT NULL COMMENT "Ссылка на компанию",
  business_line_id INT UNSIGNED NOT NULL COMMENT "Ссылка на сферу деятельности",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (company_id, business_line_id) COMMENT "Составной первичный ключ"
) COMMENT="Связь между компаниями и сферами деятельности";

-- Таблица запросов
DROP TABLE IF EXISTS requests;
CREATE TABLE requests (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  company_id INT UNSIGNED NOT NULL COMMENT "Ссылка на компанию-инициатора запроса",
  summary VARCHAR(255) NOT NULL COMMENT "Заголовок запроса",
  description VARCHAR(255) NOT NULL COMMENT "Описание запроса",
  price DECIMAL NOT NULL COMMENT "Цена за услугу или товар в запросе",
  status BOOLEAN NOT NULL DEFAULT FALSE COMMENT "Статус - опубликовано или нет",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT="Запросы";

-- Таблица предложений
DROP TABLE IF EXISTS offers;
CREATE TABLE offers (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  company_id INT UNSIGNED NOT NULL COMMENT "Ссылка на компанию-инициатора предложения",
  summary VARCHAR(255) NOT NULL COMMENT "Заголовок предложения",
  description VARCHAR(255) NOT NULL COMMENT "Описание предложения",
  price DECIMAL NOT NULL COMMENT "Цена за услугу или товар в предложении",
	status BOOLEAN NOT NULL DEFAULT FALSE COMMENT "Статус - опубликовано или нет",
  product_id INT UNSIGNED COMMENT "Ссылка на товар",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT="Предложения";


-- Таблица файлов
DROP TABLE IF EXISTS files;
CREATE TABLE files (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор файла",
  file_path VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
  file_size INT NOT NULL COMMENT "Размер файла",
  metadata JSON COMMENT "Метаданные файла",
  file_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип файла",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT="Файлы";

-- Таблица типов файлов - справочник
DROP TABLE IF EXISTS file_types;
CREATE TABLE file_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор типа файла",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT="Типы файлов";

-- Таблица связей запросов и файлов
DROP TABLE IF EXISTS requests_files;
CREATE TABLE requests_files (
  request_id INT UNSIGNED NOT NULL COMMENT "Ссылка на запрос",
  file_id INT UNSIGNED NOT NULL COMMENT "Ссылка на файл",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (request_id, file_id) COMMENT "Составной первичный ключ"
) COMMENT="Связь между запросами и прикрепленными файлами";

-- Таблица связей предложений и файлов
DROP TABLE IF EXISTS offers_files;
CREATE TABLE offers_files (
  offer_id INT UNSIGNED NOT NULL COMMENT "Ссылка на предложение",
  file_id INT UNSIGNED NOT NULL COMMENT "Ссылка на файл",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (offer_id, file_id) COMMENT "Составной первичный ключ"
) COMMENT="Связь между предложениями и прикрепленными файлами";

-- Таблица сделок (заказов)
DROP TABLE IF EXISTS deals;
CREATE TABLE deals (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор сделки",
  company_id INT UNSIGNED NOT NULL COMMENT "Ссылка на компанию",
  company_status_in_deal ENUM('PROVIDER', 'RECIPIENT') NOT NULL COMMENT "Статус компании в сделке - поставщик или получатель",
  request_id INT UNSIGNED COMMENT "Ссылка на запрос",
  offer_id INT UNSIGNED COMMENT "Ссылка на предложение",
  price DECIMAL NOT NULL COMMENT "Цена за услугу или товар в сделке",
  delivery_method_id INT UNSIGNED  COMMENT "Ссылка на способ доставки",
  delivery_term INT UNSIGNED COMMENT "Срок выполнения",
  status_id INT UNSIGNED COMMENT "Ссылка на статус сделки",
  complete_date DATETIME COMMENT "Дата завершения сделки (даже если она откланена)",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT="Сделки";


-- Таблица статусов сделок - справочник
DROP TABLE IF EXISTS deal_statuses;
CREATE TABLE deal_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор статуса сделки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название статуса",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT="Типы статусов сделок";

-- Таблица товаров
DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор товара",
	category_id INT UNSIGNED NOT NULL COMMENT "Ссылка на категорию товара",
  name VARCHAR(255) NOT NULL COMMENT "Название товара",
  description TEXT NOT NULL COMMENT "Описание товара",
  company_id INT UNSIGNED NOT NULL COMMENT "Ссылка на компанию",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT="Товары";

-- Таблица категорий товаров - справочник
DROP TABLE IF EXISTS product_categories;
CREATE TABLE products_categories (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор категории товара",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название категории товара",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT="Категории товара";

-- Таблица связей товаров и файлов
DROP TABLE IF EXISTS products_files;
CREATE TABLE products_files (
  product_id INT UNSIGNED NOT NULL COMMENT "Ссылка на товар",
  file_id INT UNSIGNED NOT NULL COMMENT "Ссылка на файл",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (product_id, file_id) COMMENT "Составной первичный ключ"
) COMMENT="Связь между товарами и прикрепленными файлами";

-- Таблица журналов действий пользователей
DROP TABLE IF EXISTS users_logs;
CREATE TABLE users_logs (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор действия",
  table_name VARCHAR(256) NOT NULL COMMENT "Имя таблицы",
  id_in_table INT UNSIGNED NOT NULL COMMENT "id в измененной таблице",
  action_type ENUM('DELETE', 'INSERT', 'UPDATE') NOT NULL COMMENT "Тип действия",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT="Логи действий" ENGINE="Archive";
