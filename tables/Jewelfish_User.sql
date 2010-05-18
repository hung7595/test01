DROP TABLE Jewelfish_User
/

CREATE TABLE Jewelfish_User (
	id                 int                 NOT NULL ,
	version            int                 NOT NULL ,
	login_name         varchar2(30)        NOT NULL ,
	password           varchar2(10)        NOT NULL ,
	is_enabled         char(1)             NOT NULL ,
	email              varchar2(255)       NOT NULL
)
/

ALTER TABLE Jewelfish_User
ADD CONSTRAINT PK_Jewelfish_User PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Jewelfish_User
ADD CONSTRAINT Un_Jewelfish_User_01 unique (login_name)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Jewelfish_User FOR Jewelfish_User
/