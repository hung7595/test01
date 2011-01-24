Drop Table Ya_Brand_Attr
/

CREATE TABLE Ya_Brand_Attr (
    ya_brand_id INT NOT NULL,
    attr_id INT NOT NULL
)
/

ALTER TABLE Ya_Brand_Attr
ADD CONSTRAINT PK_Brand_Attr PRIMARY KEY (ya_brand_id, attr_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Brand_Attr
ADD CONSTRAINT FK_Brand_Attr_01 FOREIGN KEY (ya_brand_id)
REFERENCES Ya_Brand(id)
/


CREATE PUBLIC SYNONYM Ya_Brand_Attr FOR Ya_Brand_Attr
/
