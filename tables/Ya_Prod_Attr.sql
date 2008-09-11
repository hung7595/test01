DROP TABLE Ya_Prod_Attr
/

CREATE TABLE Ya_Prod_Attr (
	sku                          int                   NOT NULL ,
	attribute_id                 int                   NOT NULL ,
	us_enabled                   char(1)               ,
	hk_enabled                   char(1)               ,
	jp_enabled                   char(1)               ,
	tw_enabled                   char(1)               ,
	us_ws_enabled                char(1)               ,
	hk_ws_enabled                char(1)               ,
	jp_ws_enabled                char(1)               ,
	tw_ws_enabled                char(1)	
)
/

ALTER TABLE Ya_Prod_Attr
ADD CONSTRAINT PK_Prod_Attr PRIMARY KEY (sku, attribute_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Prod_Attr_01 ON Ya_Prod_Attr(attribute_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Prod_Attr_02 ON Ya_Prod_Attr(attribute_id, sku) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Attr FOR Ya_Prod_Attr
/


create or replace TRIGGER TRI_prod_attr_1
BEFORE INSERT OR UPDATE OF us_enabled
ON ya_prod_attr
FOR EACH ROW
BEGIN
	:NEW.us_enabled := UPPER(:NEW.us_enabled);
END;

create or replace TRIGGER TRI_prod_attr_2
BEFORE INSERT OR UPDATE OF hk_enabled
ON ya_prod_attr
FOR EACH ROW
BEGIN
	:NEW.hk_enabled := UPPER(:NEW.hk_enabled);
END;

create or replace TRIGGER TRI_prod_attr_3
BEFORE INSERT OR UPDATE OF jp_enabled
ON ya_prod_attr
FOR EACH ROW
BEGIN
	:NEW.jp_enabled := UPPER(:NEW.jp_enabled);
END;

create or replace TRIGGER TRI_prod_attr_4
BEFORE INSERT OR UPDATE OF tw_enabled
ON ya_prod_attr
FOR EACH ROW
BEGIN
	:NEW.tw_enabled := UPPER(:NEW.tw_enabled);
END;

create or replace TRIGGER TRI_prod_attr_5
BEFORE INSERT OR UPDATE OF us_ws_enabled
ON ya_prod_attr
FOR EACH ROW
BEGIN
	:NEW.us_ws_enabled := UPPER(:NEW.us_ws_enabled);
END;

create or replace TRIGGER TRI_prod_attr_6
BEFORE INSERT OR UPDATE OF hk_ws_enabled
ON ya_prod_attr
FOR EACH ROW
BEGIN
	:NEW.hk_ws_enabled := UPPER(:NEW.hk_ws_enabled);
END;

create or replace TRIGGER TRI_prod_attr_7
BEFORE INSERT OR UPDATE OF jp_ws_enabled
ON ya_prod_attr
FOR EACH ROW
BEGIN
	:NEW.jp_ws_enabled := UPPER(:NEW.jp_ws_enabled);
END;

create or replace TRIGGER TRI_prod_attr_8
BEFORE INSERT OR UPDATE OF tw_ws_enabled
ON ya_prod_attr
FOR EACH ROW
BEGIN
	:NEW.tw_ws_enabled := UPPER(:NEW.tw_ws_enabled);
END;