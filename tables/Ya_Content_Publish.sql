DROP TABLE Ya_Content_Publish
/

CREATE TABLE Ya_Content_Publish (
	file_id            int                      NOT NULL ,
	publish_flag       char(1)                  ,
	update_dt          date
)
/

ALTER TABLE Ya_Content_Publish
ADD CONSTRAINT PK_Content_Publish PRIMARY KEY (file_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Content_Publish FOR Ya_Content_Publish
/