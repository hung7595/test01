DROP TABLE Ya_Associate_Hits_Raw
/

CREATE TABLE Ya_Associate_Hits_Raw (
	hit_datetime               int                      NOT NULL ,
	link_id                    int                      NOT NULL ,
	rowguid                    varchar2(50)             DEFAULT SYS_GUID() NOT NULL
)
/


CREATE UNIQUE INDEX UN_Associate_Hits_Raw ON Ya_Associate_Hits_Raw(rowguid) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Asso_Commission_Type_01 ON Ya_Associate_Hits_Raw(hit_datetime) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Associate_Hits_Raw FOR Ya_Associate_Hits_Raw
/