DROP TABLE Ya_Publisher_Group
/

CREATE TABLE Ya_Publisher_Group (
	publisher_group_id               int                      NOT NULL ,
	update_datetime                  date                     NOT NULL
)	
/

ALTER TABLE Ya_Publisher_Group
ADD CONSTRAINT PK_Publisher_Group PRIMARY KEY (publisher_group_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Publisher_Group FOR Ya_Publisher_Group
/