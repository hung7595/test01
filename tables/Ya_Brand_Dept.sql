Drop Table Ya_Brand_Dept
/

CREATE TABLE Ya_Brand_Dept (
	ya_brand_id           int                 NOT NULL ,
	type_id               int                 NOT NULL ,
	dept_id	              int                 NOT NULL ,
	is_highlight          char(1)             NOT NULL ,
	priority              int                 NOT NULL
)
/

ALTER TABLE Ya_Brand_Dept
ADD CONSTRAINT PK_Brand_Banner PRIMARY KEY (ya_brand_id, type_id, dept_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Brand_Dept
ADD CONSTRAINT FK_Brand_Dept_01 FOREIGN KEY (ya_brand_id)
REFERENCES Ya_Brand(id)
/

CREATE PUBLIC SYNONYM Ya_Brand_Dept FOR Ya_Brand_Dept
/