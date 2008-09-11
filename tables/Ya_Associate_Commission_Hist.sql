DROP TABLE Ya_Associate_Commission_Hist
/

CREATE TABLE Ya_Associate_Commission_Hist (
	associate_id                 int                       NOT NULL ,
	valid_date                   date                      NOT NULL ,
	comm_rate                    number(18,4)              ,
	payment_option               int                       NOT NULL ,
	rowguid                      varchar2(50)              DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Associate_Commission_Hist
ADD CONSTRAINT PK_Associate_Commission_Hist PRIMARY KEY (associate_id, valid_date)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Asso_Commission_Hist_01 ON Ya_Associate_Commission_Hist(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Associate_Commission_Hist FOR Ya_Associate_Commission_Hist
/