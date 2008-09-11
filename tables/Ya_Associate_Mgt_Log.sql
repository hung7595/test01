DROP TABLE Ya_Associate_Mgt_Log
/

CREATE TABLE Ya_Associate_Mgt_Log (
	id                        int                     NOT NULL ,
	ts                        date                    NOT NULL ,
	message                   varchar2(4000)          NOT NULL
)
/

ALTER TABLE Ya_Associate_Mgt_Log
ADD CONSTRAINT PK_Associate_Mgt_Log PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Associate_Mgt_Log FOR Ya_Associate_Mgt_Log
/