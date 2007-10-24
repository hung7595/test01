CREATE OR REPLACE
PACKAGE PKG_FE_MYACC_CREDITACCESS AS
TYPE cur_return IS REF CURSOR;

PROCEDURE GetOrderUpdate
(
  cPshopperId IN char,
  deciPbalance OUT decimal
);

END PKG_FE_MYACC_CREDITACCESS;
/

CREATE OR REPLACE
PACKAGE BODY PKG_FE_MYACC_CREDITACCESS AS

PROCEDURE GetOrderUpdate
(
  cPshopperId IN char,
  deciPbalance OUT decimal
) 
AS
BEGIN
  select sum(current_balance) into deciPbalance from ya_frontend_credit_system where shopper_id = cPshopperId group by shopper_id;
END GetOrderUpdate;

END PKG_FE_MYACC_CREDITACCESS;
/