DROP TABLE Ya_Customer_Profile_Info
/

CREATE TABLE Ya_Customer_Profile_Info (
	shopper_id                 char(32)                  NOT NULL ,
	site_id                    number                    NOT NULL ,
	question_id                number                    NOT NULL ,
	answer_id                  number                    NOT NULL ,
	remark                     nvarchar2(255)
)
/

ALTER TABLE Ya_Customer_Profile_Info
ADD CONSTRAINT PK_Customer_Profile_Info PRIMARY KEY (shopper_id, site_id, answer_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Customer_Profile_Info FOR Ya_Customer_Profile_Info
/