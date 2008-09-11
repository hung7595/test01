DROP TABLE Ya_Associate_Commission
/

CREATE TABLE Ya_Associate_Commission (
	commission_id                int                       NOT NULL ,
	commission_desc              varchar2(100)             ,
	created_date                 date                      ,
	updated_date                 date                      ,
	created_by                   varchar2(100)             ,
	updated_by                   varchar2(100)             ,
	rowguid                      varchar2(50)              DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Associate_Commission
ADD CONSTRAINT PK_Associate_Commission PRIMARY KEY (commission_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Associate_Commission_01 ON Ya_Associate_Commission(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Associate_Commission FOR Ya_Associate_Commission
/