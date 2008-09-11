DROP TABLE Ya_Review_Helpful
/

CREATE TABLE Ya_Review_Helpful (
	shopper_id                    nvarchar2(100)                 NOT NULL ,
	review_id                     int                            NOT NULL ,
	review_helpful                char(1)                        NOT NULL ,
	rowguid                       char(50)                       DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Review_Helpful
ADD CONSTRAINT PK_Review_Helpful PRIMARY KEY (shopper_id, review_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Review_Helpful_01 ON Ya_Review_Helpful(review_id, review_helpful) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Review_Helpful FOR Ya_Review_Helpful
/


create or replace TRIGGER TRI_review_helpful
BEFORE INSERT OR UPDATE OF review_helpful
ON ya_review_helpful
FOR EACH ROW
BEGIN
	:NEW.review_helpful := UPPER(:NEW.review_helpful);
END;