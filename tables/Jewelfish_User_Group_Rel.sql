DROP TABLE Jewelfish_User_Group_Rel
/

CREATE TABLE Jewelfish_User_Group_Rel (
	id                 int                 NOT NULL ,
	version            int                 NOT NULL ,
	user_group_id      int                 NOT NULL ,
	user_id            int                 NOT NULL
)
/

ALTER TABLE Jewelfish_User_Group_Rel
ADD CONSTRAINT PK_Jewelfish_User_Group_Rel PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Jewelfish_User_Group_Rel FOR Jewelfish_User_Group_Rel
/