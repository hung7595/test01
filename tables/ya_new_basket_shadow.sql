drop table ya_new_basket_shadow
/

CREATE TABLE ya_new_basket_shadow (
	PAYPAL_UID           CHAR(32)	       NOT NULL,
	SHOPPER_ID           CHAR(32)          NOT NULL,
	SITE_ID              NUMBER(38)        NOT NULL,
	SKU                  NUMBER(38)        NOT NULL,
	QUANTITY             NUMBER(38)        NOT NULL,
	CREATED_DATETIME     DATE              default sysdate     NOT NULL ,
	TYPE                 NUMBER(38)        NOT NULL
)
/

ALTER TABLE ya_new_basket_shadow
ADD CONSTRAINT pk_new_basket_shadow PRIMARY KEY (paypal_uid,shopper_id,site_id) 
USING INDEX TABLESPACE FESTORAGE_INDEX
/

CREATE INDEX ix_new_basket_shadow_1 on ya_new_basket_shadow (SHOPPER_ID, SITE_ID) TABLESPACE FESTORAGE_INDEX
/

CREATE PUBLIC SYNONYM ya_new_basket_shadow FOR ya_new_basket_shadow
/