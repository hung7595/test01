DROP TABLE Ya_Associate_Legacy_History
/

CREATE TABLE Ya_Associate_Legacy_History (
	link_id                   int                    NOT NULL ,
	total_credit              number(18,2)           NOT NULL ,
	total_credit_paid         number(18,2)           NOT NULL ,
	rowguid                   varchar2(50)           DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Associate_Legacy_History
ADD CONSTRAINT PK_Associate_Legacy_History PRIMARY KEY (link_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Associate_Legacy_History FOR Ya_Associate_Legacy_History
/