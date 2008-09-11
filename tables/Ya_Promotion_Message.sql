DROP TABLE Ya_Promotion_Message
/

CREATE TABLE Ya_Promotion_Message (
	promotion_name             varchar2(200)              NOT NULL ,
	block_key                  varchar2(50)               NOT NULL ,
	asset_id                   int                        NOT NULL
)	
/

ALTER TABLE Ya_Promotion_Message
ADD CONSTRAINT PK_Promotion_Message PRIMARY KEY (promotion_name, block_key)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Promotion_Message FOR Ya_Promotion_Message
/