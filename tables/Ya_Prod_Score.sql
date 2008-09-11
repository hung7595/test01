DROP TABLE Ya_Prod_Score
/

CREATE TABLE Ya_Prod_Score (
	sku                                           int                           NOT NULL ,
	siteid                                        int                           NOT NULL ,
	classification                                int                           ,
	classification_override                       int                           ,
	classification_override_by                    varchar2(50)                  ,
	classification_override_start                 date                          ,
	classification_override_end                   date                          ,
	rank                                          number(18,2)                  ,
	rank_override                                 number(18,2)                  ,
	rank_override_by                              varchar2(50)                  ,
	rank_override_start                           date                          ,
	rank_override_end                             date                          ,
	sales_quantity_sum                            int                           ,
	focus_group                                   int                           ,
	focus_group_override                          int                           ,
	focus_group_override_by                       varchar2(50)                  ,
	focus_group_override_start                    date                          ,
	focus_group_override_end                      date                          ,
	recommendation                                int                           ,
	recommendation_override                       int                           ,
	recommendation_override_by                    varchar2(50)                  ,
	recommendation_override_start                 date                          ,
	recommendation_override_end                   date                          ,
	lastupdatedate                                date	
)
/

ALTER TABLE Ya_Prod_Score
ADD CONSTRAINT PK_Prod_Score PRIMARY KEY (sku, siteid)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Prod_Score_01 ON Ya_Prod_Score(lastupdatedate) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Score FOR Ya_Prod_Score
/


create or replace TRIGGER TRAL_ya_prod_score
AFTER INSERT OR UPDATE OR DELETE OF rank, sales_quantity_sum, siteId
ON ya_prod_score
FOR EACH ROW
BEGIN

   INSERT INTO ya_se_sku_update
   SELECT seq_se_sku_update.nextval, a.* FROM
   (
     SELECT :new.sku SKU, 'YA_PROD_SCORE', sysdate FROM DUAL
          UNION
     SELECT :old.sku SKU, 'YA_PROD_SCORE', sysdate FROM DUAL) a
   WHERE SKU IS NOT NULL;

END;