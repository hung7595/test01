DROP TABLE Ya_Review_Share_Group
/

CREATE TABLE Ya_Review_Share_Group (
	group_id                         int                           NOT NULL ,
	sku                              int                           NOT NULL
)	
/

ALTER TABLE Ya_Review_Share_Group
ADD CONSTRAINT PK_Review_Share_Group PRIMARY KEY (sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Review_Share_Group_01 ON Ya_Review_Share_Group(group_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Review_Share_Group FOR Ya_Review_Share_Group
/


create or replace TRIGGER TRAL_ya_review_share_group
AFTER INSERT OR UPDATE OR DELETE
ON ya_review_share_group
FOR EACH ROW
BEGIN

   INSERT INTO ya_se_sku_update
   SELECT seq_se_sku_update.nextval, a.* FROM
   (
     SELECT :new.sku SKU, 'YA_REVIEW_SHARE_GROUP', sysdate FROM DUAL
          UNION
     SELECT :old.sku SKU, 'YA_REVIEW_SHARE_GROUP', sysdate FROM DUAL) a
   WHERE SKU IS NOT NULL;

END;