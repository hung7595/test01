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
      gc.recipient_email
  FROM ya_gift_cert gc, 
       ya_shopper s
  WHERE 
    gc.purchaser_shopper_id = iPShopperId
    AND gc.purchaser_shopper_id = s.shopper_id
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
      gc.recipient_email
  FROM ya_gift_cert gc, 
       ya_shopper s
  WHERE 
    gc.purchaser_shopper_id = s.shopper_id
    AND gc.recipient_shopper_id = iPShopperId
  ORDER BY created_date ASC;
    
END GetReceivedGiftCert;

END PKG_FE_MYACC_GIFTCERT;
/