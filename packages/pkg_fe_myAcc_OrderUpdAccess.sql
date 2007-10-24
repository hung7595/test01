create or replace
PACKAGE PKG_FE_MYACC_ORDERUPDACCESS AS
TYPE cur_return IS REF CURSOR;

PROCEDURE InsertOrderUpdate
(
  cPshopperId IN char,
  iPstatus in int,
  iPorderNumber in int,
  iPpaymentMethod in int,
  cPauthCode in nvarchar2,
  cPavsCode in nvarchar2,
  cPrequestId in nvarchar2,
  cPfirstname in nvarchar2,
  cPlastname in nvarchar2,
  cPemail in nvarchar2,
  cPphone in nvarchar2,
  cPaddress1 in nvarchar2,
  cPaddress2 in nvarchar2,
  cPcity in nvarchar2,
  iPstateCode in int,
  cPstate in nvarchar2,
  cPzip in nvarchar2,
  iPcountry in int,
  iPccType in int,
  cPccNumber in varchar2,
  cPccExpMonth in varchar2,
  cPccExpYear in varchar2,
  cPcouponCode in varchar2,
  deciPcouponAmount in decimal,
  deciPcreditAmount in decimal,
  cPcurrency in varchar2,
  cPccNumberEncrypted in varchar2,
  iPencryptionKey in int,
  deciPauthAmount in decimal
);

PROCEDURE DeleteOrderUpdate
(
  iPorderNumber IN INT,
  cPshopperId IN char
);

PROCEDURE GetOrderUpdate2
(
  iPorderNumber IN INT,
  cPshopperId IN char,
  iPlangId IN INT,
  curPout1 OUT cur_return
);

PROCEDURE GetOrderUpdate
(
  iPorderNumber IN INT,
  cPshopperId IN char,
  curPout1 OUT cur_return
);

PROCEDURE UpdateStatus
(
  iPorderNumber IN INT,
  cPshopperId IN char,
  iPstatus IN INT
);

PROCEDURE UpdateCouponPayment
(
  iPorderNumber IN INT,
  cPshopperId IN char,
  cPcouponCode IN varchar2,
  deciPcouponAmount in decimal
);

PROCEDURE UpdateCreditPayment
(
  iPorderNumber IN INT,
  cPshopperId IN char,
  deciPcreditAmount in decimal
);

PROCEDURE UpdatePaymentMethod
(
  iPorderNumber IN INT,
  cPshopperId IN char,
  cPfirstName IN varchar2,
  cPlastName IN varchar2,
  iPpaymentMethod in int,
  iPcreditCardType in int,
  cPcreditCardNumber in varchar2,
  cPcreditCardExpMonth in varchar2,
  cPcreditCardExpYear in varchar2,
  cPcreditCardNumberEncrypted in varchar2,
  cPencryptionKey in varchar2,
  cPauthCode in nvarchar2,
  deciPauthAmount in decimal
);

PROCEDURE UpdateBillingAddress
(
  iPorderNumber IN INT,
  cPshopperId IN char,
  cPfirstName IN nvarchar2,
  cPlastName IN nvarchar2,
  cPemail IN nvarchar2,
  cPphone IN nvarchar2,
  cPaddress1 IN nvarchar2,
  cPaddress2 IN nvarchar2,
  cPcity IN nvarchar2,
  iPstateCode IN int,
  cPstate IN nvarchar2,
  cPzip IN nvarchar2,
  iPcountry IN int
);

END PKG_FE_MYACC_ORDERUPDACCESS;
/


create or replace
PACKAGE BODY PKG_FE_MYACC_ORDERUPDACCESS AS

PROCEDURE InsertOrderUpdate
(
  cPshopperId IN char,
  iPstatus in int,
  iPorderNumber in int,
  iPpaymentMethod in int,
  cPauthCode in nvarchar2,
  cPavsCode in nvarchar2,
  cPrequestId in nvarchar2,
  cPfirstname in nvarchar2,
  cPlastname in nvarchar2,
  cPemail in nvarchar2,
  cPphone in nvarchar2,
  cPaddress1 in nvarchar2,
  cPaddress2 in nvarchar2,
  cPcity in nvarchar2,
  iPstateCode in int,
  cPstate in nvarchar2,
  cPzip in nvarchar2,
  iPcountry in int,
  iPccType in int,
  cPccNumber in varchar2,
  cPccExpMonth in varchar2,
  cPccExpYear in varchar2,
  cPcouponCode in varchar2,
  deciPcouponAmount in decimal,
  deciPcreditAmount in decimal,
  cPcurrency in varchar2,
  cPccNumberEncrypted in varchar2,
  iPencryptionKey in int,
  deciPauthAmount in decimal
)
AS
  iLpaymentLogId int;
BEGIN
  select SEQ_CUSTOMERUPDATE_PAYMENT_LOG.nextval into iLpaymentLogId from dual;
  insert into ya_customerupdate_payment_log (
    payment_log_id,
    shopper_id,
    status,
    order_id,
    updated_date,
    payment_method,
    auth_code,
    avs_code,
    request_id,
    firstname,
    lastname,
    email,
    phone,
    address1,
    address2,
    city,
    state_code,
    state,
    zip,
    country,
    cc_type,
    cc_number,
    cc_exp_month,
    cc_exp_year,
    coupon_code,
    coupon_amount,
    credit_amount,
    currency,
    rowguid,
    cc_numberencrypted,
    encryptionkey,
    auth_amount)
  values(
    iLpaymentLogId,
    cPshopperId,
    iPstatus,
    iPorderNumber,
    sysdate,
    iPpaymentMethod,
    cPauthCode,
    cPavsCode,
    cPrequestId,
    cPfirstname,
    cPlastname,
    cPemail,
    cPphone,
    cPaddress1,
    cPaddress2,
    cPcity,
    iPstateCode,
    cPstate,
    cPzip,
    iPcountry,
    iPccType,
    cPccNumber,
    cPccExpMonth,
    cPccExpYear,
    cPcouponCode,
    deciPcouponAmount,
    deciPcreditAmount,
    cPcurrency,
    sys_guid(),
    cPccNumberEncrypted,
    iPencryptionKey,
    deciPauthAmount);
  
  IF (SQLCODE=0) THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END InsertOrderUpdate;

PROCEDURE DeleteOrderUpdate
(
  iPorderNumber IN INT,
  cPshopperId IN char
) 
AS
  iLcount int;
BEGIN
  delete from ya_customerupdate_payment_log
  where shopper_id = cPshopperId and order_id = iPorderNumber and status < 0;
END DeleteOrderUpdate;

PROCEDURE GetOrderUpdate2
(
  iPorderNumber IN INT,
  cPshopperId IN char,
  iPlangId IN INT,
  curPout1 OUT cur_return
) 
AS
  iLcount int;
BEGIN
  open curPout1 for
  select * from (
    select * from ya_customerupdate_payment_log cp left outer join lookup lu on cp.country = lu.code and lu.lang_type = iPlangId and lu.category = 'country'
    where shopper_id = cPshopperId and order_id = iPorderNumber and status in (1,-1)
    order by status desc
  ) where rownum = 1;
END GetOrderUpdate2;

PROCEDURE GetOrderUpdate
(
  iPorderNumber IN INT,
  cPshopperId IN char,
  curPout1 OUT cur_return
) 
AS
  iLcount int;
BEGIN
  open curPout1 for
  select * from (
    select * from ya_customerupdate_payment_log cp
    where shopper_id = cPshopperId and order_id = iPorderNumber and status in (1,-1)
    order by status desc
  ) where rownum = 1;
END GetOrderUpdate;

PROCEDURE UpdateStatus
(
  iPorderNumber IN INT,
  cPshopperId IN char,
  iPstatus IN INT
)
AS
  iLcount int;
BEGIN
  update ya_customerupdate_payment_log set status = iPstatus
  where shopper_id = cPshopperId and order_id = iPorderNumber and status < 0;
END UpdateStatus;

PROCEDURE UpdateCouponPayment
(
  iPorderNumber IN INT,
  cPshopperId IN char,
  cPcouponCode IN varchar2,
  deciPcouponAmount in decimal
) 
AS
BEGIN
  update ya_customerupdate_payment_log
  set 
    coupon_code = cPcouponCode,
    coupon_amount = deciPcouponAmount,
    updated_date = sysdate
  where shopper_id = cPshopperId and order_id = iPorderNumber;
  
  IF (SQLCODE=0) THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END UpdateCouponPayment;

PROCEDURE UpdateCreditPayment
(
  iPorderNumber IN INT,
  cPshopperId IN char,
  deciPcreditAmount in decimal
) 
AS
BEGIN
  update ya_customerupdate_payment_log
  set 
    credit_amount = deciPcreditAmount,
    updated_date = sysdate
  where shopper_id = cPshopperId and order_id = iPorderNumber;
  
  IF (SQLCODE=0) THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END UpdateCreditPayment;

PROCEDURE UpdatePaymentMethod
(
  iPorderNumber IN INT,
  cPshopperId IN char,
  cPfirstName IN varchar2,
  cPlastName IN varchar2,
  iPpaymentMethod in int,
  iPcreditCardType in int,
  cPcreditCardNumber in varchar2,
  cPcreditCardExpMonth in varchar2,
  cPcreditCardExpYear in varchar2,
  cPcreditCardNumberEncrypted in varchar2,
  cPencryptionKey in varchar2,
  cPauthCode in nvarchar2,
  deciPauthAmount in decimal
) 
AS
BEGIN
  update ya_customerupdate_payment_log
  set 
    firstname = cPfirstName,
    lastname = cPlastName,
    payment_method = iPpaymentMethod,
    cc_type = iPcreditCardType,
    cc_number = cPcreditCardNumber,
    cc_exp_month = cPcreditCardExpMonth,
    cc_exp_year = cPcreditCardExpYear,
    cc_numberencrypted = cPcreditCardNumberEncrypted,
    encryptionkey = cPencryptionKey,
    auth_code = cPauthCode,
    auth_amount = deciPauthAmount,
    updated_date = sysdate
  where shopper_id = cPshopperId and order_id = iPorderNumber;
  
  IF (SQLCODE=0) THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END UpdatePaymentMethod;

PROCEDURE UpdateBillingAddress
(
  iPorderNumber IN INT,
  cPshopperId IN char,
  cPfirstName IN nvarchar2,
  cPlastName IN nvarchar2,
  cPemail IN nvarchar2,
  cPphone IN nvarchar2,
  cPaddress1 IN nvarchar2,
  cPaddress2 IN nvarchar2,
  cPcity IN nvarchar2,
  iPstateCode IN int,
  cPstate IN nvarchar2,
  cPzip IN nvarchar2,
  iPcountry IN int
) 
AS
BEGIN
  update ya_customerupdate_payment_log
  set 
    firstname = cPfirstname,
    lastname = cPlastname,
    email = cPemail,
    phone = cPphone,
    address1 = cPaddress1,
    address2 = cPaddress2,
    city = cPcity,
    state_code = iPstateCode,
    state = cPstate,
    zip = cPzip,
    country = iPcountry,
    updated_date = sysdate
  where shopper_id = cPshopperId and order_id = iPorderNumber;
  
  IF (SQLCODE=0) THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END UpdateBillingAddress;

END PKG_FE_MYACC_ORDERUPDACCESS;
/

