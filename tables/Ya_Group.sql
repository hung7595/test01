DROP TABLE Ya_Group
/

CREATE TABLE Ya_Group (
	division_id                    int                        NOT NULL ,
	group_name                     varchar2(50)               NOT NULL ,
	account_id                     int                        NOT NULL ,
	group_id                       int                        NOT NULL ,
	enabled                        varchar2(5)
)
/

ALTER TABLE Ya_Group
ADD CONSTRAINT PK_Group PRIMARY KEY (division_id, account_id, group_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Group FOR Ya_Group
/