DROP TABLE Ya_Content_Filename
/

CREATE TABLE Ya_Content_Filename (
	id                 int                      NOT NULL ,
	path               nvarchar2(255)
)
/

ALTER TABLE Ya_Content_Filename
ADD CONSTRAINT PK_Content_Filename PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_CONTENT_FILENAME_01 ON Ya_Content_Filename(LOWER(path)) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Content_Filename FOR Ya_Content_Filename
/
