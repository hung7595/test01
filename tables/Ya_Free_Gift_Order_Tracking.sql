DROP TABLE Ya_Free_Gift_Order_Tracking
/

CREATE TABLE Ya_Free_Gift_Order_Tracking (
	id                     int                NOT NULL , 
	shopper_id             CHAR(32)           NOT NULL , 
	site_id                int                ,
	fe_order_num           int                ,
	free_gift_prod_id      int                ,
	sts                    int                ,
	create_user            varchar2(50)       ,
	create_dt              date               ,
	mod_user               varchar2(50)       ,
	mod_dt                 date
)
/

ALTER TABLE Ya_Free_Gift_Order_Tracking ADD
CONSTRAINT PK_YA_FREE_GIFT_ORDER_TRACK PRIMARY KEY (ID)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Free_Gift_Order_Tracking FOR Ya_Free_Gift_Order_Tracking
/
