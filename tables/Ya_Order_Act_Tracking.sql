DROP TABLE Ya_Order_Act_Tracking
/

CREATE TABLE Ya_Order_Act_Tracking (
    id             int              ,
    order_num      int              NOT NULL ,
    sku            int              NOT NULL ,
    quantity       int              NOT NULL ,
    campaign_code  int              NOT NULL ,
    status         int              NOT NULL
);

ALTER TABLE Ya_Order_Act_Tracking
ADD CONSTRAINT PK_Ya_Order_Act_Tracking PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index;


CREATE PUBLIC SYNONYM Ya_Order_Act_Tracking FOR Ya_Order_Act_Tracking
/