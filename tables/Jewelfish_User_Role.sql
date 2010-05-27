DROP TABLE Jewelfish_User_Role
/

CREATE TABLE Jewelfish_User_Role (
	id                 int            NOT NULL ,
	version            int            NOT NULL ,
	user_id            int            NOT NULL ,
	role_id            int            NOT NULL 
)
/

ALTER TABLE Jewelfish_User_Role
ADD CONSTRAINT PK_Jewelfish_User_Role PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Jewelfish_User_Role
ADD CONSTRAINT Fk_Jewelfish_User_Role_01 FOREIGN KEY (user_id) REFERENCES Jewelfish_User (id)
/

CREATE UNIQUE INDEX UN_Jewelfish_User_Role_01 ON Jewelfish_User_Role(user_id, role_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Jewelfish_User_Role FOR Jewelfish_User_Role
/