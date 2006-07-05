create or replace package Pkg_fe_CreditAccess
AS
  PROCEDURE GetCurrentBalance (
    deciPbalance OUT NUMBER,
    cPshopperId IN CHAR,
    cPcurrency IN CHAR DEFAULT 'USD'
  );

  PROCEDURE GetCurrentBalanceBySite (
    deciPbalance OUT NUMBER,
    cPshopperId IN CHAR,
    iPsiteId IN NUMBER,
    cPcurrency IN CHAR DEFAULT 'USD'
  );
END Pkg_fe_CreditAccess;
/
create or replace package body Pkg_fe_CreditAccess
IS
  PROCEDURE GetCurrentBalance (
    deciPbalance OUT NUMBER,
    cPshopperId IN CHAR,
    cPcurrency IN CHAR DEFAULT 'USD'
  )
  AS
  BEGIN
    SELECT nvl(SUM(current_balance), 0) INTO deciPbalance
    FROM ya_frontend_credit_system cs
    WHERE cs.shopper_id = cPshopperId
      AND cs.bogus = 'N'
      AND cs.current_balance > 0
      AND cs.currency = cPcurrency;
    
    EXCEPTION when no_data_found THEN
      SELECT NULL INTO deciPbalance FROM dual;
  END GetCurrentBalance;

  PROCEDURE GetCurrentBalanceBySite (
    deciPbalance OUT NUMBER,
    cPshopperId IN CHAR,
    iPsiteId IN NUMBER,
    cPcurrency IN CHAR DEFAULT 'USD'
  )
  AS
  BEGIN
    SELECT nvl(SUM(current_balance), 0) INTO deciPbalance
    FROM ya_frontend_credit_system cs
    WHERE cs.shopper_id = cPshopperId
      AND cs.bogus = 'N'
      AND cs.current_balance > 0
      AND cs.currency = cPcurrency
      AND ((cs.site_id = iPsiteId and cs.site_id not in (1,7)) or (cs.site_id in (1,7) and (iPsiteId = 1 or iPsiteId = 7)));
    
    EXCEPTION when no_data_found THEN
      SELECT NULL INTO deciPbalance FROM dual;
  END GetCurrentBalanceBySite;
END Pkg_fe_CreditAccess;
/