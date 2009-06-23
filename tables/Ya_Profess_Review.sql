Drop Table Ya_Profess_Review
/

CREATE TABLE Ya_Profess_Review (
	id                int                NOT NULL ,
	sku               int                NOT NULL
)
/

ALTER TABLE Ya_Profess_Review
ADD CONSTRAINT PK_Profess_Review PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Profess_Review_01 ON Ya_Profess_Review(sku) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Profess_Review FOR Ya_Profess_Review
/