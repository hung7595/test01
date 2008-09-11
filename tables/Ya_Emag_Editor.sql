DROP TABLE Ya_Emag_Editor
/

CREATE TABLE Ya_Emag_Editor (
	shopper_id                 char(32)                  NOT NULL ,
	enable_en                  char(1)                   NOT NULL ,
	enable_b5                  char(1)                   NOT NULL ,
	enable_jp                  char(1)                   NOT NULL ,
	enable_kr                  char(1)                   NOT NULL ,
	enable_gb                  char(1)                   NOT NULL
)
/

ALTER TABLE Ya_Emag_Editor
ADD CONSTRAINT PK_Emag_Editor PRIMARY KEY (shopper_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Emag_Editor FOR Ya_Emag_Editor
/