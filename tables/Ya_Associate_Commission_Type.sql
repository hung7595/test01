DROP TABLE Ya_Associate_Commission_Type
/

CREATE TABLE Ya_Associate_Commission_Type (
	comm_type_id               int                      NOT NULL ,
	nc_min                     int                      NOT NULL ,
	nc_max                     int                      NOT NULL ,
	rowguid                    varchar2(50)             DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Associate_Commission_Type
ADD CONSTRAINT PK_Associate_Commission_Type PRIMARY KEY (comm_type_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Asso_Commission_Type_01 ON Ya_Associate_Commission_Type(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Associate_Commission_Type FOR Ya_Associate_Commission_Type
/