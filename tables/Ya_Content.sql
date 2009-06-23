DROP TABLE Ya_Content
/

CREATE TABLE Ya_Content (
	content_id          int                NOT NULL ,
	sku                 int                NOT NULL ,
	lang_id             int                NOT NULL ,
	content             clob

)
/

ALTER TABLE Ya_Content
ADD CONSTRAINT PK_Content PRIMARY KEY (content_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Content_01 on Ya_Content (sku, lang_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Content FOR Ya_Content
/