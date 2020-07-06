DROP DATABASE IF EXISTS marketplace;
CREATE DATABASE marketplace;

USE marketplace;

-- Таблица пользователей
DROP TABLES IF EXISTS users;
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор пользовтеля", 
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",
  middle_name VARCHAR(100) COMMENT "Отчество",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(100) COMMENT "Телефон",
  company_id INT UNSIGNED COMMENT "Ссылка на компанию",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Пользователи";  

-- Таблица компаний
DROP TABLES IF EXISTS companies;
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
) COMMENT "Компании";

-- Таблица связи пользователей и компаний
-- DROP TABLE IF EXISTS companies_users ;
-- CREATE TABLE companies_users (
--   company_id INT UNSIGNED NOT NULL COMMENT "Ссылка на компанию",
--   user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
--   created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
--   PRIMARY KEY (company_id, user_id) COMMENT "Составной первичный ключ"
-- ) COMMENT "Сотрудники компаний, связь между пользователями и компаниями";

-- Таблица способов доставки компаний
DROP TABLE IF EXISTS companies_delivery_methods;
CREATE TABLE companies_delivery_methods (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(150) NOT NULL COMMENT "Название способа доставки",
  company_id INT UNSIGNED COMMENT "Ссылка на компанию, которая добавила способ доставки",
  delivery_method_status BOOLEAN COMMENT "Статус метода, активен или нет",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Способы доставки компаний";


-- Таблица сфер деятельности компаний - справочник
CREATE TABLE business_lines (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор сферы деятельности",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название сферы деятельности",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Сферы дейтельности компаний";

-- Таблица связи компаний и сфер деятельности
CREATE TABLE companies_business_lines (
  company_id INT UNSIGNED NOT NULL COMMENT "Ссылка на компанию",
  business_line_id INT UNSIGNED NOT NULL COMMENT "Ссылка на сферу деятельности",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (company_id, business_line_id) COMMENT "Составной первичный ключ"
) COMMENT "Связь между компаниями и сферами деятельности";

-- Таблица запросов
DROP TABLE IF EXISTS requests;
CREATE TABLE requests (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  company_id INT UNSIGNED NOT NULL COMMENT "Ссылка на компанию-инициатора запроса",
  summary VARCHAR(255) NOT NULL COMMENT "Заголовок запроса",
  description VARCHAR(255) NOT NULL COMMENT "Описание запроса",
  price DECIMAL NOT NULL COMMENT "Цена за услугу или товар в запросе",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Запросы";

-- Таблица предложений
DROP TABLE IF EXISTS offers;
CREATE TABLE offers (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  company_id INT UNSIGNED NOT NULL COMMENT "Ссылка на компанию-инициатора предложения",
  summary VARCHAR(255) NOT NULL COMMENT "Заголовок предложения",
  description VARCHAR(255) NOT NULL COMMENT "Описание предложения",
  price DECIMAL NOT NULL COMMENT "Цена за услугу или товар в предложении",
  product_id INT UNSIGNED COMMENT "Ссылка на товар",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Предложения";

-- Таблица файлов
CREATE TABLE files (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор файла",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который загрузил файл",
  file_path VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
  file_size INT NOT NULL COMMENT "Размер файла",
  metadata JSON COMMENT "Метаданные файла",
  file_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип файла",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Файлы";

-- Таблица типов файлов - справочник
CREATE TABLE file_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор типа файла",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы файлов";

-- Таблица связей запросов и файлов
CREATE TABLE requests_files (
  request_id INT UNSIGNED NOT NULL COMMENT "Ссылка на запрос",
  file_id INT UNSIGNED NOT NULL COMMENT "Ссылка на файл",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (request_id, file_id) COMMENT "Составной первичный ключ"
) COMMENT "Связь между запросами и прикрепленными файлами";

-- Таблица связей предложений и файлов
CREATE TABLE offers_files (
  offer_id INT UNSIGNED NOT NULL COMMENT "Ссылка на предложение",
  file_id INT UNSIGNED NOT NULL COMMENT "Ссылка на файл",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (offer_id, file_id) COMMENT "Составной первичный ключ"
) COMMENT "Связь между предложениями и прикрепленными файлами";

-- Таблица сделок
CREATE TABLE deals (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор сделки",
  provider_company_id INT UNSIGNED NOT NULL COMMENT "Ссылка на компанию-поставщика",
  recipient_company_id INT UNSIGNED NOT NULL COMMENT "Ссылка на компанию-потребителя",
  request_id INT UNSIGNED COMMENT "Ссылка на запрос",
  offer_id INT UNSIGNED COMMENT "Ссылка на предложение",
  deal_price DECIMAL NOT NULL COMMENT "Цена за услугу или товар в сделке",
  delivery_method_id INT UNSIGNED  COMMENT "Ссылка на способ доставки",
  delivery_term INT UNSIGNED COMMENT "Срок выполнения",
  deal_status_id INT UNSIGNED COMMENT "Ссылка на статус сделки",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Сделки";

-- Таблица статусов сделок - справочник
DROP TABLE IF EXISTS deal_statuses;
CREATE TABLE deal_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор статуса сделки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название статуса",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы статусов сделок";

-- Таблица товаров
CREATE TABLE products (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор товара",
	category INT UNSIGNED NOT NULL COMMENT "Ссылка на категорию товара",
  name VARCHAR(255) NOT NULL COMMENT "Название товара",
  description TEXT NOT NULL COMMENT "Описание товара",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Товары"

-- Таблица категорий товаров - справочник
CREATE TABLE product_categories (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор категории товара",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название категории товара",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Категории товара";

-- Таблица связей товаров и файлов
CREATE TABLE products_files (
  product_id INT UNSIGNED NOT NULL COMMENT "Ссылка на товар",
  file_id INT UNSIGNED NOT NULL COMMENT "Ссылка на файл",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (product_id, file_id) COMMENT "Составной первичный ключ"
) COMMENT "Связь между товарами и прикрепленными файлами";

-- Таблица журналов действий пользователей
DROP TABLE users_logs;
CREATE TABLE users_logs (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор действия",
  user_id VARCHAR(255) NOT NULL COMMENT "Ссылка на имя пользователя",
  log_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на номер действия",
  metadata JSON COMMENT "Метаданные пользовательских действий",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Логи действий пользователей";

-- Таблица типов логов - справочник
DROP TABLE IF EXISTS log_types;
CREATE TABLE log_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор действия",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название действия",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы логов";

