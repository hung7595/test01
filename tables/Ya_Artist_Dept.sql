DROP TABLE Ya_Artist_Dept
/

CREATE TABLE Ya_Artist_Dept (
	article_id                 number(10)                NOT NULL ,
	dept_id                    number(10)                NOT NULL ,
	us_enabled                 char(1)                   NOT NULL ,
	hk_enabled                 char(1)                   NOT NULL ,
	jp_enabled                 char(1)                   NOT NULL ,
	tw_enabled                 char(1)                   NOT NULL ,
	us_ws_enabled              char(1)                   NOT NULL ,
	hk_ws_enabled              char(1)                   NOT NULL ,
	jp_ws_enabled              char(1)                   NOT NULL ,
	tw_ws_enabled	           char(1)                   NOT NULL
)
/

ALTER TABLE Ya_Artist_Dept
ADD CONSTRAINT PK_Artist_Dept PRIMARY KEY (article_id, dept_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Artist_Dept_01 ON Ya_Artist_Dept(dept_id, us_enabled, artist_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Artist_Dept_02 ON Ya_Artist_Dept(dept_id, tw_enabled, artist_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Artist_Dept FOR Ya_Artist_Dept
/


create or replace TRIGGER TRI_artist_dept_1
BEFORE INSERT OR UPDATE OF us_enabled
ON ya_artist_dept
FOR EACH ROW
BEGIN
	:NEW.us_enabled := UPPER(:NEW.us_enabled);
END;

create or replace TRIGGER TRI_artist_dept_2
BEFORE INSERT OR UPDATE OF hk_enabled
ON ya_artist_dept
FOR EACH ROW
BEGIN
	:NEW.hk_enabled := UPPER(:NEW.hk_enabled);
END;

create or replace TRIGGER TRI_artist_dept_3
BEFORE INSERT OR UPDATE OF jp_enabled
ON ya_artist_dept
FOR EACH ROW
BEGIN
	:NEW.jp_enabled := UPPER(:NEW.jp_enabled);
END;

create or replace TRIGGER TRI_artist_dept_4
BEFORE INSERT OR UPDATE OF tw_enabled
ON ya_artist_dept
FOR EACH ROW
BEGIN
	:NEW.tw_enabled := UPPER(:NEW.tw_enabled);
END;

create or replace TRIGGER TRI_artist_dept_5
BEFORE INSERT OR UPDATE OF us_ws_enabled
ON ya_artist_dept
FOR EACH ROW
BEGIN
	:NEW.us_ws_enabled := UPPER(:NEW.us_ws_enabled);
END;

create or replace TRIGGER TRI_artist_dept_6
BEFORE INSERT OR UPDATE OF hk_ws_enabled
ON ya_artist_dept
FOR EACH ROW
BEGIN
	:NEW.hk_ws_enabled := UPPER(:NEW.hk_ws_enabled);
END;

create or replace TRIGGER TRI_artist_dept_7
BEFORE INSERT OR UPDATE OF jp_ws_enabled
ON ya_artist_dept
FOR EACH ROW
BEGIN
	:NEW.jp_ws_enabled := UPPER(:NEW.jp_ws_enabled);
END;

create or replace TRIGGER TRI_artist_dept_8
BEFORE INSERT OR UPDATE OF tw_ws_enabled
ON ya_artist_dept
FOR EACH ROW
BEGIN
	:NEW.tw_ws_enabled := UPPER(:NEW.tw_ws_enabled);
END;