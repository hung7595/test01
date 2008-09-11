DROP TABLE Ya_Web_Bookmark
/

CREATE TABLE Ya_Web_Bookmark (
	id                         int                      NOT NULL ,
	name                       varchar2(50)             NOT NULL ,
	url                        varchar2(200)            NOT NULL ,
	icon_id                    varchar2(20)             ,
	is_enabled                 char(1)                  DEFAULT 'Y' NOT NULL ,
	lang_id                    int                      NOT NULL ,
	priority                   int                      NOT NULL
)
/

ALTER TABLE Ya_Web_Bookmark
ADD CONSTRAINT PK_Web_Bookmark PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Web_Bookmark FOR Ya_Web_Bookmark
/