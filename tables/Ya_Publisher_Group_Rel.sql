DROP TABLE Ya_Publisher_Group_Rel
/

CREATE TABLE Ya_Publisher_Group_Rel (
	publisher_group_id               int                          NOT NULL ,
	publisher_id                     int                          NOT NULL ,
	update_datetime                  date                         NOT NULL
)	
/

ALTER TABLE Ya_Publisher_Group_Rel
ADD CONSTRAINT PK_Publisher_Group_Rel PRIMARY KEY (publisher_group_id, publisher_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Publisher_Group_Rel FOR Ya_Publisher_Group_Rel
/