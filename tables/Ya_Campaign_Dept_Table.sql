DROP TABLE Ya_Campaign_Dept_Table
/

CREATE TABLE Ya_Campaign_Dept_Table (
	lang_id                          int                        NOT NULL ,
	parent_dept_id                   int                        NOT NULL ,
	dept_id                          int                        NOT NULL ,
	us_display_seq                   int                        ,
	us_ws_display_seq                int                        ,
	hk_display_seq                   int                        ,
	hk_ws_display_seq                int                        ,
	jp_display_seq                   int                        ,
	jp_ws_display_seq                int                        ,
	tw_display_seq                   int                        ,
	tw_ws_display_seq                int                        ,
	dept_name                        varchar2(500)              ,
	dept_path                        varchar2(500)              ,
	page_location                    varchar2(200)              ,
	us_enabled                       char(1)                    ,
	us_ws_enabled                    char(1)                    ,
	jp_enabled                       char(1)                    ,
	jp_ws_enabled                    char(1)                    ,
	tw_enabled                       char(1)                    ,
	tw_ws_enabled                    char(1)                    ,
	hk_enabled                       char(1)                    ,
	hk_ws_enabled                    char(1)                    ,
	campaign_code                    int                        NOT NULL
)
/


ALTER TABLE Ya_Campaign_Dept_Table
ADD CONSTRAINT PK_Campaign_Dept_Table PRIMARY KEY (lang_id, parent_dept_id, dept_id, campaign_code)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Campaign_Dept_Table FOR Ya_Campaign_Dept_Table
/


create or replace TRIGGER TRI_campaign_dept_table_1
BEFORE INSERT OR UPDATE OF us_enabled
ON ya_campaign_dept_table
FOR EACH ROW
BEGIN
	:NEW.us_enabled := UPPER(:NEW.us_enabled);
END;

create or replace TRIGGER TRI_campaign_dept_table_2
BEFORE INSERT OR UPDATE OF us_ws_enabled
ON ya_campaign_dept_table
FOR EACH ROW
BEGIN
	:NEW.us_ws_enabled := UPPER(:NEW.us_ws_enabled);
END;

create or replace TRIGGER TRI_campaign_dept_table_3
BEFORE INSERT OR UPDATE OF jp_enabled
ON ya_campaign_dept_table
FOR EACH ROW
BEGIN
	:NEW.jp_enabled := UPPER(:NEW.jp_enabled);
END;

create or replace TRIGGER TRI_campaign_dept_table_4
BEFORE INSERT OR UPDATE OF jp_ws_enabled
ON ya_campaign_dept_table
FOR EACH ROW
BEGIN
	:NEW.jp_ws_enabled := UPPER(:NEW.jp_ws_enabled);
END;

create or replace TRIGGER TRI_campaign_dept_table_5
BEFORE INSERT OR UPDATE OF tw_enabled
ON ya_campaign_dept_table
FOR EACH ROW
BEGIN
	:NEW.tw_enabled := UPPER(:NEW.tw_enabled);
END;

create or replace TRIGGER TRI_campaign_dept_table_6
BEFORE INSERT OR UPDATE OF tw_ws_enabled
ON ya_campaign_dept_table
FOR EACH ROW
BEGIN
	:NEW.tw_ws_enabled := UPPER(:NEW.tw_ws_enabled);
END;

create or replace TRIGGER TRI_campaign_dept_table_7
BEFORE INSERT OR UPDATE OF hk_enabled
ON ya_campaign_dept_table
FOR EACH ROW
BEGIN
	:NEW.hk_enabled := UPPER(:NEW.hk_enabled);
END;

create or replace TRIGGER TRI_campaign_dept_table_8
BEFORE INSERT OR UPDATE OF hk_ws_enabled
ON ya_campaign_dept_table
FOR EACH ROW
BEGIN
	:NEW.hk_ws_enabled := UPPER(:NEW.hk_ws_enabled);
END;