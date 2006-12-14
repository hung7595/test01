drop table ya_warranty_basket_shadow
/

CREATE TABLE ya_warranty_basket_shadow (
	SHOPPER_ID              CHAR(32) 	NOT NULL,  
	SITE_ID                 NUMBER   	NOT NULL, 
	PAYPAL_UID              CHAR(32) 	NOT NULL,    
	WARRANTEE_SKU           NUMBER   	NOT NULL,   
	WARRANTY_SKU            NUMBER   	NOT NULL,   
	CREATED_DATE            DATE     	default sysdate NOT NULL	  
)
/

ALTER TABLE ya_warranty_basket_shadow
ADD CONSTRAINT pk_warranty_basket_shadow PRIMARY KEY (shopper_id,site_id,paypal_uid) 
USING INDEX TABLESPACE FESTORAGE_INDEX
/

CREATE PUBLIC SYNONYM ya_warranty_basket_shadow FOR ya_warranty_basket_shadow
/

