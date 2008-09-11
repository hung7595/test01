DROP TABLE Ya_Prod_Video
/

CREATE TABLE Ya_Prod_Video (
	sku                            int                        NOT NULL ,
	duration                       int                        ,
	sample_loc                     varchar2(200)              ,
	audio_format                   varchar2(200)              ,
	video_quality                  varchar2(50)
)
/

ALTER TABLE Ya_Prod_Video
ADD CONSTRAINT PK_Prod_Video PRIMARY KEY (sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Video FOR Ya_Prod_Video
/
