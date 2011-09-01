DROP TABLE Jewelfish_User_Grp
/

CREATE TABLE Jewelfish_User_Grp (
	id                 int                 NOT NULL ,
	version            int                 NOT NULL ,
	name               varchar2(300)        NOT NULL
)
/

ALTER TABLE Jewelfish_User_Grp
ADD CONSTRAINT PK_Jewelfish_User_Grp PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Jewelfish_User_Grp FOR Jewelfish_User_Grp
/