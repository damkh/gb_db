DESC users;
ALTER TABLE users
	ADD CONSTRAINT users_company_id_fk
		FOREIGN KEY users(company_id) REFERENCES companies(id)
			ON DELETE CASCADE;

DESC companies_delivery_methods ;
ALTER TABLE companies_delivery_methods
	ADD CONSTRAINT companies_delivery_methods_company_id_fk
		FOREIGN KEY companies_delivery_methods(company_id) REFERENCES companies(id)
			ON DELETE CASCADE;
			
DESC companies_business_lines ;
ALTER TABLE companies_business_lines
	ADD CONSTRAINT companies_business_lines_company_id_fk
		FOREIGN KEY companies_business_lines(company_id) REFERENCES companies(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT companies_business_lines_business_line_id_fk
		FOREIGN KEY companies_business_lines(business_line_id) REFERENCES business_lines(id);
		
ALTER TABLE companies_business_lines
	DROP CONSTRAINT companies_business_lines_bussiness_line_id_fk;
ALTER TABLE companies_business_lines
	DROP CONSTRAINT companies_business_lines_company_id_fk;