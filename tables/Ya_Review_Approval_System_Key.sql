DROP TABLE Ya_Review_Approval_System_Key
/

CREATE TABLE Ya_Review_Approval_System_Key (
	review_id                  int                           NOT NULL ,
	rating_id                  int                           NOT NULL ,
	review_key                 nclob                         NOT NULL ,
	date_posted                date                          NOT NULL ,
	created_date               date                          DEFAULT SYSDATE NOT NULL
)	
/

ALTER TABLE Ya_Review_Approval_System_Key
ADD CONSTRAINT PK_Review_Approval_System_Key PRIMARY KEY (review_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Review_Approval_System_Key FOR Ya_Review_Approval_System_Key
/