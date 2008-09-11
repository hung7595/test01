DROP TABLE Ya_Search_Keyword_Log
/

CREATE TABLE Ya_Search_Keyword_Log (
	unique_id                      varchar2(50)              DEFAULT SYS_GUID() NOT NULL ,
	site_id                        int                       NOT NULL ,
	shopper_id                     char(32)                  ,
	search_section                 varchar2(50)              ,
	keyword                        nvarchar2(512)            NOT NULL ,
	search_datetime                date                      DEFAULT SYSDATE NOT NULL	
)	
/

ALTER TABLE Ya_Search_Keyword_Log
ADD CONSTRAINT PK_Search_Keyword_Log PRIMARY KEY (unique_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Search_Keyword_Log FOR Ya_Search_Keyword_Log
/