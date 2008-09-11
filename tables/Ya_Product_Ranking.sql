DROP TABLE Ya_Product_Ranking
/

CREATE TABLE Ya_Product_Ranking (
	dept_id                                int                  NOT NULL ,
	rank                                   int                  NOT NULL ,
	site_id                                int                  NOT NULL ,
	sku                                    int                  NOT NULL ,
	type_id                                int                  NOT NULL ,
	last_modified_datetime                 date                 NOT NULL
)
/

ALTER TABLE Ya_Product_Ranking
ADD CONSTRAINT PK_Product_Ranking PRIMARY KEY (type_id, dept_id, rank, sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Ranking FOR Ya_Product_Ranking
/