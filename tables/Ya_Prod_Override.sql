DROP TABLE Ya_Prod_Override
/

CREATE TABLE Ya_Prod_Override (
	id              int         NOT NULL ,
	prod_id         int         NOT NULL ,
	type            int         NOT NULL ,
	sts             char(1)     NOT NULL ,
	lang_id         int         ,
	region_id       int
)
/

ALTER TABLE Ya_Prod_Override
ADD CONSTRAINT PK_Prod_Override PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE UNIQUE INDEX Un_Prod_Override ON Ya_Prod_Override(prod_id, type, lang_id, region_id) TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Prod_Override FOR Ya_Prod_Override
/