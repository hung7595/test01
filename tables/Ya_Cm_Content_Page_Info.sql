DROP TABLE Ya_Cm_Content_Page_Info
/

CREATE TABLE Ya_Cm_Content_Page_Info (
	file_id                           int                      NOT NULL ,
	site_id                           int                      ,
	location                          varchar2(256)            ,
	updated_user                      varchar2(128)            ,
	updated_datetime                  date                     NOT NULL
)
/


ALTER TABLE Ya_Cm_Content_Page_Info
ADD CONSTRAINT PK_Cm_Content_Page_Info PRIMARY KEY (file_id, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Cm_Content_Page_Info FOR Ya_Cm_Content_Page_Info
/