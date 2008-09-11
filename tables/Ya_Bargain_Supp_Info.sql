DROP TABLE Ya_Bargain_Supp_Info
/

CREATE TABLE Ya_Bargain_Supp_Info (
	site_id                       number                          NOT NULL ,
	dept_id                       number                          NOT NULL ,
	prod_count                    number                          ,
	max_discount                  number(9,2)                     ,
	updated_date                  date       
)
/


CREATE PUBLIC SYNONYM Ya_Bargain_Supp_Info FOR Ya_Bargain_Supp_Info
/