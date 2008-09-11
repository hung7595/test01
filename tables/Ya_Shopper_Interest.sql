DROP TABLE Ya_Shopper_Interest
/

CREATE TABLE Ya_Shopper_Interest (
	shopper_id                   varchar2(32)               NOT NULL ,
	question_id                  int                        NOT NULL ,
	answer_id                    int                        NOT NULL ,
	rowguid                      varchar2(50)               DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Shopper_Interest
ADD CONSTRAINT PK_Shopper_Interest PRIMARY KEY (shopper_id, question_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Shopper_Interest_01 ON Ya_Shopper_Interest(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Shopper_Interest FOR Ya_Shopper_Interest
/