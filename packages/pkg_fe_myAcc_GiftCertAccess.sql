CREATE OR REPLACE PACKAGE PKG_FE_MYACC_GIFTCERT 
AS
  TYPE cur_return IS REF CURSOR;

PROCEDURE GetPurchasedGiftCert
(
  iPShopperId IN Char,
  curPout OUT cur_return
);

PROCEDURE GetReceivedGiftCert
(
  iPShopperId IN Char,
  curPout OUT cur_return
);

END PKG_FE_MYACC_GIFTCERT;
/

CREATE OR REPLACE PACKAGE BODY PKG_FE_MYACC_GIFTCERT IS

PROCEDURE GetPurchasedGiftCert
(
  iPShopperId IN Char,
  curPout OUT cur_return
)
AS 
BEGIN
  OPEN curPout FOR
    SELECT DISTINCT gc.cert_code, gc.cert_amount,
      gc.created_datetime AS created_date,
      gc.send_ecard_datetime as send_ecard_date,
      redemption_datetime AS redeem_date,
      s.email AS purchaser_email,
      CASE
        WHEN gc.send_ecard_datetime IS NULL THEN 'Processing'
        WHEN gc.send_ecard_datetime IS NOT NULL AND gc.cert_used = 'Y' THEN 'Redeemed'
        WHEN gc.send_ecard_datetime IS NOT NULL AND gc.cert_used = 'N' THEN 'Waiting'
      END AS status,
      NVL(rc.email, gc.recipient_email) as recipient_email
  FROM ya_gift_cert gc, 
       ya_shopper s,
       ya_shopper rc,
       order_info oi,
       order_line ol,
       order_line_dtl otd
  WHERE    
    gc.purchaser_shopper_id = iPShopperId
    AND gc.purchaser_shopper_id = s.shopper_id
    AND gc.recipient_shopper_id = rc.shopper_id(+)
    AND oi.origin_order_id = cast(gc.order_num as nvarchar2(100))
    AND oi.id = ol.order_info_id
    AND ol.prod_id = gc.sku
    AND ol.id = otd.order_line_id
    AND otd.sts = 6
    AND gc.bogus <> 'Y'
  ORDER BY created_date ASC;  
    
END GetPurchasedGiftCert;

PROCEDURE GetReceivedGiftCert
(
  iPShopperId IN Char,
  curPout OUT cur_return
)
AS 
BEGIN
  OPEN curPout FOR
    SELECT gc.cert_code, gc.cert_amount,
      gc.created_datetime AS created_date,
      gc.send_ecard_datetime as send_ecard_date,
      redemption_datetime AS redeem_date,
      s.email AS purchaser_email,
      CASE
        WHEN gc.send_ecard_datetime IS NULL THEN 'Processing'
        WHEN gc.send_ecard_datetime IS NOT NULL AND gc.cert_used = 'Y' THEN 'Redeemed'
        WHEN gc.send_ecard_datetime IS NOT NULL AND gc.cert_used = 'N' THEN 'Waiting'
      END AS status,
      rc.email as recipient_email
  FROM ya_gift_cert gc, 
       ya_shopper s,
       ya_shopper rc,
       order_info oi,
       order_line ol,
       order_line_dtl otd
  WHERE
    gc.purchaser_shopper_id = s.shopper_id
    AND rc.shopper_id = iPShopperId
    AND (
          (gc.recipient_shopper_id is null and gc.recipient_email = rc.email)
          OR gc.recipient_shopper_id = iPShopperId
        )
    AND oi.origin_order_id = cast(gc.order_num as nvarchar2(100))
    AND oi.id = ol.order_info_id
    AND ol.prod_id = gc.sku
    AND ol.id = otd.order_line_id
    AND otd.sts = 6
    AND gc.bogus <> 'Y'
  ORDER BY created_date ASC;
    
END GetReceivedGiftCert;

END PKG_FE_MYACC_GIFTCERT;
/