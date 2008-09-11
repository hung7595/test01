DROP TABLE Ya_Artist_Dept_Table
/

CREATE TABLE Ya_Artist_Dept_Table (
	lang_id                        number(10)                   NOT NULL ,
	parent_dept_id                 number(10)                   NOT NULL ,
	dept_id                        number(10)                   NOT NULL ,
	artist_id                      number(10)                   NOT NULL ,
	us_display_seq                 number(10)                   ,
	us_ws_display_seq              number(10)                   ,
	hk_display_seq                 number(10)                   ,
	hk_ws_display_seq              number(10)                   ,
	jp_display_seq                 number(10)                   ,
	jp_ws_display_seq              number(10)                   ,
	tw_display_seq                 number(10)                   ,
	tw_ws_display_seq              number(10)                   ,
	dept_name                      varchar2(100)                ,
	dept_path                      varchar2(500)                ,
	page_location                  varchar2(200)                ,
	us_enabled                     char(1)                      ,
	us_ws_enabled                  char(1)                      ,
	jp_enabled                     char(1)                      ,
	jp_ws_enabled                  char(1)                      ,
	tw_enabled                     char(1)                      ,
	tw_ws_enabled                  char(1)                      ,
	hk_enabled                     char(1)                      ,
	hk_ws_enabled                  char(1)
)
/

ALTER TABLE Ya_Artist_Dept_Table
ADD CONSTRAINT PK_Artist_Dept_Table PRIMARY KEY (lang_id, parent_dept_id, dept_id, artist_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Artist_Dept_Table FOR Ya_Artist_Dept_Table
/


create or replace TRIGGER TRI_artist_dept_table_1
BEFORE INSERT OR UPDATE OF us_enabled
ON ya_artist_dept_table
FOR EACH ROW
BEGIN
	:NEW.us_enabled := UPPER(:NEW.us_enabled);
END;

create or replace TRIGGER TRI_artist_dept_table_2
BEFORE INSERT OR UPDATE OF us_ws_enabled
ON ya_artist_dept_table
FOR EACH ROW
BEGIN
	:NEW.us_ws_enabled := UPPER(:NEW.us_ws_enabled);
END;

create or replace TRIGGER TRI_artist_dept_table_3
BEFORE INSERT OR UPDATE OF jp_enabled
ON ya_artist_dept_table
FOR EACH ROW
BEGIN
	:NEW.jp_enabled := UPPER(:NEW.jp_enabled);
END;

create or replace TRIGGER TRI_artist_dept_table_4
BEFORE INSERT OR UPDATE OF jp_ws_enabled
ON ya_artist_dept_table
FOR EACH ROW
BEGIN
	:NEW.jp_ws_enabled := UPPER(:NEW.jp_ws_enabled);
END;

create or replace TRIGGER TRI_artist_dept_table_5
BEFORE INSERT OR UPDATE OF tw_enabled
ON ya_artist_dept_table
FOR EACH ROW
BEGIN
	:NEW.tw_enabled := UPPER(:NEW.tw_enabled);
END;

create or replace TRIGGER TRI_artist_dept_table_6
BEFORE INSERT OR UPDATE OF tw_ws_enabled
ON ya_artist_dept_table
FOR EACH ROW
BEGIN
	:NEW.tw_ws_enabled := UPPER(:NEW.tw_ws_enabled);
END;

create or replace TRIGGER TRI_artist_dept_table_7
BEFORE INSERT OR UPDATE OF hk_enabled
ON ya_artist_dept_table
FOR EACH ROW
BEGIN
	:NEW.hk_enabled := UPPER(:NEW.hk_enabled);
END;

create or replace TRIGGER TRI_artist_dept_table_8
BEFORE INSERT OR UPDATE OF hk_ws_enabled
ON ya_artist_dept_table
FOR EACH ROW
BEGIN
	:NEW.hk_ws_enabled := UPPER(:NEW.hk_ws_enabled);
END;