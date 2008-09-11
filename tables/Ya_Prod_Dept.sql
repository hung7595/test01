DROP TABLE Ya_Prod_Dept
/

CREATE TABLE Ya_Prod_Dept (
	sku                      int                   NOT NULL ,
	dept_id                  int                   NOT NULL ,
	us_enabled               char(1)               ,
	hk_enabled               char(1)               ,
	jp_enabled               char(1)               ,
	tw_enabled               char(1)               ,
	us_ws_enabled            char(1)
)
/

ALTER TABLE Ya_Prod_Dept
ADD CONSTRAINT PK_Prod_Dept PRIMARY KEY (sku, dept_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Prod_Dept_01 ON Ya_Prod_Dept(dept_id, sku, us_enabled) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Prod_Dept_02 ON Ya_Prod_Dept(dept_id, sku, tw_enabled) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Dept FOR Ya_Prod_Dept
/


create or replace TRIGGER TRI_prod_dept_1
BEFORE INSERT OR UPDATE OF us_enabled
ON ya_prod_dept
FOR EACH ROW
BEGIN
	:NEW.us_enabled := UPPER(:NEW.us_enabled);
END;

create or replace TRIGGER TRI_prod_dept_2
BEFORE INSERT OR UPDATE OF hk_enabled
ON ya_prod_dept
FOR EACH ROW
BEGIN
	:NEW.hk_enabled := UPPER(:NEW.hk_enabled);
END;

create or replace TRIGGER TRI_prod_dept_3
BEFORE INSERT OR UPDATE OF jp_enabled
ON ya_prod_dept
FOR EACH ROW
BEGIN
	:NEW.jp_enabled := UPPER(:NEW.jp_enabled);
END;

create or replace TRIGGER TRI_prod_dept_4
BEFORE INSERT OR UPDATE OF tw_enabled
ON ya_prod_dept
FOR EACH ROW
BEGIN
	:NEW.tw_enabled := UPPER(:NEW.tw_enabled);
END;

create or replace TRIGGER TRI_prod_dept_5
BEFORE INSERT OR UPDATE OF us_ws_enabled
ON ya_prod_dept
FOR EACH ROW
BEGIN
	:NEW.us_ws_enabled := UPPER(:NEW.us_ws_enabled);
END;