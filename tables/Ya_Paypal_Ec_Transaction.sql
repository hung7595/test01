DROP TABLE Ya_Paypal_Ec_Transaction
/

CREATE TABLE Ya_Paypal_Ec_Transaction (
    id                                int               NOT NULL,
    site_id                           int               NOT NULL ,
    shopper_id                        char(32)          NOT NULL ,
    ya_ref_id                         char(32)          ,
    ec_token                          nvarchar2(100)    ,
    ec_payer_id                       nvarchar2(100)    ,
    ec_transaction_id                 nvarchar2(100)    ,
    set_express_checkout_completed    CHAR(1)           NOT NULL ,
    order_num                         int               ,
    create_dt                         date              NOT NULL ,
    mod_dt                            date              NOT NULL
)
/
ALTER TABLE Ya_Paypal_Ec_Transaction
ADD CONSTRAINT PK_Paypal_Ec_Transaction PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Paypal_Ec_Transaction FOR Ya_Paypal_Ec_Transaction
/
