CREATE OR REPLACE PACKAGE Pkg_FE_CheckOrder
AS
  TYPE refCur IS REF CURSOR;
  PROCEDURE GetMissingOrderId (
  iPstartRow in int,
  iPendRow in int,
  curPresult1 out refCur
  );
  END Pkg_FE_CheckOrder;
  /

  CREATE OR REPLACE PACKAGE BODY Pkg_FE_CheckOrder
  IS
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
	DELETE FROM temp_order_id;
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
END Pkg_FE_CheckOrder;

/