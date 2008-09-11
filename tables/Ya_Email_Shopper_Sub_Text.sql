DROP TABLE Ya_Email_Shopper_Sub_Text
/

CREATE TABLE Ya_Email_Shopper_Sub_Text (
	id                           int                         NOT NULL ,
	shopper_id                   char(32)                    NOT NULL ,
	subscribe_text               varchar2(300)               NOT NULL ,
	rowguid                      varchar2(50)                NOT NULL ,
	lang_id                      int                         DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Email_Shopper_Sub_Text
ADD CONSTRAINT PK_Email_Shopper_Sub_Text PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Email_Shopper_Sub_Text FOR Ya_Email_Shopper_Sub_Text
/