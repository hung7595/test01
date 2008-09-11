DROP TABLE Ya_Survey_Record_Detail
/

CREATE TABLE Ya_Survey_Record_Detail (
	record_id                char(32)                   NOT NULL ,
	code                     int                        NOT NULL ,
	remark                   clob                       ,
	rowguid                  varchar2(50)               DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Survey_Record_Detail
ADD CONSTRAINT PK_Survey_Record_Detail PRIMARY KEY (record_id, code)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Survey_Record_Detail_01 ON Ya_Survey_Record_Detail(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Survey_Record_Detail FOR Ya_Survey_Record_Detail
/