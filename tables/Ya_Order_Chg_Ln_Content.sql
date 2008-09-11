DROP TABLE Ya_Order_Chg_Ln_Content
/

CREATE TABLE Ya_Order_Chg_Ln_Content (
	order_chg_ln_id              int                        NOT NULL ,
	key                          nvarchar2(255)             NOT NULL ,
	content                      nclob                      NOT NULL
)
/

ALTER TABLE Ya_Order_Chg_Ln_Content
ADD CONSTRAINT PK_Order_Chg_Ln_Content PRIMARY KEY (order_chg_ln_id, key)
USING INDEX TABLESPACE SSCommerceserver_Index
/