CREATE OR REPLACE package Pkg_fe_CustomerUpdateAccess
AS
  TYPE refCur IS REF CURSOR;

	PROCEDURE GetPendingRequest (
    curPresult OUT refCur
  );

	PROCEDURE IsPendingRequest (
		iPorder_id		IN INT,
    iPresult			IN OUT INT
  );

  PROCEDURE InsertPendingRequest (
		iPayment_log_id			IN INT,
    cPshopper_id        IN CHAR,
    iPstatus		IN INT,
    iPorder_id		IN INT,
    dPupdated_date	IN DATE,
    iPpayment_method	IN INT,
    nvcPauth_code	IN NVARCHAR2,
    nvcPavs_code	IN NVARCHAR2,
    nvcPrequest_id	IN NVARCHAR2,
    nvcPfirstname	IN NVARCHAR2,
    nvcPlastname	IN NVARCHAR2,
    nvcPemail		IN NVARCHAR2,
    nvcPphone		IN NVARCHAR2,
    nvcPaddress1	IN NVARCHAR2,
    nvcPaddress2	IN NVARCHAR2,
    nvcPcity		IN NVARCHAR2,
    iPstate_code	IN INT,
    nvcPstate		IN NVARCHAR2,
    nvcPzip		IN NVARCHAR2,
    iPcountry		IN INT,
    iPcc_type		IN INT,
    cPcc_number		IN CHAR,
    cPcc_exp_month	IN CHAR,
    cPcc_exp_year	IN CHAR,
    cPcoupon_code	IN CHAR,
    iPcoupon_amount	IN NUMBER,
    iPcredit_amount	IN NUMBER,
    cPcurrency		IN CHAR,
    cPcc_numberEncrypted	IN CHAR,
    iPencryption_key		IN INT,

    iPlog_id		IN OUT INT
  );

  PROCEDURE UpdateCoupon(
    cPshopper_id        IN CHAR,
    cPcoupon_code	IN CHAR
  );

  PROCEDURE UpdatePendingRequestStatus (
    iPpayment_log_id	IN INT,
    iPstatus		IN INT
  );

	PROCEDURE GetOrderAmount (
		dPamount OUT NUMBER,
		iPorder_id IN NVARCHAR2
	);

	PROCEDURE GetPaidAmount (
		dPpaid_amount OUT NUMBER,
		iPorder_id IN NVARCHAR2
	);

	PROCEDURE GetOrderStatus (
		iPstatus OUT NUMBER,
		iPorder_id IN NVARCHAR2
	);

	PROCEDURE IsOrderPaid (
		iPorder_id IN NVARCHAR2,
    iPresult	 IN OUT INT
	);

END Pkg_FE_CustomerUpdateAccess;
/

CREATE OR REPLACE package body Pkg_FE_CustomerUpdateAccess
is
  PROCEDURE GetPendingRequest (
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT
		payment_log_id, shopper_id, status, order_id, updated_date, payment_method,
		auth_code, avs_code, request_id, firstname, lastname, email, phone,
		address1, address2, city, state_code, state, zip, country,
		cc_type, cc_number, cc_exp_month, cc_exp_year,
		coupon_code, coupon_amount, credit_amount, currency,
		cc_numberencrypted, encryptionkey
    FROM ya_customerupdate_payment_log
    WHERE status = 1;
    RETURN;
  END GetPendingRequest;

	PROCEDURE IsPendingRequest (
		iPorder_id		IN INT,
    iPresult			IN OUT INT
  )
	AS
  BEGIN
	  SELECT nvl(sum(1), 0) INTO iPresult FROM ya_customerupdate_payment_log WHERE order_id = iPorder_id AND status = 1;
		IF (iPresult > 0) THEN
			iPresult := 1;
		ELSE
			iPresult := 0;
		END IF;
	END IsPendingRequest;

  PROCEDURE InsertPendingRequest (
		iPayment_log_id			IN INT,
    cPshopper_id        IN CHAR,
    iPstatus		IN INT,
    iPorder_id		IN INT,
    dPupdated_date	IN DATE,
    iPpayment_method	IN INT,
    nvcPauth_code	IN NVARCHAR2,
    nvcPavs_code	IN NVARCHAR2,
    nvcPrequest_id	IN NVARCHAR2,
    nvcPfirstname	IN NVARCHAR2,
    nvcPlastname	IN NVARCHAR2,
    nvcPemail		IN NVARCHAR2,
    nvcPphone		IN NVARCHAR2,
    nvcPaddress1	IN NVARCHAR2,
    nvcPaddress2	IN NVARCHAR2,
    nvcPcity		IN NVARCHAR2,
    iPstate_code	IN INT,
    nvcPstate		IN NVARCHAR2,
    nvcPzip		IN NVARCHAR2,
    iPcountry		IN INT,
    iPcc_type		IN INT,
    cPcc_number		IN CHAR,
    cPcc_exp_month	IN CHAR,
    cPcc_exp_year	IN CHAR,
    cPcoupon_code	IN CHAR,
    iPcoupon_amount	IN NUMBER,
    iPcredit_amount	IN NUMBER,
		cPcurrency		IN CHAR,
    cPcc_numberEncrypted	IN CHAR,
    iPencryption_key		IN INT,

		iPlog_id		IN OUT INT
  )
  AS
    iLseq_currval INT;
    iLseq_diff INT;
  BEGIN
    IF iPlog_id IS NULL OR iPlog_id < 0 THEN
      SELECT SEQ_customerupdate_payment_log.nextval INTO iPlog_id FROM DUAL;
    ELSE
      SELECT SEQ_order.nextval INTO iLseq_currval FROM DUAL;
      iLseq_diff := iPlog_id - iLseq_currval;
      IF iLseq_diff <> 0 THEN
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_customerupdate_payment_log INCREMENT BY ' || iLseq_diff;
        SELECT SEQ_order.nextval INTO iLseq_currval FROM dual;
        EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_customerupdate_payment_log INCREMENT BY 1';
      END IF;
    END IF;

    INSERT INTO ya_customerupdate_payment_log(
        payment_log_id, shopper_id, status, order_id, updated_date, payment_method,
				auth_code, avs_code, request_id, firstname, lastname, email, phone,
        address1, address2, city, state_code, state, zip, country,
        cc_type, cc_number, cc_exp_month, cc_exp_year,
				coupon_code, coupon_amount, credit_amount, currency, 
				cc_numberencrypted, encryptionkey

    )VALUES(
        iPayment_log_id, cPshopper_id, iPstatus, iPorder_id, dPupdated_date, iPpayment_method,
				nvcPauth_code, nvcPavs_code, nvcPrequest_id, nvcPfirstname, nvcPlastname, nvcPemail, nvcPphone,
        nvcPaddress1, nvcPaddress2, nvcPcity, iPstate_code, nvcPstate, nvcPzip, iPcountry,
        iPcc_type, cPcc_number, cPcc_exp_month, cPcc_exp_year,
        cPcoupon_code, iPcoupon_amount, iPcredit_amount, cPcurrency,
        cPcc_numberEncrypted, iPencryption_key
    );
  END InsertPendingRequest;

  PROCEDURE UpdateCoupon (
    cPshopper_id        IN CHAR,
    cPcoupon_code	IN CHAR
  )
  AS
  BEGIN
		UPDATE ya_coupon
		SET coupon_used = 'Y'
		WHERE
			coupon_code = cPcoupon_code
			AND
				(
					(
						shopper_id = cPshopper_id
						AND all_shoppers NOT IN ('Y', 'U')
					) -- Y: all shoppers, U: unique
					OR all_shoppers = 'O'
				);
  END UpdateCoupon;

  PROCEDURE UpdatePendingRequestStatus (
    iPpayment_log_id	IN INT,
    iPstatus		IN INT
  )
  AS
  BEGIN
		update ya_customerupdate_payment_log set status = iPstatus where payment_log_id = iPpayment_log_id;
  END UpdatePendingRequestStatus;

	PROCEDURE GetOrderAmount (
		dPamount OUT NUMBER,
		iPorder_id IN NVARCHAR2
	)
	AS
	BEGIN
		SELECT nvl(sum(c.quantity * b.unitPrice), 0) INTO dPamount
		FROM OrderInfo a, OrderLine  b, OrderLineDetail c
		WHERE a.id = b.orderId AND b.id = c.orderLineId
		AND (c.status <> 8 AND c.status <>9)
		AND originOrderId = iPorder_id;
	END GetOrderAmount;

	PROCEDURE GetPaidAmount (
		dPpaid_amount OUT NUMBER,
		iPorder_id IN NVARCHAR2
	)
	AS
	BEGIN
		SELECT nvl(sum(c.amount), 0) INTO dPpaid_amount
		FROM OrderInfo a, CreditInfo  b, CreditInfoDetail c
		WHERE a.id = b.orderId AND b.id = c.creditInfoId
		AND b.type=2 AND (c.status=1 OR c.status=3)
		AND a.originOrderId = iPorder_id;
	END GetPaidAmount;

	PROCEDURE GetOrderStatus (
		iPstatus OUT NUMBER,
		iPorder_id IN NVARCHAR2
	)
	AS
	BEGIN
		SELECT status INTO iPstatus
		FROM OrderInfo
		WHERE originOrderId = iPorder_id;

	END GetOrderStatus;

	PROCEDURE IsOrderPaid (
		iPorder_id IN NVARCHAR2,
    iPresult	 IN OUT INT
	)
	AS
	BEGIN
		/*
		DepositDetail.status:
		1-HOLD FOR ORDER, 3-USED,  5-HOLD FOR AR
		Deposit.paymentType:
		10-STORE Credit, 11-Coupon
		*/
		SELECT count(*) INTO iPresult
		FROM OrderInfo o
		INNER JOIN DepositDetail dd ON o.id = dd.orderId AND dd.status IN (1, 3, 5)
		INNER JOIN Deposit d ON d.id = dd.depositId AND d.paymentType NOT IN (10, 11)
		WHERE o.originOrderId = iPorder_id;
	END IsOrderPaid;

END Pkg_FE_CustomerUpdateAccess;
/

