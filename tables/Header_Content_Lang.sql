DROP TABLE Header_Content_Lang   
/

CREATE TABLE Header_Content_Lang (
	id                         number                      NOT NULL ,
	header_content_id          number                      NOT NULL ,
	locale                     varchar2(5)                 NOT NULL ,
	header_text                clob                        ,
	footer_text                clob	
)
/

ALTER TABLE Header_Content_Lang
ADD CONSTRAINT PK_Header_Content_Lang PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


ALTER TABLE Header_Content_Lang
ADD CONSTRAINT FK_Header_Content_Lang_1 FOREIGN KEY (header_content_id)
REFERENCES Header_Content(id)
/


CREATE PUBLIC SYNONYM Header_Content_Lang FOR Header_Content_Lang
/