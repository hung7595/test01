DROP TABLE Ya_Hallmark_Shopper
/

CREATE TABLE Ya_Hallmark_Shopper (
	hallmark_member_id           varchar(32)             NOT NULL ,
	ya_shopper_id                char(32)                NOT NULL
)
/

ALTER TABLE Ya_Hallmark_Shopper
ADD CONSTRAINT PK_Hallmark_Shopper PRIMARY KEY (hallmark_member_id, ya_shopper_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Hallmark_Shopper FOR Ya_Hallmark_Shopper
/
