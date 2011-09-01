DROP TABLE Jewelfish_User_Grp_Rel
/

CREATE TABLE Jewelfish_User_Grp_Rel (
	id                 int                 NOT NULL ,
	version            int                 NOT NULL ,
	user_group_id      int                 NOT NULL ,
	user_id            int                 NOT NULL
)
/

ALTER TABLE Jewelfish_User_Grp_Rel
ADD CONSTRAINT PK_Jewelfish_User_Grp_Rel PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


ALTER TABLE Jewelfish_User_Grp_Rel
ADD CONSTRAINT FK_Jewelfish_User_Grp_Rel_01 FOREIGN KEY (user_id) REFERENCES Jewelfish_User (id)
/

ALTER TABLE Jewelfish_User_Grp_Rel
ADD CONSTRAINT FK_Jewelfish_User_Grp_Rel_02 FOREIGN KEY (user_group_id) REFERENCES Jewelfish_User_Grp (id)
/

CREATE PUBLIC SYNONYM Jewelfish_User_Grp_Rel FOR Jewelfish_User_Grp_Rel
/