DROP TABLE Ya_Limited_Quantity_Action
/

CREATE TABLE Ya_Limited_Quantity_Action (
	sku                              int                  NOT NULL ,
	site_id                          int                  DEFAULT 1 NOT NULL ,
	action_id                        int                  DEFAULT 1 NOT NULL ,
	action_datetime                  date                 DEFAULT SYSDATE NOT NULL
)
/

ALTER TABLE Ya_Limited_Quantity_Action
ADD CONSTRAINT PK_Limited_Quantity_Action PRIMARY KEY (sku, site_id, action_datetime)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Limited_Quantity_Action FOR Ya_Limited_Quantity_Action
/


CREATE OR REPLACE TRIGGER TrIn_limited_quantity_action
  AFTER INSERT ON ya_limited_quantity_action
  FOR EACH ROW
DECLARE
  iWrite                 NUMBER := 0;
  isku                   NUMBER;
  isite_id               NUMBER;
  iaction_id             NUMBER;
  isold_out_status       NUMBER;
  vsuggestedSystem       varchar2(100) := 'FE_LimitedQuantity';
  inormal_availability   NUMBER := 1;

BEGIN

  IF :new.action_id = 1 OR :new.action_id = 4 OR :new.action_id = 5 OR :new.action_id = 6/* mark soldout */ THEN
	SELECT (CASE WHEN :new.action_id = 1 THEN 60
	             WHEN :new.action_id = 4 THEN 70
	             WHEN :new.action_id = 5 THEN 20
	             WHEN :new.action_id = 6 THEN 30 END) INTO isold_out_status from dual;

	IF :new.site_id = 99 THEN
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,14,1,null,isold_out_status,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,14,4,null,isold_out_status,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,14,7,null,isold_out_status,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,14,8,null,isold_out_status,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,14,10,null,isold_out_status,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,14,11,null,isold_out_status,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,14,12,null,isold_out_status,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,14,13,null,isold_out_status,vsuggestedSystem);
 	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,14,14,null,isold_out_status,vsuggestedSystem);
	ELSE
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,14,:new.site_id,null,isold_out_status,vsuggestedSystem);
	END IF;

  ELSIF :new.action_id = 2 THEN
	IF :new.site_id = 99 THEN
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,2,1,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,3,1,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,4,1,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,2,4,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,3,4,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,4,4,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,2,7,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,3,7,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,4,7,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,2,8,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,3,8,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,4,8,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,2,10,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,3,10,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,4,10,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,2,11,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,3,11,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,4,11,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,2,12,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,3,12,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,4,12,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,2,13,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,3,13,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,4,13,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,2,14,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,3,14,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,4,14,null,null,vsuggestedSystem);
	ELSE
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,2,:new.site_id,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,3,:new.site_id,null,null,vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,4,:new.site_id,null,null,vsuggestedSystem);
	END IF;

  ELSIF :new.action_id = 3 THEN
	IF :new.site_id = 99 THEN
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,11,1,null,'N',vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,11,4,null,'N',vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,11,7,null,'N',vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,11,8,null,'N',vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,11,10,null,'N',vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,11,11,null,'N',vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,11,12,null,'N',vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,11,13,null,'N',vsuggestedSystem);
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,11,14,null,'N',vsuggestedSystem);	  
	ELSE
	  PKG_CATALOG_PROD_UPDT_QUEUE.sp_enqueue_prod_updt_queue(:new.sku,11,:new.site_id,null,'N',vsuggestedSystem);
	END IF;

  END IF;

END;

