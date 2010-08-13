DROP TABLE Ya_Globalcollect_Shopper
/

CREATE TABLE Ya_Globalcollect_Shopper (
    id int NOT NULL , 
    shopper_id CHAR(32) NOT NULL 
)
/

ALTER TABLE Ya_Globalcollect_Shopper ADD
CONSTRAINT PK_Globalcollect_Shopper PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Globalcollect_Shopper ADD
CONSTRAINT UN_Globalcollect_Shopper_01 UNIQUE (shopper_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Globalcollect_Shopper FOR Ya_Globalcollect_Shopper
/