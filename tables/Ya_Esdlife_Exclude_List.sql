DROP TABLE Ya_Esdlife_Exclude_List
/

CREATE TABLE Ya_Esdlife_Exclude_List (
	sku                           int                   NOT NULL ,
	created_date                  date                  DEFAULT SYSDATE NOT NULL
)
/

ALTER TABLE Ya_Esdlife_Exclude_List
ADD CONSTRAINT PK_Esdlife_Exclude_List PRIMARY KEY (sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Esdlife_Exclude_List FOR Ya_Esdlife_Exclude_List
/