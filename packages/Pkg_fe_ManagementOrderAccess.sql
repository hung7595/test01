
REM START SS_ADM PKG_FE_MANAGEMENTORDERACCESS

  CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_FE_MANAGEMENTORDERACCESS" 
As
  TYPE curGorder IS REF CURSOR;
  PROCEDURE GetOrderXML (
    curPorder OUT curGorder
  );

  PROCEDURE RefundStoredCredit (
    iPcredit_id IN INT,
    iPsite_id IN INT,
    iPorder_num IN INT,
    cPshopper_id IN VARCHAR2,
    cPcredit_code IN VARCHAR2,
    nPamount IN NUMBER,
    cPcurrency IN VARCHAR2
  );
END Pkg_fe_ManagementOrderAccess;
/








CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_FE_MANAGEMENTORDERACCESS" 
IS
  PROCEDURE GetOrderXML (
    curPorder OUT curGorder
  )
  AS
  BEGIN
    OPEN curPorder FOR
/*    
    SELECT order_num, created_datetime, site_id,  order_xml
    FROM ya_order
    WHERE TO_CHAR(order_num) NOT IN (
      SELECT origin_order_id
      FROM order_info
      WHERE id <> 62036
      and origin_order_id not like 'ESD%'
      and origin_order_id not like 'TOWER%'
      and origin_order_id not like 'SS%'
      and origin_order_id not like 'BB%'
      and origin_order_id not like 'HMV%'
    )
    and (
      (order_num > 1141720 AND site_id = 7)
      OR (order_num > 1141710 AND site_id = 3)
      OR (order_num > 1142106 AND site_id = 1)
    )
    ORDER BY order_num;
	SELECT Y.ORDER_NUM, Y.CREATED_DATETIME, Y.SITE_ID, Y.ORDER_XML 
	FROM 
	YA_ORDER Y
	LEFT OUTER JOIN 
	( SELECT ORIGIN_ORDER_ID 
	  FROM ORDER_INFO 
	  WHERE ID <> 62036 
	  AND ORIGIN_ORDER_ID NOT LIKE 'ESD%' 
	  AND ORIGIN_ORDER_ID NOT LIKE 'TOWER%' 
	  AND ORIGIN_ORDER_ID NOT LIKE 'SS%' 
	  AND ORIGIN_ORDER_ID NOT LIKE 'BB%' 
	  AND ORIGIN_ORDER_ID NOT LIKE 'HMV%' ) o
	ON TO_CHAR(ORDER_NUM) = O.ORIGIN_ORDER_ID  
	WHERE O.ORIGIN_ORDER_ID IS NULL
	AND ( 
          (ORDER_NUM > 1141720 AND SITE_ID = 7) 
       OR (ORDER_NUM > 1141710 AND SITE_ID = 3) 
       OR (ORDER_NUM > 1142106 AND SITE_ID = 1))
    ORDER BY order_num;   
*/

	SELECT Y.ORDER_NUM, Y.CREATED_DATETIME, Y.SITE_ID, Y.ORDER_XML 
	FROM  YA_ORDER Y 
        LEFT OUTER JOIN ORDER_INFO O ON TO_CHAR(ORDER_NUM) = O.ORIGIN_ORDER_ID
        WHERE O.ORIGIN_ORDER_ID IS NULL
          AND ORDER_NUM > 4500000;
          
  END GetOrderXML;

  PROCEDURE RefundStoredCredit (
    iPcredit_id IN INT,
    iPsite_id IN INT,
    iPorder_num IN INT,
    cPshopper_id IN VARCHAR2,
    cPcredit_code IN VARCHAR2,
    nPamount IN NUMBER,
    cPcurrency IN VARCHAR2
  )
  AS
    iLseq_currval INT;
    iLseq_diff INT;
    iLseq_actual INT;
  BEGIN
    IF iPcredit_id IS NULL OR iPcredit_id < 0 THEN
      SELECT SEQ_FRONTEND_CREDIT_SYSTEM.NEXTVAL INTO iLseq_actual FROM DUAL;
    ELSE
      iLseq_actual := iPcredit_id;
      SELECT SEQ_FRONTEND_CREDIT_SYSTEM.NEXTVAL INTO iLseq_currval FROM DUAL;
      iLseq_diff := iPcredit_id - iLseq_currval;
      IF iLseq_diff <> 0 THEN
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_FRONTEND_CREDIT_SYSTEM INCREMENT BY ' || iLseq_diff;
        SELECT SEQ_FRONTEND_CREDIT_SYSTEM.NEXTVAL INTO iLseq_currval FROM DUAL;
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_FRONTEND_CREDIT_SYSTEM INCREMENT BY 1';
      END IF;
    END IF;

    INSERT INTO ya_frontend_credit_system
    ( credit_id, site_id, shopper_id, credit_code, credit_type_id, initial_balance, current_balance, currency, transaction_datetime, bogus, rowguid )
    VALUES (iLseq_actual, iPsite_id, cPshopper_id, cPcredit_code, 2, nPamount, nPamount, cPcurrency, SYSDATE, 'N', SYS_GUID());

    INSERT INTO ya_frontend_credit_system_txn
    ( credit_id, credit_ordernum, credit_amount, snapshot_balance )
    VALUES (iLseq_actual, iPorder_num, nPamount, nPamount);

    --COMMIT;
  END RefundStoredCredit;
END Pkg_fe_ManagementOrderAccess;
/
 
REM END SS_ADM PKG_FE_MANAGEMENTORDERACCESS
