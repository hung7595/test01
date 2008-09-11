DROP TABLE Ya_Supplier_Lang
/

CREATE TABLE Ya_Supplier_Lang (
	supplier_id                int                          NOT NULL ,
	lang_id                    int                          NOT NULL ,
	supplier_name              varchar2(100)                ,
	supplier_name_u            nvarchar2(100)
)	
/

ALTER TABLE Ya_Supplier_Lang
ADD CONSTRAINT PK_Supplier_Lang PRIMARY KEY (supplier_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Supplier_Lang FOR Ya_Supplier_Lang
/