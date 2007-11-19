CREATE OR REPLACE PACKAGE PKG_FE_MYACC_COUPON 
AS
  TYPE cur_return IS REF CURSOR;

PROCEDURE GetCouponUser
(
  iPShopperId IN Char,
  curPout OUT cur_return
);

PROCEDURE GetCouponsWithShopperId
(
  iPShopperId IN Char,
  iPSiteId IN INT,
  curPout OUT cur_return
);

PROCEDURE GetCouponsWithCode
(
  iPShopperId IN Char,
  iPCouponCode IN Char,
  curPout OUT cur_return,
  curPout1 OUT cur_return
);

PROCEDURE GetValidCouponByOrder
(
  iPorderNumber IN int,
  cPshopperId IN varchar2,
  curPout1 OUT cur_return
);

PROCEDURE UpdateCouponUsed
(
  cPshopperId IN varchar2,
  cPcouponCode IN Char
);

END PKG_FE_MYACC_COUPON;
/

CREATE OR REPLACE PACKAGE BODY PKG_FE_MYACC_COUPON IS

PROCEDURE GetCouponUser
(
  iPShopperId IN Char,
  curPout OUT cur_return
)
AS 
BEGIN
  OPEN curPout FOR
    SELECT coupon_code FROM ya_coupon_user WHERE shopper_id = iPShopperId;
END GetCouponUser;

PROCEDURE GetCouponsWithShopperId
(
  iPShopperId IN Char,
  iPSiteId IN INT,
  curPout OUT cur_return
)
AS 
BEGIN
  OPEN curPout FOR
	  SELECT c.*
	  FROM ya_coupon c
	  LEFT JOIN ya_coupon_user u ON c.coupon_code = u.coupon_code AND u.shopper_id = iPShopperId
	  WHERE coupon_used <> 'Y'
	  AND c.expiration_date >= SYSDATE
	  AND (
		  c.shopper_id = iPShopperId
		  OR
		  (
			  c.all_shoppers = 'G' AND u.shopper_id is not null AND NOT EXISTS (
				  SELECT 1 FROM order_info o INNER JOIN billing_info b ON o.id = b.order_info_id WHERE b.coupon = u.coupon_code AND o.cust_id = to_nchar(iPShopperId)
			  )
		  )
	  )
	  AND (((site_id = iPSiteId or site_id=99) and iPSiteId not in (10)) or site_id = iPSiteId);
END GetCouponsWithShopperId;

PROCEDURE GetCouponsWithCode
(
  iPShopperId IN Char,
  iPCouponCode IN Char,
  curPout OUT cur_return,
  curPout1 OUT cur_return
)
AS 
BEGIN
  OPEN curPout FOR
	  SELECT c.*
	  FROM ya_coupon c
	  LEFT JOIN ya_coupon_user u ON c.coupon_code = u.coupon_code AND u.shopper_id = iPShopperId
	  WHERE c.coupon_used <> 'Y'
	  AND c.expiration_date >= SYSDATE
	  AND (
		  c.shopper_id = iPShopperId
		  OR
		  (
			  c.all_shoppers = 'G' AND u.shopper_id is not null AND NOT EXISTS (
				  SELECT 1 FROM order_info o INNER JOIN billing_info b ON o.id = b.order_info_id WHERE b.coupon = u.coupon_code AND o.cust_id = to_nchar(iPShopperId)
			  )
		  )
	  )
	  AND c.coupon_code IN (iPCouponCode);
   
  OPEN curPout1 FOR
    SELECT coupon_code, constraint_type, constraint_value
    FROM ya_coupon_constraint
    WHERE coupon_code IN (iPCouponCode)
      AND constraint_type in (1,2,3)
    ORDER BY coupon_code, constraint_type;

END GetCouponsWithCode;

PROCEDURE GetValidCouponByOrder
(
  iPorderNumber IN int,
  cPshopperId IN varchar2,
  curPout1 OUT cur_return
)
AS
  cLoriginOrderId nvarchar2(32);
  cLshopperId nvarchar2(32);
  iLsiteId int;
BEGIN
  cLoriginOrderId := to_char(iPorderNumber);
  cLshopperId := to_char(cPshopperId);
  select origin_id into iLsiteId from order_info where origin_order_id = cLoriginOrderId and cust_id = cLshopperId;
  
  open curPout1 for
	  SELECT c.*
	  FROM ya_coupon c
	  LEFT JOIN ya_coupon_user u ON c.coupon_code = u.coupon_code AND u.shopper_id = to_char(cLshopperId)
	  WHERE coupon_used <> 'Y'
	  AND c.expiration_date >= SYSDATE
	  AND (
		  c.shopper_id = to_char(cLshopperId)
		  OR
		  (
			  c.all_shoppers = 'G' AND u.shopper_id is not null AND NOT EXISTS (
				  SELECT 1 FROM order_info o INNER JOIN billing_info b ON o.id = b.order_info_id WHERE b.coupon = u.coupon_code AND o.cust_id = cLshopperId
			  )
		  )
	  )
	  AND (((site_id = iLsiteId or site_id=99) and iLsiteId not in (10)) or site_id = iLsiteId);
END GetValidCouponByOrder;

PROCEDURE UpdateCouponUsed
(
  cPshopperId IN varchar2,
  cPcouponCode IN Char
)
AS 
BEGIN
	UPDATE ya_coupon
	SET coupon_used = 'Y'
	WHERE
		coupon_code = cPcouponCode
		AND
			(
				(
					shopper_id = cPshopperId
					AND all_shoppers NOT IN ('Y', 'U')
				) -- Y: all shoppers, U: unique
				OR all_shoppers = 'O'
			);  
END UpdateCouponUsed;

END PKG_FE_MYACC_COUPON;
/