ALTER TABLE users
	ADD CONSTRAINT users_company_id_fk
		FOREIGN KEY users(company_id) REFERENCES companies(id)
			ON DELETE CASCADE;

ALTER TABLE delivery_methods
	ADD CONSTRAINT delivery_methods_company_id_fk
		FOREIGN KEY delivery_methods(company_id) REFERENCES companies(id)
			ON DELETE CASCADE;
			
DESC companies_business_lines ;
ALTER TABLE companies_business_lines
	ADD CONSTRAINT companies_business_lines_company_id_fk
		FOREIGN KEY companies_business_lines(company_id) REFERENCES companies(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT companies_business_lines_business_line_id_fk
		FOREIGN KEY companies_business_lines(business_line_id) REFERENCES business_lines(id);
		
ALTER TABLE requests
	ADD CONSTRAINT requests_company_id_fk
		FOREIGN KEY requests(company_id) REFERENCES companies(id)
			ON DELETE CASCADE;
		
ALTER TABLE offers
	ADD CONSTRAINT offers_company_id_fk
		FOREIGN KEY offers(company_id) REFERENCES companies(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT offers_product_id_fk
		FOREIGN KEY offers(product_id) REFERENCES products(id)
			ON DELETE SET NULL;


ALTER TABLE files
	ADD CONSTRAINT files_file_type_id_fk
		FOREIGN KEY files(file_type_id) REFERENCES file_types(id);
		
ALTER TABLE offers_files
	ADD CONSTRAINT offers_files_offer_id_fk
		FOREIGN KEY offers_files(offer_id) REFERENCES offers(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT offers_files_file_id_fk
		FOREIGN KEY offers_files(file_id) REFERENCES files(id)
			ON DELETE CASCADE;

ALTER TABLE requests_files
	ADD CONSTRAINT requests_files_request_id_fk
		FOREIGN KEY requests_files(request_id) REFERENCES requests(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT requests_files_file_id_fk
		FOREIGN KEY requests_files(file_id) REFERENCES files(id)
			ON DELETE CASCADE;

ALTER TABLE products_files
	ADD CONSTRAINT products_files_product_id_fk
		FOREIGN KEY products_files(product_id) REFERENCES products(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT products_files_file_id_fk
		FOREIGN KEY products_files(file_id) REFERENCES files(id)
			ON DELETE CASCADE;

ALTER TABLE products
	ADD CONSTRAINT products_category_id_fk
		FOREIGN KEY products(category_id) REFERENCES products_categories(id),
	ADD CONSTRAINT products_company_id_fk
		FOREIGN KEY products(company_id) REFERENCES companies(id);

ALTER TABLE deals
	ADD CONSTRAINT deals_company_id_fk
		FOREIGN KEY deals(company_id) REFERENCES companies(id),
	ADD CONSTRAINT deals_request_id_fk
		FOREIGN KEY deals(request_id) REFERENCES requests(id),
	ADD CONSTRAINT deals_offer_id_fk
		FOREIGN KEY deals(offer_id) REFERENCES offers(id),
	ADD CONSTRAINT deals_delivery_method_id_fk
		FOREIGN KEY deals(delivery_method_id) REFERENCES delivery_methods(id),
	ADD CONSTRAINT deals_status_id_fk
		FOREIGN KEY deals(status_id) REFERENCES deal_statuses(id);

