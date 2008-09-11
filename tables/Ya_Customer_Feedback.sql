DROP TABLE Ya_Customer_Feedback
/

CREATE TABLE Ya_Customer_Feedback (
	shopper_id                char(32)                ,
	question_id               int                     NOT NULL ,
	site_id                   int                     NOT NULL ,
	answer                    varchar2(500)           NOT NULL
	datetime                  date                    DEFAULT SYSDATE NOT NULL ,
	unique_key                varchar2(50)            DEFAULT SYS_GUID()
)
/

ALTER TABLE Ya_Customer_Feedback
ADD CONSTRAINT PK_Customer_Feedback PRIMARY KEY (unique_key)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Customer_Feedback FOR Ya_Customer_Feedback
/