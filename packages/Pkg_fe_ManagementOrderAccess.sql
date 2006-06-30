CREATE OR REPLACE package Pkg_fe_ManagementOrderAccess
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

CREATE OR REPLACE package body Pkg_fe_ManagementOrderAccess
IS
  PROCEDURE GetOrderXML (
    curPorder OUT curGorder
  )
  AS
  BEGIN
    OPEN curPorder FOR
    SELECT order_num, created_datetime, site_id,  order_xml
    FROM ya_order
    WHERE TO_CHAR(order_num) NOT IN (
      SELECT originOrderId
      FROM OrderInfo
      WHERE id <> 62036
      and originOrderId not like 'ESD%'
      and originOrderId not like 'TOWER%'
      and originOrderId not like 'SS%'
      and originOrderId not like 'BB%'
      and originOrderId not like 'HMV%'
    )
    and (
      (order_num > 1141720 AND site_id = 7)
      OR (order_num > 1141710 AND site_id = 3)
      OR (order_num > 1142106 AND site_id = 1)
    )
    ORDER BY order_num;
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
  BEGIN
    INSERT INTO ya_frontend_credit_system
    ( credit_id, site_id, shopper_id, credit_code, credit_type_id, initial_balance, current_balance, currency, transaction_datetime, bogus, rowguid )
    VALUES (iPcredit_id, iPsite_id, cPshopper_id, cPcredit_code, 2, nPamount, nPamount, cPcurrency, SYSDATE, 'N', SYS_GUID());

    INSERT INTO ya_frontend_credit_system_txn
    ( credit_id, credit_ordernum, credit_amount, snapshot_balance )
    VALUES (iPcredit_id, iPorder_num, nPamount, nPamount);

    --COMMIT;
  END RefundStoredCredit;
END Pkg_fe_ManagementOrderAccess;
/

