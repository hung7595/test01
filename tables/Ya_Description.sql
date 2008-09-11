DROP TABLE Ya_Description
/

CREATE TABLE Ya_Description (
	description_id                   int                            NOT NULL ,
	description                      clob                           ,
	desc_img_loc                     varchar2(200)                  ,
	desc_img_width                   int                            ,
	desc_img_height                  int                            ,
	short_description                varchar2(500)                  ,
	updated_date                     date
)
/

ALTER TABLE Ya_Description
ADD CONSTRAINT PK_Description PRIMARY KEY (description_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Description_01 ON Ya_Description(description_id, CASE WHEN DESCRIPTION IS NOT NULL THEN 'Y' ELSE 'N' END) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Description FOR Ya_Description
/