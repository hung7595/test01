DROP TABLE Static_Content
/

CREATE TABLE Static_Content (
	id                               number                    NOT NULL ,
	content_type                     number                    NOT NULL ,
	entry_type                       number                    NOT NULL ,
	img_url                          varchar2(100)             ,
	version                          number                    NOT NULL ,
	update_date                      date                      NOT NULL ,
	update_user                      varchar2(50)              NOT NULL ,
	display_date                     date                      NOT NULL ,
	enabled                          varchar2(1)               ,
	publish_start_date               date                      ,
	publish_end_date                 date                      ,
	priority                         number                    DEFAULT 0 NOT NULL
)
/

ALTER TABLE Static_Content
ADD CONSTRAINT PK_Static_Content PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Static_Content FOR Static_Content
/