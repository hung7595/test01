Drop Table Ya_Brand_Video
/

CREATE TABLE Ya_Brand_Video (
	id                      int                 NOT NULL ,
	ya_brand_id             int                 NOT NULL ,
	ya_video_id             int                 NOT NULL ,
	created_dt              date                NOT NULL
)
/

ALTER TABLE Ya_Brand_Video
ADD CONSTRAINT PK_Brand_Video PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Brand_Video FOR Ya_Brand_Video
/