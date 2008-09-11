DROP TABLE Ya_Review_Action_Log
/

CREATE TABLE Ya_Review_Action_Log (
	rating_id                      int                             NOT NULL ,
	action_type                    varchar2(50)                    NOT NULL ,
	remark                         clob                            ,
	updated_datetime               date                            NOT NULL ,
	review                         char(1)                         DEFAULT 'N' NOT NULL
)	
/

ALTER TABLE Ya_Review_Action_Log
ADD CONSTRAINT PK_Review_Action_Log PRIMARY KEY (rating_id, updated_datetime)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Review_Action_Log FOR Ya_Review_Action_Log
/