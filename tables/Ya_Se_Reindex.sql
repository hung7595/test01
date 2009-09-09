DROP TABLE Ya_Se_Reindex
/

CREATE TABLE Ya_Se_Reindex (
	sku                 number           NOT NULL ,
	action              int              NOT NULL ,
	created_dt          date             NOT NULL
)
/

ALTER TABLE Ya_Se_Reindex
ADD CONSTRAINT PK_Se_Reindex PRIMARY KEY (sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Se_Reindex FOR Ya_Se_Reindex
/
