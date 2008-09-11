DROP TABLE Ya_Country
/

CREATE TABLE Ya_Country (
	country_id                  int                      NOT NULL ,
	alpha_2                     char(2)                  ,
	alpha_3                     char(3)                  ,
	country_name                varchar2(50)             ,
	us_canship                  char(1)                  ,
	ys_canship                  char(1)                  ,
	jp_canship                  char(1)                  ,
	tw_canship                  char(1)                  ,
	us_ws_canship               char(1)                  ,
	hk_ws_canship               char(1)                  ,
	jp_ws_canship               char(1)                  ,
	tw_ws_canship               char(1)
)
/

ALTER TABLE Ya_Country
ADD CONSTRAINT PK_Country PRIMARY KEY (country_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Country FOR Ya_Country
/


create or replace TRIGGER TRI_country_1
BEFORE INSERT OR UPDATE OF us_canship
ON ya_country
FOR EACH ROW
BEGIN
	:NEW.us_canship := UPPER(:NEW.us_canship);
END;

create or replace TRIGGER TRI_country_2
BEFORE INSERT OR UPDATE OF ys_canship
ON ya_country
FOR EACH ROW
BEGIN
	:NEW.ys_canship := UPPER(:NEW.ys_canship);
END;

create or replace TRIGGER TRI_country_3
BEFORE INSERT OR UPDATE OF jp_canship
ON ya_country
FOR EACH ROW
BEGIN
	:NEW.jp_canship := UPPER(:NEW.jp_canship);
END;

create or replace TRIGGER TRI_country_4
BEFORE INSERT OR UPDATE OF tw_canship
ON ya_country
FOR EACH ROW
BEGIN
	:NEW.tw_canship := UPPER(:NEW.tw_canship);
END;

create or replace TRIGGER TRI_country_5
BEFORE INSERT OR UPDATE OF us_ws_canship
ON ya_country
FOR EACH ROW
BEGIN
	:NEW.us_ws_canship := UPPER(:NEW.us_ws_canship);
END;

create or replace TRIGGER TRI_country_6
BEFORE INSERT OR UPDATE OF hk_ws_canship
ON ya_country
FOR EACH ROW
BEGIN
	:NEW.hk_ws_canship := UPPER(:NEW.hk_ws_canship);
END;

create or replace TRIGGER TRI_country_7
BEFORE INSERT OR UPDATE OF jp_ws_canship
ON ya_country
FOR EACH ROW
BEGIN
	:NEW.jp_ws_canship := UPPER(:NEW.jp_ws_canship);
END;

create or replace TRIGGER TRI_country_8
BEFORE INSERT OR UPDATE OF tw_ws_canship
ON ya_country
FOR EACH ROW
BEGIN
	:NEW.tw_ws_canship := UPPER(:NEW.tw_ws_canship);
END;