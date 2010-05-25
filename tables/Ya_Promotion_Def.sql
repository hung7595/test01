DROP TABLE Ya_Promotion_Def
/

CREATE TABLE Ya_Promotion_Def (
	id                    int               NOT NULL, 
	promotion_id          int               NOT NULL,
	site_id               int               ,
	type                  int               NOT NULL,
	value                 varchar2(50)      NOT NULL
)
/

ALTER TABLE Ya_Promotion_Def
ADD CONSTRAINT PK_Promotion_Def PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Promotion_Def
ADD CONSTRAINT Fk_Promotion_Def_01 FOREIGN KEY (promotion_id) REFERENCES ya_promotion (id)
/

CREATE PUBLIC SYNONYM Ya_Promotion_Def FOR Ya_Promotion_Def
/
