DROP TABLE Ya_Artist_Image_Button_Log
/

CREATE TABLE Ya_Artist_Image_Button_Log (
	log_id                     int                        NOT NULL ,
	dept_id                    int                        NOT NULL ,
	artist_id                  int                        NOT NULL ,
	start_date                 date                       ,
	end_date                   date                       ,
	active                     int                        NOT NULL
)
/

ALTER TABLE Ya_Artist_Image_Button_Log
ADD CONSTRAINT PK_Artist_Image_Button_Log PRIMARY KEY (log_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Artist_Image_Button_Log FOR Ya_Artist_Image_Button_Log
/