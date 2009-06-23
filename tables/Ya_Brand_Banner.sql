Drop Table Ya_Brand_Banner
/

CREATE TABLE Ya_Brand_Banner (
	id                    int                 NOT NULL ,
	ya_brand_id           int                 NOT NULL ,
	img_path              varchar2(500)       NOT NULL ,
	lang_id               int                 ,
	site_id               int                 ,
	dept_id	              int                 ,
	created_dt            date                NOT NULL
)
/

ALTER TABLE Ya_Brand_Banner
ADD CONSTRAINT PK_Brand_Banner PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Brand_Banner FOR Ya_Brand_Banner
/