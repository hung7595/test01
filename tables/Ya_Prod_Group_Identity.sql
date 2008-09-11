DROP TABLE Ya_Prod_Group_Identity
/

CREATE TABLE Ya_Prod_Group_Identity (
	group_circle_id              int                     NOT NULL ,
	guid                         varchar2(32)            NOT NULL
)
/

ALTER TABLE Ya_Prod_Group_Identity
ADD CONSTRAINT PK_Prod_Group_Identity PRIMARY KEY (group_circle_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Group_Identity FOR Ya_Prod_Group_Identity
/