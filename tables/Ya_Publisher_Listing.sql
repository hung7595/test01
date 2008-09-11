DROP TABLE Ya_Publisher_Listing
/

CREATE TABLE Ya_Publisher_Listing (
	publisher_id                int                          NOT NULL ,
	section_id                  int                          NOT NULL ,
	icon_type                   int                          ,        
	priority                    int                          NOT NULL ,
	enabled                     char(1)                      DEFAULT 'Y' NOT NULL ,
	status                      int                          NOT NULL ,
	updated_date                date                         NOT NULL ,
	updated_user                varchar2(20)                 NOT NULL ,
	show                        char(1)                      DEFAULT 'Y'
)	
/

ALTER TABLE Ya_Publisher_Listing
ADD CONSTRAINT PK_Publisher_Listing PRIMARY KEY (publisher_id, section_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Publisher_Listing FOR Ya_Publisher_Listing
/