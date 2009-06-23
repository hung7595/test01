Drop Table Ya_Brand_Link
/

CREATE TABLE Ya_Brand_Link (
	id                        int                 NOT NULL ,
	ya_brand_id               int                 NOT NULL ,
	lang_id                   int                 NOT NULL ,
	url                       varchar2(500)       NOT NULL ,
	description               varchar2(500)       ,        
	created_dt                date                NOT NULL
)
/

ALTER TABLE Ya_Brand_Link
ADD CONSTRAINT PK_Brand_Link PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Brand_Link
ADD CONSTRAINT FK_Brand_Link_01 FOREIGN KEY (ya_brand_id)
REFERENCES Ya_Brand(id)
/


CREATE PUBLIC SYNONYM Ya_Brand_Link FOR Ya_Brand_Link
/