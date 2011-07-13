DROP TABLE Ya_Checkout_Session_Misc_Dtl
/

CREATE TABLE Ya_Checkout_Session_Misc_Dtl (
    id                      int                ,
    misc_key                nvarchar2(100)     NOT NULL ,
    misc_value              nvarchar2(100)     NOT NULL ,
    checkout_session_id     int                NOT NULL
)
/

ALTER TABLE Ya_Checkout_Session_Misc_Dtl 
ADD CONSTRAINT PK_Checkout_Session_Misc_Dtl PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Checkout_Session_Misc_Dtl
ADD CONSTRAINT Un_Checkout_Session_Misc_Dtl01 unique (misc_key, checkout_session_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Checkout_Session_Misc_Dtl 
ADD CONSTRAINT FK_CHECKOUT_SESSION_MISC_DTL FOREIGN KEY (checkout_session_id) REFERENCES Ya_Checkout_Session(id);


CREATE PUBLIC SYNONYM Ya_Checkout_Session_Misc_Dtl FOR Ya_Checkout_Session_Misc_Dtl
/
