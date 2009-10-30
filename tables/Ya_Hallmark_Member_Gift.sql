DROP TABLE Ya_Hallmark_Member_Gift
/

CREATE TABLE Ya_Hallmark_Member_Gift (
	shopper_id            char(32)            NOT NULL ,
	create_date           date                NOT NULL
)
/

ALTER TABLE Ya_Hallmark_Member_Gift
ADD CONSTRAINT PK_Hallmark_Member_Gift PRIMARY KEY (shopper_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Hallmark_Member_Gift FOR Ya_Hallmark_Member_Gift
/
