CREATE TABLE Ya_Globalcollect_Order_Log (
    id                      int             NOT NULL, 
    globalcollect_order_id  int             NOT NULL,
    type                    int             NOT NULL,
    api_command             varchar2(50)    NOT NULL,
    content                 clob            ,
    create_user             varchar2(50)    NOT NULL,
    create_dt               date            NOT NULL
)
/

ALTER TABLE Ya_Globalcollect_Order_Log ADD
CONSTRAINT PK_Ya_Globalcollect_Order_Log PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Globalcollect_Order_Log_01 ON Ya_Globalcollect_Order_Log(globalcollect_order_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Globalcollect_Order_Log FOR Ya_Globalcollect_Order_Log
/
