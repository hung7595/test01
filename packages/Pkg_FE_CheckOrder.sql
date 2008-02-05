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
    iLCounter:=iPstartRow+1;
	delete from temp_sku;
	WHILE (iLCounter<=iPendRow)
	LOOP
		select count(*) INTO iLExistValue from ya_order where order_num = iLCounter;
		IF (iLExistValue=0) THEN
			insert into temp_sku values(iLCounter);
		END IF;
		iLCounter:=iLCounter+1;
	END LOOP;

	OPEN curPresult1 FOR	  
		select * from temp_sku order by sku;
	ROLLBACK;
	RETURN;
	
  END GetMissingOrderId;
  
  END Pkg_FE_CheckOrder;

/