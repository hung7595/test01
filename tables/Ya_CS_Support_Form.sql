DROP TABLE Ya_CS_Support_Form
/

CREATE TABLE Ya_CS_Support_Form (
	email                          varchar2(50)                   NOT NULL ,
	order_num_str                  varchar2(100)                  NOT NULL ,
	subject                        varchar2(100)                  ,
	comment                        varchar2(4000)                 ,
	request_datetime               date                           DEFAULT SYSDATE NOT NULL ,
	id                             varchar2(50)                   DEFAULT SYS_GUID() NOT NULL ,
	status                         varchar2(10)                   DEFAULT 'NewArrival' NOT NULL ,
	in_charge                      varchar2(50)                   DEFAULT 'Admin' NOT NULL	
)
/

ALTER TABLE Ya_CS_Support_Form
ADD CONSTRAINT PK_CS_Support_Form PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_CS_Support_Form_01 ON Ya_CS_Support_Form(email) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_CS_Support_Form_02 ON Ya_CS_Support_Form(order_num_str) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_CS_Support_Form FOR Ya_CS_Support_Form
/