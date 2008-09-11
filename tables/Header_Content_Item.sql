DROP TABLE Header_Content_Item   
/

CREATE TABLE Header_Content_Item (
	id                         number                      NOT NULL ,
	header_content_id          number                      NOT NULL ,
	type                       number                      NOT NULL ,
	item_value                 varchar2(500) 
)
/

ALTER TABLE Header_Content_Item
ADD CONSTRAINT PK_Header_Content_Item PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Header_Content_Item
ADD CONSTRAINT FK_Header_Content_Item_1 FOREIGN KEY (header_content_id)
REFERENCES Header_Content(id)
/


CREATE PUBLIC SYNONYM Header_Content_Item FOR Header_Content_Item
/