DROP TABLE Ya_Promotion_Rel
/

CREATE TABLE Ya_Promotion_Rel (
	promotion_sku             int               NOT NULL ,
	sku                       int               NOT NULL
)	
/

ALTER TABLE Ya_Promotion_Rel
ADD CONSTRAINT PK_Promotion_Rel PRIMARY KEY (promotion_sku, sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Promotion_Rel_01 ON Ya_Promotion_Rel(sku, promotion_sku) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Promotion_Rel FOR Ya_Promotion_Rel
/