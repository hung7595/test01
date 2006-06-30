CREATE OR REPLACE package Pkg_fe_CreditAccess
AS
  PROCEDURE GetCurrentBalance (
    deciPbalance OUT NUMBER,
    cPshopperId IN CHAR,
    cPcurrency IN CHAR DEFAULT 'USD'
  );
END Pkg_fe_CreditAccess;
/

CREATE OR REPLACE package body Pkg_fe_CreditAccess
IS
  PROCEDURE GetCurrentBalance (
    deciPbalance OUT NUMBER,
    cPshopperId IN CHAR,
    cPcurrency IN CHAR DEFAULT 'USD'
  )
  AS
  BEGIN
    SELECT nvl(SUM(current_balance), 0) INTO deciPbalance
    FROM ya_frontend_credit_system
    WHERE shopper_id = cPshopperId
    AND bogus = 'N'
    AND current_balance > 0
    AND currency = cPcurrency;

    EXCEPTION when no_data_found THEN
      SELECT NULL INTO deciPbalance FROM dual;
  END GetCurrentBalance;
END Pkg_fe_CreditAccess;
/

