Drop Table Ya_Brand_Img
/

CREATE TABLE Ya_Brand_Img (
	id                    int                 NOT NULL ,
	ya_brand_id           int                 NOT NULL ,
	type_id               int                 NOT NULL ,
	img_path              varchar2(500)       NOT NULL ,
	created_dt            date                NOT NULL
)
/

ALTER TABLE Ya_Brand_Img
ADD CONSTRAINT PK_Brand_Img PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Brand_Img FOR Ya_Brand_Img
/