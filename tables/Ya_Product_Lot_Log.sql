DROP TABLE Ya_Product_Lot_Log
/

CREATE TABLE Ya_Product_Lot_Log (
	log_id               int                  NOT NULL ,
	file_id              int                  NOT NULL ,
	lot_loc              int                  NOT NULL ,
	sku                  int                  ,
	start_date           date                 ,
	end_date             date                 ,
	active               int                  NOT NULL
)
/

ALTER TABLE Ya_Product_Lot_Log
ADD CONSTRAINT PK_Product_Lot_Log PRIMARY KEY (log_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Lot_Log FOR Ya_Product_Lot_Log
/

create or replace TRIGGER tr_ya_product_lot_update
  AFTER INSERT OR UPDATE ON ya_product_lot
    FOR EACH ROW

    BEGIN
      UPDATE ya_product_lot_log 
           SET active=0, end_date=sysdate
           WHERE file_id = :new.file_id AND lot_loc =:new.lot_location AND active=1;
      
           INSERT INTO ya_product_lot_log(log_id,file_id, lot_loc, sku, start_date, active)
           VALUES (seq_ya_product_lot_log.nextval,:new.file_id, :new.lot_location, :new.sku, sysdate, 1);
    END;
/

create or replace TRIGGER tr_ya_product_lot_delete
  AFTER DELETE ON ya_product_lot
    FOR EACH ROW
    BEGIN
      
          UPDATE ya_product_lot_log
          SET active=0, end_date=sysdate
          WHERE file_id = :old.file_id  AND lot_loc =:old.lot_location AND sku =:old.sku AND active=1;

    END;
/