DROP TABLE Ya_Review_Reviewername
/

CREATE TABLE Ya_Review_Reviewername (
	shopper_id                    char(32)                     NOT NULL ,
	display_mode                  int                          ,
	rowguid                       char(50)                     DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Review_Reviewername
ADD CONSTRAINT PK_Review_Reviewername PRIMARY KEY (shopper_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Review_Reviewername FOR Ya_Review_Reviewername
/