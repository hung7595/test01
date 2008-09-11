DROP TABLE Ya_Associate_Commission_Detail
/

CREATE TABLE Ya_Associate_Commission_Detail (
	commission_id                int                       NOT NULL ,
	comm_type_id                 int                       NOT NULL ,
	payment_option               int                       NOT NULL ,
	percentage                   number(18,4)              ,
	rowguid                      varchar2(50)              DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Associate_Commission_Detail
ADD CONSTRAINT PK_Associate_Commission_Detail PRIMARY KEY (commission_id, comm_type_id, payment_option)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Asso_Commission_Detail_01 ON Ya_Associate_Commission_Detail(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Associate_Commission_Detail FOR Ya_Associate_Commission_Detail
/