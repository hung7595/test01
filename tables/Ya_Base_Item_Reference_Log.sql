DROP TABLE Ya_Base_Item_Reference_Log
/

CREATE TABLE Ya_Base_Item_Reference_Log (
	server_id                         varchar2(20)            NOT NULL ,
	table_name                        varchar2(50)            NOT NULL ,
	last_updated_date                 date
)          
/


ALTER TABLE Ya_Base_Item_Reference_Log
ADD CONSTRAINT PK_Base_Item_Reference_Log PRIMARY KEY (server_id, table_name)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Base_Item_Reference_Log FOR Ya_Base_Item_Reference_Log
/