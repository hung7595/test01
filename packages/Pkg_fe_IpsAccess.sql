CREATE OR REPLACE package Pkg_fe_IpsAccess
AS
  TYPE refcur IS ref CURSOR;
  PROCEDURE InsertIpsOrder (
    cPips_order_id	IN 	CHAR,
    cPshopper_id	IN	CHAR,
    iPstatus_id		IN	INT,
    deciPpayable_amt	IN	DECIMAL,
    deciPreceived_amt	IN	DECIMAL,
    cPmsg		IN	NVARCHAR2,
    iPorderNum		IN	INT
  );
  PROCEDURE UpdateIpsOrder (
    cPipsOrderId CHAR,
    cPshopperId CHAR,
    iPstatusId INT,
    deciPreceivedAmt DECIMAL,
    ncPmsg NVARCHAR2,
    iPorderNum int
  );
  PROCEDURE GetIpsOrder (
    cPipsOrderId IN CHAR,
    curPresult OUT refcur
  );
  PROCEDURE RemoveIpsOrder (
    cPipsOrderId CHAR
  );
  PROCEDURE GetIpsUniqueNum (
    iPipsUNum	OUT	int
  );
END Pkg_fe_IpsAccess;
/

CREATE OR REPLACE package body Pkg_fe_IpsAccess
IS
  PROCEDURE InsertIpsOrder (
    cPips_order_id	IN 	CHAR,
    cPshopper_id	IN	CHAR,
    iPstatus_id		IN	INT,
    deciPpayable_amt	IN	DECIMAL,
    deciPreceived_amt	IN	DECIMAL,
    cPmsg		IN	NVARCHAR2,
    iPorderNum		IN	INT
  )
  AS
  BEGIN
    INSERT INTO ya_ips_order
      ( ips_order_id ,
      shopper_id ,
      status_id ,
      payable_amt ,
      received_amt ,
      msg ,
      orderNum ,
      created_datetime ,
      updated_datetime )
    VALUES
      ( cPips_order_id ,
      cPshopper_id ,
      iPstatus_id ,
      deciPpayable_amt ,
      deciPreceived_amt ,
      cPmsg ,
      iPorderNum ,
      (SYSDATE) ,
      (SYSDATE) );
    IF SQLCODE <> 0 THEN
      ROLLBACK;
    END IF;

    COMMIT;
    RETURN;
  END InsertIpsOrder;


  PROCEDURE UpdateIpsOrder (
    cPipsOrderId CHAR,
    cPshopperId CHAR,
    iPstatusId INT,
    deciPreceivedAmt DECIMAL,
    ncPmsg NVARCHAR2,
    iPorderNum int
  )
  AS
    iLtmp INT;
  BEGIN
    SELECT COUNT(1)
    INTO iLtmp
    FROM
      ya_ips_order
    WHERE
      shopper_id = cPshopperId
      AND ips_order_id = cPipsOrderId
      AND ROWNUM = 1;

    IF iLtmp > 0 THEN
      BEGIN
        UPDATE ya_ips_order
        SET
          status_id = iPstatusId
          , received_amt = deciPreceivedAmt
          , msg = ncPmsg
          , orderNum = iPorderNum
          , updated_datetime = SYSDATE
        WHERE
          ips_order_id = cPipsOrderId;

        IF SQLCODE <> 0 THEN
          BEGIN
            ROLLBACK;
            RETURN;
          END;
        END IF;
        COMMIT;
      END;
    ELSE
      BEGIN
        --RETURN -1;
        RETURN;
      END;
    END IF;
  END UpdateIpsOrder;

  PROCEDURE GetIpsOrder (
    cPipsOrderId IN CHAR,
    curPresult OUT refcur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
      ips_order_id,
      shopper_id,
      status_id,
      payable_amt,
      received_amt,
      msg,
      orderNum,
      created_datetime,
      updated_datetime
    FROM
      ya_ips_order
    WHERE
      ips_order_id = cPipsOrderId;
  END GetIpsOrder;

  PROCEDURE RemoveIpsOrder (
    cPipsOrderId CHAR
  )
  AS
  BEGIN
    DELETE FROM ya_ips_order
    WHERE
    ips_order_id = cPipsOrderId;

    IF SQLCODE <> 0 THEN
      ROLLBACK;
      RETURN;
    END IF;
    COMMIT;
  END RemoveIpsOrder;

  PROCEDURE GetIpsUniqueNum (
    iPipsUNum	OUT	INT
  )
  AS
    iLuniqueNum		INT;
    dtLupdated_datetime   DATE;
  BEGIN
    BEGIN
      SELECT uniqueNum, updated_datetime INTO iLuniqueNum, dtLupdated_datetime
      FROM  ya_ips_uniqueNum;

      EXCEPTION WHEN no_data_found THEN
        SELECT NULL, NULL INTO iLuniqueNum, dtLupdated_datetime FROM DUAL;
    END;

    /*
    * if year is difference, reset the number
    */
    IF iLuniqueNum = 999999 or ROUND(MONTHS_BETWEEN((SYSDATE), dtLupdated_datetime)  / 12) != 0
      THEN
      BEGIN
      UPDATE  ya_ips_uniqueNum SET uniqueNum = 1,
        updated_datetime = (SYSDATE)
        WHERE  uniqueNum  = iLuniqueNum;
        IF SQLCODE <> 0 THEN
            ROLLBACK;
            RETURN;
        END IF;
      END;
    ELSE

      BEGIN
      UPDATE  ya_ips_uniqueNum SET uniqueNum = iLuniqueNum + 1,
        updated_datetime = (SYSDATE)
        WHERE uniqueNum = iLuniqueNum;
        IF SQLCODE <> 0 THEN
            ROLLBACK;
            RETURN;
        END IF;
      END;
    END IF;

    SELECT uniqueNum INTO iLuniqueNum FROM ya_ips_uniqueNum;

    COMMIT;

    SELECT iLuniqueNum INTO iPipsUNum FROM SYS.DUAL;

    EXCEPTION
      WHEN TOO_MANY_ROWS THEN
        SELECT uniqueNum, updated_datetime INTO iLuniqueNum, dtLupdated_datetime
          FROM  ya_ips_uniqueNum
          WHERE ROWNUM=1;
  END GetIpsUniqueNum;

END Pkg_fe_IpsAccess;
/

