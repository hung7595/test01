CREATE TABLE Ya_Globalcollect_Order (
	id                     int                NOT NULL , 
	shopper_id             CHAR(32)           NOT NULL , 
	encrypted_cc_number    varchar2(128)      NOT NULL ,  
	expiry_year            int                NOT NULL ,
	expiry_month           int                NOT NULL , 
	encrypted_key_version  int                NOT NULL , 
	create_user            varchar2(50)       NOT NULL ,
	create_dt              date               NOT NULL
)
/

ALTER TABLE Ya_Globalcollect_Order ADD
CONSTRAINT PK_Globalcollect_Order PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Globalcollect_Order FOR Ya_Globalcollect_Order
/
