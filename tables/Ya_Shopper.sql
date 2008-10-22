DROP TABLE Ya_Shopper
/

CREATE TABLE Ya_Shopper (
	shopper_id                          char(32)                    NOT NULL ,
	created_date                        date                        ,
	password                            varchar2(255)               ,
	email                               varchar2(255)               NOT NULL
	firstname                           varchar2(60)                ,        
	lastname                            varchar2(100)               ,        
	username                            varchar2(100)               ,        
	nickname                            varchar2(50)                ,        
	member_type                         int                         DEFAULT 1 ,        
	credit_accumulated                  number(18,2)                DEFAULT 0 ,        
	preferred_lang_id                   int                         DEFAULT 1 ,        
	secret_question                     varchar2(100)               ,        
	secret_answer                       varchar2(100)               ,        
	income_level                        int                         DEFAULT 0 ,        
	education_level                     int                         DEFAULT 0 ,        
	shopper_occupation                  int                         DEFAULT 0 ,        
	dob                                 date                        ,        
	ethnicity                           int                         ,        
	credit_rating                       int                         DEFAULT 1 ,        
	anonymous                           char(1)                     DEFAULT 'N' ,        
	salt                                varchar2(20)                ,        
	ae_id                               int                         ,        
	rowguid                             varchar2(50)                DEFAULT SYS_GUID() NOT NULL ,
	correspondence_email	            varchar2(25   5)
)	
/

ALTER TABLE Ya_Shopper
ADD CONSTRAINT PK_Shopper PRIMARY KEY (shopper_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Shopper_01 ON Ya_Shopper(username, shopper_id, member_type, password, nickname, firstname, lastname, anonymous) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Shopper_02 ON Ya_Shopper(rowguid) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Shopper_03 ON Ya_Shopper(created_date, anonymous) TABLESPACE SSCommerceserver_Index
/

CREATE UNIQUE INDEX IX_Shopper_04 ON Ya_Shopper(LOWER(email)) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Shopper_05 ON Ya_Shopper(LOWER(username)) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Shopper_06 ON Ya_Shopper(UPPER(email)) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Shopper_07 ON Ya_Shopper(email) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX ix_shopper_08 on ya_shopper (
case when anonymous = 'N' and member_type = 1 
and created_date >= TO_DATE('21-01-2002 15:42:34', 'DD-MM-YYYY HH24:MI:SS') then shopper_id else null end, shopper_id)
/


CREATE PUBLIC SYNONYM Ya_Shopper FOR Ya_Shopper
/


create or replace TRIGGER TRI_shopper
BEFORE INSERT OR UPDATE OF anonymous
ON ya_shopper
FOR EACH ROW
BEGIN
	:NEW.anonymous := UPPER(:NEW.anonymous);
END;