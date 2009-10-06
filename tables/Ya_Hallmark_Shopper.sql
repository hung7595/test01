DROP TABLE Ya_Hallmark_Shopper
/

CREATE TABLE Ya_Hallmark_Shopper (
	ya_shopper_id                char(32)                NOT NULL ,
	hallmark_member_id           varchar2(32)            NULL ,
	create_date                  date                    NOT NULL ,
	hallmark_id                  varchar2(32)            NULL
)
/

ALTER TABLE Ya_Hallmark_Shopper
ADD CONSTRAINT PK_Hallmark_Shopper PRIMARY KEY (ya_shopper_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Hallmark_Shopper FOR Ya_Hallmark_Shopper
/
