DROP TABLE Ya_Prod_Specification_Gp_Lang
/

CREATE TABLE Ya_Prod_Specification_Gp_Lang (
	specification_group_id          int                        NOT NULL ,
	lang_id                         int                        NOT NULL ,
	name                            nvarchar2(600)             NOT NULL
)
/

ALTER TABLE Ya_Prod_Specification_Gp_Lang
ADD CONSTRAINT PK_Prod_Specification_Gp_Lang PRIMARY KEY (specification_group_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Specification_Gp_Lang FOR Ya_Prod_Specification_Gp_Lang
/