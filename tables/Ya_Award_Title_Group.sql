DROP TABLE Ya_Award_Title_Group
/

CREATE TABLE Ya_Award_Title_Group (
	award_title_group_id              int                  NOT NULL ,
	award_title_id                    int                  NOT NULL
)
/

ALTER TABLE Ya_Award_Title_Group
ADD CONSTRAINT PK_Award_Title_Group PRIMARY KEY (award_title_group_id, award_title_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Award_Title_Group FOR Ya_Award_Title_Group
/