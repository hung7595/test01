DROP TABLE Header_Content   
/

CREATE TABLE Header_Content (
	id                         number                      NOT NULL ,
	enabled                    varchar2(1)                 ,
	comments                   varchar2(200)               ,
	update_date                date                        ,
	update_user                varchar2(50)
)
/

ALTER TABLE Header_Content
ADD CONSTRAINT PK_Header_Content PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Header_Content FOR Header_Content
/