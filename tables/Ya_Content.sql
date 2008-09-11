DROP TABLE Ya_Content
/

CREATE TABLE Ya_Content (
	content_id                       int                     NOT NULL ,
	content_img_loc                  varchar2(200)           ,
	content_img_width                int                     ,
	content_img_height               int                     ,
	content                          clob                    ,
	content_u                        nclob
)
/

ALTER TABLE Ya_Content
ADD CONSTRAINT PK_Content PRIMARY KEY (content_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Content FOR Ya_Content
/