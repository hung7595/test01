DROP TABLE Ya_Dept
/

CREATE TABLE Ya_Dept (
	dept_id                           int                         NOT NULL ,
	page_location                     varchar2(200)               ,
	artist_page_loc                   varchar2(200)               ,
	us_enabled                        char(1)                     NOT NULL ,
	ys_enabled                        char(1)                     NOT NULL ,
	tw_enabled                        char(1)                     NOT NULL ,
	jp_enabled                        char(1)                     NOT NULL ,
	us_ws_enabled                     char(1)                     NOT NULL ,
	hk_ws_enabled                     char(1)                     NOT NULL ,
	tw_ws_enabled                     char(1)                     NOT NULL ,
	jp_ws_enabled                     char(1)                     NOT NULL ,
	us_disp_seq                       int                         ,
	hk_disp_seq                       int                         ,
	tw_disp_seq                       int                         ,
	jp_disp_seq                       int                         ,
	us_ws_disp_seq                    int                         ,
	hk_ws_disp_seq                    int                         ,
	tw_ws_disp_seq                    int                         ,
	jp_ws_disp_seq                    int                         ,
	created_date                      date                        ,
	updated_date                      date                        ,
	created_user                      varchar2(20)                ,
	updated_user                      varchar2(20)                ,
	root_dept_id                      int                         ,
	is_adult                          char(1)                     DEFAULT 'N' NOT NULL 
)
/

ALTER TABLE Ya_Dept
ADD CONSTRAINT PK_Dept PRIMARY KEY (dept_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Dept_01 ON Ya_Dept(dept_id, tw_enabled) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Dept_02 ON Ya_Dept(dept_id, us_enabled) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Dept FOR Ya_Dept
/


create or replace TRIGGER TRI_dept_1
BEFORE INSERT OR UPDATE OF us_enabled
ON ya_dept
FOR EACH ROW
BEGIN
	:NEW.us_enabled := UPPER(:NEW.us_enabled);
END;

create or replace TRIGGER TRI_dept_2
BEFORE INSERT OR UPDATE OF ys_enabled
ON ya_dept
FOR EACH ROW
BEGIN
	:NEW.ys_enabled := UPPER(:NEW.ys_enabled);
END;

create or replace TRIGGER TRI_dept_3
BEFORE INSERT OR UPDATE OF tw_enabled
ON ya_dept
FOR EACH ROW
BEGIN
	:NEW.tw_enabled := UPPER(:NEW.tw_enabled);
END;

create or replace TRIGGER TRI_dept_4
BEFORE INSERT OR UPDATE OF jp_enabled
ON ya_dept
FOR EACH ROW
BEGIN
	:NEW.jp_enabled := UPPER(:NEW.jp_enabled);
END;

create or replace TRIGGER TRI_dept_5
BEFORE INSERT OR UPDATE OF us_ws_enabled
ON ya_dept
FOR EACH ROW
BEGIN
	:NEW.us_ws_enabled := UPPER(:NEW.us_ws_enabled);
END;

create or replace TRIGGER TRI_dept_6
BEFORE INSERT OR UPDATE OF hk_ws_enabled
ON ya_dept
FOR EACH ROW
BEGIN
	:NEW.hk_ws_enabled := UPPER(:NEW.hk_ws_enabled);
END;

create or replace TRIGGER TRI_dept_7
BEFORE INSERT OR UPDATE OF tw_ws_enabled
ON ya_dept
FOR EACH ROW
BEGIN
	:NEW.tw_ws_enabled := UPPER(:NEW.tw_ws_enabled);
END;

create or replace TRIGGER TRI_dept_8
BEFORE INSERT OR UPDATE OF jp_ws_enabled
ON ya_dept
FOR EACH ROW
BEGIN
	:NEW.jp_ws_enabled := UPPER(:NEW.jp_ws_enabled);
END;