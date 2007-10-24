CREATE OR REPLACE PACKAGE PKG_FE_MYACC_STORECREDIT 
AS
  TYPE cur_return IS REF CURSOR;

PROCEDURE GetStoreCreditBalance
(
  iPShopperId IN Char,
  curPout OUT cur_return
);

PROCEDURE GetStoreCreditTxn
(
  iPShopperId IN Char,
  curPout OUT cur_return
);

END PKG_FE_MYACC_STORECREDIT;
/

CREATE OR REPLACE PACKAGE BODY PKG_FE_MYACC_STORECREDIT IS

PROCEDURE GetStoreCreditBalance
(
  iPShopperId IN Char,
  curPout OUT cur_return
)
AS 
BEGIN
  OPEN curPout FOR
    SELECT current_balance,currency FROM ya_frontend_credit_system WHERE shopper_id = iPShopperId ORDER BY currency;
END GetStoreCreditBalance;

PROCEDURE GetStoreCreditTxn
(
  iPShopperId IN Char,
  curPout OUT cur_return
)
AS 
BEGIN
  /* up to the last 10 transaction records */
  OPEN curPout FOR
    SELECT * FROM
      (SELECT yfcs.credit_type_id,yfcstx.credit_amount,yfcstx.debit_amount,yfcstx.debit_ordernum,
              yfcstx.transaction_datetime
       FROM ya_frontend_credit_system yfcs 
       INNER JOIN ya_frontend_credit_system_txn yfcstx
       ON yfcs.credit_id = yfcstx.credit_id
       WHERE yfcs.shopper_id = iPShopperId AND yfcs.credit_type_id <> 4 ORDER BY yfcstx.transaction_datetime DESC)
    WHERE rownum <= 10 ORDER BY transaction_datetime ASC;
END GetStoreCreditTxn;

END PKG_FE_MYACC_STORECREDIT;
/