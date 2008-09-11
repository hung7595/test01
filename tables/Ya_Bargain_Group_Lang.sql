DROP TABLE Ya_Bargain_Group_Lang
/

CREATE TABLE Ya_Bargain_Group_Lang (
	group_id                   int                     NOT NULL ,
	lang_id                    int                     NOT NULL ,
	group_name_u               nvarchar2(20)           NOT NULL
)
/

ALTER TABLE Ya_Bargain_Group_Lang
ADD CONSTRAINT PK_Bargain_Group_Lang PRIMARY KEY (group_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Bargain_Group_Lang FOR Ya_Bargain_Group_Lang
/