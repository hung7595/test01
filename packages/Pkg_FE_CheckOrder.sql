CREATE OR REPLACE PACKAGE PKG_FE_CHECKORDER AS

  TYPE refCur IS REF CURSOR;
  PROCEDURE GetMissingOrderId (
  iPstartRow in int,
  iPendRow in int,
  curPresult1 out refCur
  );
  PROCEDURE GetMissingOrderId2 (
  curPresult1 out refCur
  );

END PKG_FE_CHECKORDER;

/


CREATE OR REPLACE PACKAGE BODY PKG_FE_CHECKORDER AS

  PROCEDURE GetMissingOrderId (
  iPstartRow in int,
  iPendRow in int,
  curPresult1 out refCur
  )
  AS  
    iLCounter int;
    iLOrderId int;
    iLExistValue int;
	
  BEGIN
	delete from temp_order_id;
    iLCounter:=iPstartRow+1;
	delete from temp_sku;
	WHILE (iLCounter<=iPendRow)
	LOOP
		select count(*) INTO iLExistValue from ya_order where order_num = iLCounter;
		IF (iLExistValue=0) THEN
			insert into temp_order_id (order_id) values(iLCounter);
		END IF;
		iLCounter:=iLCounter+1;
	END LOOP;

    IF sqlcode = 0 THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	
	OPEN curPresult1 FOR	  
		select * from temp_order_id order by order_id;
	RETURN;
	
  END GetMissingOrderId;  
  
  PROCEDURE GetMissingOrderId2 (
  curPresult1 out refCur
  )
  AS  
    iLCounter int;
    iLstartRow int;
    iLendRow int;
    iLOrderId int;
    iLExistValue int;
	
  BEGIN
	delete from temp_order_id;
        
        select max(order_num) into iLendRow from ya_order;
        select min(order_num) into iLstartRow from ya_order where created_datetime >= to_date(TO_CHAR(SYSDATE - 7, 'YYYYMMDD'),'YYYYMMDD');
        
    iLCounter:=iLstartRow;
	delete from temp_sku;
        IF iLstartRow>0 AND iLendRow>0 THEN
          WHILE (iLCounter<=iLendRow)
          LOOP
		select count(*) INTO iLExistValue from ya_order where order_num = iLCounter;
		IF (iLExistValue=0) THEN
			insert into temp_order_id (order_id) values(iLCounter);
		END IF;
		iLCounter:=iLCounter+1;
          END LOOP;
        END IF;
        

    IF sqlcode = 0 THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	
	OPEN curPresult1 FOR	  
		select * from temp_order_id order by order_id;
	RETURN;
	
  END GetMissingOrderId2;  

END PKG_FE_CHECKORDER;

/
