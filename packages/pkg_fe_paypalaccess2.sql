create or replace
PACKAGE PKG_FE_PAYPALACCESS2
AS
  TYPE refcur IS ref CURSOR;


   PROCEDURE InsertDetailLog (
    iPpaypalDataType IN INT,
    cPpaypalUserId IN VARCHAR2,
    cPpayerUserEmail IN VARCHAR2,
    iPpayerStatus IN INT,
    ncPpayerFirstname IN NVARCHAR2,
    ncPpayerLastname IN NVARCHAR2,
    iPpaymentStatus IN INT,
    deciPpaymentAmount IN DECIMAL,
    deciPmcGross IN DECIMAL,
    deciPpaymentFee IN DECIMAL,
    deciPmcFee IN DECIMAL,
    cPmcCurrency IN VARCHAR2,
    deciPexchangeRate IN DECIMAL,
    cPtransactionId IN CHAR,
    cPparentTransactionId IN CHAR,
    dtPpaymentDatetime IN DATE,
    iPpendingReason IN INT,
    iPreasonCode IN INT,
    ncPRemark IN NCLOB,
    iPverificationStatus IN INT,
    cPipnVersion IN VARCHAR2,
    cPguid IN CHAR,
    cPverifySign IN VARCHAR2,
    cPbusinessAccount IN VARCHAR2
  );
  PROCEDURE InsertDetailAddressLog (
      iPpaypalDataType IN INT,
    cPtransactionId IN CHAR,
		cPpayerCountry IN NVARCHAR2,
		cPpayerState IN NVARCHAR2,
		cPpayerZip IN NVARCHAR2,
		cPpayerCity IN NVARCHAR2,
		cPpayerStreet IN NVARCHAR2
  );

  PROCEDURE GetOverallPaymentStatusByGUID (
    cPguid IN CHAR,
    iPoverAllStatus	OUT	INT
  );

  PROCEDURE GetPaypalOrderByGuid (
    cPguid		IN 	CHAR,
    iPorderNum OUT INT
  );

  PROCEDURE InsertPaypalOrderMapping (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    cPguid IN CHAR,
	iPsaleId IN INT DEFAULT -1
  );

  PROCEDURE UpdatePaypalOrderBackendStatus (
    cPtxnId IN CHAR,
    iPbackendStatus IN INT
  );

 PROCEDURE InsertErrorDetailLog (
	iPpaypalDataType IN INT,
	cPpaymentUId IN CHAR,
    cPrawData IN CLOB,
	iPverificationStatus IN INT,
    iPLogId IN OUT INT
  );

    PROCEDURE GetShopperIdByGuid (
    cPguid IN CHAR,
    cPshopperId IN CHAR,
	iPsiteId OUT INT
  );
  PROCEDURE GetSiteIdByGuid (
	cPguid IN CHAR,
    cPshopperId IN CHAR,
	iPsiteId OUT INT
  );
   PROCEDURE GetOrderMappingShopperIdByGuid (
	cPguid IN CHAR,
    cPshopperId OUT CHAR
  );
   PROCEDURE InsertActionLog (
	cPpaymentTxnId IN CHAR,
	cPkey IN CHAR,
	iPtype IN INT,
	iPactionCode IN INT

  );
   PROCEDURE InsertPayPalStatus (
   	iPpaypalDataType IN INT,
	cPshopperId IN CHAR,
   	cPpaymentUId IN CHAR,
	cPtxnId IN CHAR,
	iPnotifyResponse IN INT,
	iPpaymentStatus IN INT,
	deciPpaypalAmount IN DECIMAL,
	iPorderStatus IN INT,
	cPpaymentTxnId IN CHAR,
	iPpaymentType IN INT,
	cPoutPaymentTxnId OUT CHAR
  );
  	PROCEDURE GetPaymentStatusByGuid (
	cPguid IN CHAR,
    iPpaymentStatus OUT INT,
    iPactionCode OUT INT,
	iPpaymentType OUT INT,
	iPpayerStatus OUT INT
  );
    PROCEDURE GetPayPalOrderStatusByGuid (
	cPguid IN CHAR,
    iPorderNum OUT INT,
	iPbackendStatus OUT INT
  );
   PROCEDURE GetPayPalTxnIdByGuid (
	cPguid IN CHAR,
    cPtxnId OUT CHAR
  );
   PROCEDURE GetPaymentUIdbyPaymentTxnId (
     cPpaymentTxnId IN CHAR,
	cPpaymentUId OUT CHAR
  );
    PROCEDURE UpdateOrdMappingPaymentTxnId (
	cPguid IN CHAR,
    cPpaymentTxnId IN CHAR
  );
  PROCEDURE GetPayPalOrderTxnStatus (
	cPguid IN CHAR,
    iPorderTxnStatus OUT INT
  );
    PROCEDURE UpdatePayPalOrderTxnStatus (
	cPguid IN CHAR,
    iPorderTxnStatus IN INT
  );
    PROCEDURE UpdatePayPalOrderStatus (
	cPpaymentTxnId IN CHAR,
    iPorderStatus IN INT
  );
  	PROCEDURE GetPaypalResult (
    cPpaymentTxnId IN CHAR,
    curPresult OUT refcur
  );
  PROCEDURE GetPaypalResultByDataTypeUID (
    cPpaymentUId IN CHAR,
	iPpayPalDataType IN INT,
    curPresult OUT refcur
  );
  PROCEDURE GetPaypalNotifyResponse (
    cPpaymentUId IN CHAR,
	iPpayPalDataType IN CHAR,
    iPnotifyResponse OUT int

  );
  PROCEDURE GetNoResponseIPNData (
    curPresult OUT refcur
  );
  PROCEDURE GetNoResponsePOData (
    curPresult OUT refcur
  );
   PROCEDURE GetTxnIdIdbyPaymentTxnId (
     cPpaymentTxnId IN CHAR,
	cPtxnId OUT CHAR,
	dPamount OUT DECIMAL
  );
  PROCEDURE GetPendingTransaction (
    curPresult OUT refcur
  );
  PROCEDURE GetExceptionTransaction (
    curPresult OUT refcur
  );
  PROCEDURE GetNoOrderTransaction (
    curPresult OUT refcur
  );
  PROCEDURE InsertPOErrorLog (
	cPpaymentTxnId IN CHAR,
	cPex IN CLOB
  );
  PROCEDURE UpdateStatusToRefund (
		cPpaymentUId IN CHAR,
		iPresult OUT INT
  );
  	PROCEDURE InsertSendCreditStatus (

		cPpaymentUId IN CHAR,
		iPstatus IN INT

  );
    PROCEDURE UpdatePaypalOrderStatusByTxnId (
    cPtxnId IN CHAR,
    iPstatus IN INT
  );
    PROCEDURE UpdatePONoResponseRetryCount (
	cPpaymentUId IN CHAR
  );
    PROCEDURE GetBackendOrderByTxnId (
    cPtxnId IN CHAR,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
	curPresult3 OUT refCur
  );
  	 PROCEDURE UpdateShadowCouponCode (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
	cPguid IN CHAR,
    vcPcoupon_code IN VARCHAR2
  );
  PROCEDURE UpdateShadowApplicationCredit (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
	cPguid IN CHAR,
    deciPcredit_amount IN DECIMAL
  );
END Pkg_fe_PaypalAccess2;
/

create or replace
PACKAGE BODY PKG_FE_PAYPALACCESS2
IS
PROCEDURE InsertDetailLog (
    iPpaypalDataType IN INT,
    cPpaypalUserId IN VARCHAR2,
    cPpayerUserEmail IN VARCHAR2,
    iPpayerStatus IN INT,
    ncPpayerFirstname IN NVARCHAR2,
    ncPpayerLastname IN NVARCHAR2,
    iPpaymentStatus IN INT,
    deciPpaymentAmount IN DECIMAL,
    deciPmcGross IN DECIMAL,
    deciPpaymentFee IN DECIMAL,
    deciPmcFee IN DECIMAL,
    cPmcCurrency IN VARCHAR2,
    deciPexchangeRate IN DECIMAL,
    cPtransactionId IN CHAR,
    cPparentTransactionId IN CHAR,
    dtPpaymentDatetime IN DATE,
    iPpendingReason IN INT,
    iPreasonCode IN INT,
    ncPRemark IN NCLOB,
    iPverificationStatus IN INT,
    cPipnVersion IN VARCHAR2,
    cPguid IN CHAR,
    cPverifySign IN VARCHAR2,
    cPbusinessAccount IN VARCHAR2
  )
  AS
    iLtmp INT;
    cLpaypalUid CHAR(32);
  BEGIN
    SELECT NULL INTO cLpaypalUid FROM DUAL;

    BEGIN
      SELECT 1 INTO iLtmp
      FROM
        ya_paypal_detail_log
      WHERE
        paypal_user_id = cPpaypalUserId
        AND payment_status = iPpaymentStatus
        AND transaction_id = cPtransactionId
		AND paypal_data_type=iPpaypalDataType;

      EXCEPTION WHEN no_data_found THEN
        SELECT NULL INTO iLtmp FROM DUAL;
    END;

    IF iLtmp IS NULL THEN
      INSERT INTO
        ya_paypal_detail_log
        (
		  paypal_data_type,
          paypal_user_id,
          payer_user_email,
          payer_status,
          payer_firstname,
          payer_lastname,
          payment_status,
          payment_amount,
          mc_gross,
          payment_fee,
          mc_fee,
          mc_currency,
          exchange_rate,
          transaction_id,
          parent_transaction_id,
          payment_datetime,
          pending_reason,
          reason_code,
          remark,
          verification_status,
          ipn_version,
          verify_sign,
          business_account,
          created_datetime,
          updated_datetime
        )
      VALUES
      (
	    iPpaypalDataType
        , cPpaypalUserId
        , cPpayerUserEmail
        , iPpayerStatus
        , ncPpayerFirstName
        , ncPpayerLastname
        , iPpaymentStatus
        , deciPpaymentAmount
        , deciPmcGross
        , deciPpaymentFee
        , deciPmcFee
        , cPmcCurrency
        , deciPexchangeRate
        , cPtransactionId
        , cPparentTransactionId
        , dtPpaymentDatetime
        , iPpendingReason
        , iPreasonCode
        , ncPRemark
        , iPverificationStatus
        , cPipnVersion
        , cPverifySign
        , cPbusinessAccount
        , SYSDATE
        , SYSDATE
      );
    END IF;

    IF cPguid IS NOT NULL THEN
      UPDATE
        ya_paypal_order_mapping
      SET
        txn_id = cPparentTransactionId
        , paypal_status = iPpaymentStatus
        , updated_datetime = SYSDATE
      WHERE
        payment_uid = cPguid;

      IF iPpaymentStatus IN (2, 3, 5, 6) THEN
        UPDATE ya_checkout_data
        SET paypal_uid = NULL
        WHERE
          paypal_uid = cPguid;
      END IF;
    ELSE
      UPDATE
        ya_paypal_order_mapping
      SET
        paypal_status = iPpaymentStatus
        , updated_datetime = SYSDATE
      WHERE
        txn_id = cPparentTransactionId;

      IF iPpaymentStatus IN (2, 3, 5, 6) THEN
        BEGIN
          SELECT payment_uid INTO cLpaypalUid
          FROM
            ya_paypal_order_mapping
          WHERE
            txn_id = cPparentTransactionId;

          EXCEPTION WHEN no_data_found THEN
            SELECT NULL INTO cLpaypalUid FROM DUAL;
        END;

        UPDATE ya_checkout_data
        SET paypal_uid = NULL
        WHERE
          cLpaypalUid is NOT NULL
          AND paypal_uid = cLpaypalUid;
      END IF;
    END IF;

    IF SQLCODE <> 0 THEN
      ROLLBACK;
    END IF;

    COMMIT;
  END InsertDetailLog;

 PROCEDURE InsertDetailAddressLog (
      iPpaypalDataType IN INT,
    cPtransactionId IN CHAR,
		cPpayerCountry IN NVARCHAR2,
		cPpayerState IN NVARCHAR2,
		cPpayerZip IN NVARCHAR2,
		cPpayerCity IN NVARCHAR2,
		cPpayerStreet IN NVARCHAR2
  )
	AS
		iPLogId INT;
		iLtmp INT;
	BEGIN
		--SELECT 1 INTO iLtmp FROM ya_paypal_detail_log WHERE transaction_id = cPtransactionId and paypal_data_type=iPpaypalDataType;

		SELECT seq_paypal_ipn_address_log.nextval INTO iPLogId FROM DUAL;
		INSERT INTO ya_paypal_detail_address_log
		(
		id,
		paypal_data_type,
		transaction_id,
		payer_country,
		payer_state,
		payer_zip,
		payer_city,
		payer_street
		)
		VALUES
		(
		iPLogId,
		iPpaypalDataType,
		cPtransactionId,
		cPpayerCountry,
		cPpayerState,
		cPpayerZip,
		cPpayerCity,
		cPpayerStreet
		);
	END InsertDetailAddressLog;

  PROCEDURE GetOverallPaymentStatusByGUID (
    cPguid IN CHAR,
    iPoverAllStatus	OUT	INT
  )
  AS
  BEGIN
    SELECT
      status INTO iPoverAllStatus
    FROM
      ya_paypal_order_mapping
    WHERE
      payment_uid = cPguid;

    EXCEPTION WHEN no_data_found THEN
      SELECT -1 INTO iPoverAllStatus FROM DUAL;
  END GetOverallPaymentStatusByGUID;

  PROCEDURE GetPaypalOrderByGuid (
    cPguid		IN 	CHAR,
    iPorderNum OUT INT
  )
  AS
  BEGIN
	  SELECT
      order_num INTO iPorderNum
  	FROM
      ya_paypal_order_mapping
  	WHERE
      payment_uid  = cPguid;

    EXCEPTION
      WHEN no_data_found THEN
        SELECT -1 INTO iPorderNum FROM DUAL;
      --WHEN TOO_MANY_ROWS THEN
  END GetPaypalOrderByGuid;



  PROCEDURE InsertPaypalOrderMapping (
    cPshopperId IN CHAR,
    iPsiteId IN INT,
    cPguid IN CHAR,
	iPsaleId IN INT DEFAULT -1
  )
  AS
    iLtmp INT;
  BEGIN
    BEGIN
      SELECT
        1 INTO iLtmp
      FROM
        ya_paypal_order_mapping
      WHERE payment_uid = cPguid;

      EXCEPTION WHEN no_data_found THEN
        SELECT NULL INTO iLtmp FROM DUAL;
    END;

    IF iLtmp IS NULL THEN
      INSERT INTO
        ya_paypal_order_mapping
        (shopper_id, payment_uid, paypal_status, status)
      VALUES
      (
        cPshopperId
        , cPguid
        , -1
        , -1
      );
/*
      IF SQLCODE <> 0 THEN
        ROLLBACK;
      END IF;
      COMMIT;
*/
    END IF;

    UPDATE
      ya_checkout_data
    SET
      paypal_uid = cPguid
    WHERE
      shopper_id = cPshopperId
      AND site_id = iPsiteId;

	INSERT INTO
	  ya_warranty_basket_shadow
	  (
	   shopper_id,
	   site_id,
       paypal_uid,
       warrantee_sku,
       warranty_sku,
       created_date
	  )
	  select
	   shopper_id,
	   site_id,
       cPguid,
       warrantee_sku,
       warranty_sku,
       created_date
	  from ya_warranty_basket
	  where shopper_id=cPshopperId
	  AND site_id=iPsiteId;

	 INSERT INTO
	 ya_new_basket_shadow
	 (
	  paypal_uid,
	  shopper_id,
	  site_id,
	  sku,
	  quantity,
	  created_datetime,
	  type
	 )
	 select
	  cPguid,
	  shopper_id,
	  site_id,
	  sku,
	  quantity,
	  created_datetime,
	  type
	  from
	  ya_new_basket
	 where shopper_id=cPshopperId
	  AND site_id=iPsiteId;

	  INSERT INTO ya_checkout_data_shadow
	  (
	  shopper_id, site_id, sale_id, customer_firstname, customer_lastname, customer_email, customer_comment, shipping_method_id,
	  split_shipment, ship_to_firstname, ship_to_lastname, ship_to_address_one, ship_to_address_two, ship_to_city, ship_to_state_id, ship_to_state,
	  ship_to_zip, ship_to_country_id, ship_to_day_phone, ship_to_eve_phone, ship_to_fax_number, ship_to_mobile_phone,
	  ship_to_email, payment_method_id, bill_to_firstname, bill_to_lastname, bill_to_address_one, bill_to_address_two,
	  bill_to_city, bill_to_state_id, bill_to_state, bill_to_zip, bill_to_country_id, bill_to_phone, bill_to_email,
	  coupon_code, credit_amount, cc_number, cc_type_id, cc_expiration_month, cc_expiration_year, bank_name, bank_phone,
	  currency, exchange_rate, bill_profile_id, ship_profile_id, cc_profile_id, paypal_uid, created_datetime, last_updated_datetime,
	  cc_numberencrypted, encryptionkey, cvc_code, order_txn_status
	  )
	  select
	  shopper_id, site_id, iPsaleId, customer_firstname, customer_lastname, customer_email, customer_comment, shipping_method_id,
	  split_shipment, ship_to_firstname, ship_to_lastname, ship_to_address_one, ship_to_address_two, ship_to_city, ship_to_state_id, ship_to_state,
	  ship_to_zip, ship_to_country_id, ship_to_day_phone, ship_to_eve_phone, ship_to_fax_number, ship_to_mobile_phone,
	  ship_to_email, payment_method_id, bill_to_firstname, bill_to_lastname, bill_to_address_one, bill_to_address_two,
	  bill_to_city, bill_to_state_id, bill_to_state, bill_to_zip, bill_to_country_id, bill_to_phone, bill_to_email,
	  coupon_code, credit_amount, cc_number, cc_type_id, cc_expiration_month, cc_expiration_year, bank_name, bank_phone,
	  currency, exchange_rate, bill_profile_id, ship_profile_id, cc_profile_id, paypal_uid, created_datetime, last_updated_datetime,
	  cc_numberencrypted, encryptionkey, cvc_code, order_txn_status
	  from ya_checkout_data
	  where shopper_id=cPshopperId
	  AND site_id=iPsiteId;

    IF SQLCODE <> 0 THEN
      ROLLBACK;
      RETURN;
    END IF;
    COMMIT;
  END InsertPaypalOrderMapping;

  PROCEDURE UpdatePaypalOrderBackendStatus (
    cPtxnId IN CHAR,
    iPbackendStatus IN INT
  )
  AS
  iLstatus INT;
  BEGIN
    UPDATE
      ya_paypal_order_mapping
    SET
      backend_status = iPbackendStatus
      , updated_datetime = SYSDATE
    WHERE
      txn_id = cPtxnId;

	BEGIN
		select 1 into iLstatus
		from ya_paypal_order_mapping om
			inner join ya_paypal_status  ps on om.payment_uid=ps.payment_uid and paypal_data_type=2
			where ((status in (-1,10) and paypal_status = 1) or (status =9 and paypal_status = 4 and payment_type=1))  --echeck case
			and om.txn_id=cPtxnId
			and backend_status is not null
			and backend_status > 2;
		EXCEPTION
			WHEN no_data_found THEN
				SELECT null INTO iLstatus FROM DUAL;
	END;
	IF iLstatus IS NOT NULL THEN
		update
			ya_paypal_order_mapping
		set
			status = 0
		where
		txn_id = cPtxnId;
	END IF;


    IF SQLCODE <> 0 THEN
      ROLLBACK;
    END IF;
    COMMIT;
  END UpdatePaypalOrderBackendStatus;

   PROCEDURE InsertErrorDetailLog (
	iPpaypalDataType IN INT,
	cPpaymentUId IN CHAR,
    cPrawData IN CLOB,
	iPverificationStatus IN INT,
    iPLogId IN OUT INT
  )
  AS
    iLseq_currval INT;
    iLseq_diff INT;
  BEGIN
   -- IF iPlogId IS NULL OR iPlogId < 0 THEN
      SELECT seq_paypal_invalid_ipn_log.nextval INTO iPLogId FROM DUAL;
 /*   ELSE
      SELECT seq_paypal_invalid_ipn_log.nextval INTO iLseq_currval FROM dual;
      iLseq_diff := iPLogId - iLseq_currval;
      IF iLseq_diff <> 0 THEN
        EXECUTE IMMEDIATE 'ALTER SEQUENCE seq_paypal_invalid_ipn_log INCREMENT BY ' || iLseq_diff;
        SELECT seq_paypal_invalid_ipn_log.nextval INTO iLseq_currval FROM dual;
        EXECUTE IMMEDIATE 'ALTER SEQUENCE seq_paypal_invalid_ipn_log INCREMENT BY 1';
      END IF;
    END IF;
*/
    INSERT INTO ya_paypal_invalid_detail_log
    (
      id,
	  paypal_data_type,
	  payment_uid,
      raw_data,
	  verification_status,
      created_datetime
    )
    VALUES (iPLogId, iPpaypalDataType,cPpaymentUId,cPrawData,iPverificationStatus, SYSDATE);

    IF SQLCODE <> 0 THEN
      ROLLBACK;
      iPLogId := -1;
    ELSE
      COMMIT;
    END IF;
  END InsertErrorDetailLog;

	--no use
 PROCEDURE GetShopperIdByGuid (
	cPguid IN CHAR,
    cPshopperId IN CHAR,
	iPsiteId OUT INT
  )
  AS
  BEGIN
	  SELECT
      site_id INTO iPsiteId
  	FROM
      ya_checkout_data
  	WHERE
	  shopper_id = cPshopperId and
      paypal_uid  = cPguid;

    EXCEPTION
      WHEN no_data_found THEN

        SELECT -1 INTO iPsiteId FROM DUAL;

  END GetShopperIdByGuid;
  PROCEDURE GetSiteIdByGuid (
	cPguid IN CHAR,
    cPshopperId IN CHAR,
	iPsiteId OUT INT
  )
  AS
  BEGIN
	  SELECT
      site_id INTO iPsiteId
  	FROM
      ya_checkout_data_shadow
  	WHERE
	  shopper_id = cPshopperId and
      paypal_uid  = cPguid;

    EXCEPTION
      WHEN no_data_found THEN

        SELECT -1 INTO iPsiteId FROM DUAL;

  END GetSiteIdByGuid;
  PROCEDURE GetOrderMappingShopperIdByGuid (
	cPguid IN CHAR,
    cPshopperId OUT CHAR

  )
  AS
  BEGIN
	  SELECT
      shopper_id INTO cPshopperId
  	FROM
      ya_paypal_order_mapping
  	WHERE
      payment_uid  = cPguid;

    EXCEPTION
      WHEN no_data_found THEN
        SELECT '' INTO cPshopperId FROM DUAL;

  END GetOrderMappingShopperIdByGuid;

   PROCEDURE InsertActionLog (

		cPpaymentTxnId IN CHAR,
		cPkey IN CHAR,
		iPtype IN INT,
		iPactionCode IN INT

  )
	AS
		iLtmp INT;
	BEGIN
		SELECT 1 INTO iLtmp FROM ya_paypal_action_log WHERE payment_txn_id = cPpaymentTxnId and action_code=iPactionCode;
		EXCEPTION
		WHEN no_data_found THEN
        SELECT NULL INTO iLtmp FROM DUAL;
		IF iLtmp IS NULL THEN
			INSERT INTO ya_paypal_action_log
			(
			payment_txn_id,
			key,
			type,
			action_code
			)
			VALUES
			(
			cPpaymentTxnId,
			cPkey,
			iPtype,
			iPactionCode
			);
		Else
			UPDATE ya_paypal_action_log
			set key=cPkey,
			type=iPtype,
			created_datetime=sysdate
			WHERE payment_txn_id=cPpaymentTxnId and action_code=iPactionCode;
		End IF;

	END InsertActionLog;

	PROCEDURE InsertPayPalStatus (
   	iPpaypalDataType IN INT,
	cPshopperId IN CHAR,
   	cPpaymentUId IN CHAR,
	cPtxnId IN CHAR,
	iPnotifyResponse IN INT,
	iPpaymentStatus IN INT,
	deciPpaypalAmount IN DECIMAL,
	iPorderStatus IN INT,
	cPpaymentTxnId IN CHAR,
	iPpaymentType IN INT,
	cPoutPaymentTxnId OUT CHAR

  )
  AS
  		iLtmp INT;
  	BEGIN
	begin
	SELECT 1 INTO iLtmp FROM ya_paypal_status WHERE payment_uid = cPpaymentUId and paypal_data_type=iPpaypalDataType;
	EXCEPTION WHEN no_data_found THEN
        SELECT NULL INTO iLtmp FROM DUAL;
	end;
		IF iLtmp IS NULL THEN
			INSERT INTO ya_paypal_status
			(
			paypal_data_type,
			shopper_id,
			payment_uid,
			txn_id,
			notify_response,
			payment_status,
			paypal_amount,
			order_status,
			payment_txn_id,
			payment_type
			)
			VALUES
			(
			iPpaypalDataType,
			cPshopperId,
			cPpaymentUId,
			cPtxnId,
			iPnotifyResponse,
			iPpaymentStatus,
			deciPpaypalAmount,
			iPorderStatus,
			cPpaymentTxnId,
			iPpaymentType
			);
		Else
			UPDATE ya_paypal_status
			set shopper_id=cPshopperId,
			txn_id=cPtxnId,
			notify_response=iPnotifyResponse,
			payment_status=iPpaymentStatus,
			paypal_amount=deciPpaypalAmount,
			order_status=iPorderStatus,
			--payment_txn_id=cPpaymentTxnId, --do not update payment txn id
			updated_datetime=sysdate,
			payment_type=iPpaymentType
			WHERE payment_uid = cPpaymentUId and paypal_data_type=iPpaypalDataType;
		End IF;
		SELECT payment_txn_id INTO cPoutPaymentTxnId FROM ya_paypal_status WHERE payment_uid = cPpaymentUId and paypal_data_type=iPpaypalDataType;
		/*update ya_paypal_order_mapping
		set payment_txn_id=cPpaymentTxnId
		where payment_uid=cPpaymentUId;*/
	END InsertPayPalStatus;

	PROCEDURE GetPaymentStatusByGuid (
	cPguid IN CHAR,
    iPpaymentStatus OUT INT,
	iPactionCode OUT INT,
	iPpaymentType OUT INT,
	iPpayerStatus OUT INT
  )
  AS
  BEGIN

	  SELECT
        payment_status ,action_code,payment_type,payer_status INTO iPpaymentStatus, iPactionCode,iPpaymentType,iPpayerStatus
       FROM
      (
        SELECT
         payment_status,pal.action_code,payment_uid,payment_type,payer_status
        FROM
          ya_paypal_status ps
          inner join ya_paypal_action_log  pal on ps.payment_txn_id=pal.payment_txn_id
          inner join ya_paypal_detail_log dl on ps.paypal_data_type=dl.paypal_data_type and ps.txn_id=dl.transaction_id
       ORDER BY paypal_data_type DESC
      )
      WHERE
        payment_uid=cPguid and ROWNUM < 2;

    EXCEPTION

      WHEN no_data_found THEN
        SELECT -1,-1,-1,-1 INTO iPpaymentStatus, iPactionCode,iPpaymentType,iPpayerStatus FROM DUAL;

  END GetPaymentStatusByGuid;

  PROCEDURE GetPayPalOrderStatusByGuid (
	cPguid IN CHAR,
    iPorderNum OUT INT,
	iPbackendStatus OUT INT
  )
  AS
  BEGIN

	  SELECT
        NVL(order_num,-1) ,NVL(backend_status,-2) INTO iPorderNum, iPbackendStatus
       FROM
	   ya_paypal_order_mapping
	   where
	   payment_uid=cPguid;

  END GetPayPalOrderStatusByGuid;

   PROCEDURE GetPayPalTxnIdByGuid (
	cPguid IN CHAR,
    cPtxnId OUT CHAR
  )
  AS
  BEGIN

	  SELECT
        NVL(txn_id,'')  INTO cPtxnId
       FROM
	   ya_paypal_order_mapping
	   where
	   payment_uid=cPguid;

  END GetPayPalTxnIdByGuid;

  PROCEDURE GetPaymentUIdbyPaymentTxnId (
     cPpaymentTxnId IN CHAR,
	cPpaymentUId OUT CHAR
  )
  AS
  BEGIN

	 SELECT
        payment_uid INTO cPpaymentUId
       FROM
	   ya_paypal_status
	   where
	   payment_txn_id=cPpaymentTxnId;
    IF SQLCODE <> 0 THEN
      ROLLBACK;
    END IF;
    COMMIT;
  END GetPaymentUIdbyPaymentTxnId;

  PROCEDURE UpdateOrdMappingPaymentTxnId (
	cPguid IN CHAR,
    cPpaymentTxnId IN CHAR
  )
  AS
  BEGIN
    UPDATE
      ya_paypal_order_mapping
    SET
      payment_txn_id = cPpaymentTxnId
      , updated_datetime = SYSDATE
    WHERE
     payment_uid = cPguid;

    IF SQLCODE <> 0 THEN
      ROLLBACK;
    END IF;
    COMMIT;
  END UpdateOrdMappingPaymentTxnId;

  PROCEDURE GetPayPalOrderTxnStatus (
	cPguid IN CHAR,
    iPorderTxnStatus OUT INT
  )
  AS
  BEGIN

	  SELECT
        order_txn_status INTO iPorderTxnStatus
       FROM
	   ya_checkout_data_shadow
	   where
	   paypal_uid=cPguid;
      EXCEPTION

      WHEN no_data_found THEN
        SELECT -1 INTO iPorderTxnStatus FROM DUAL;
  END GetPayPalOrderTxnStatus;

  PROCEDURE UpdatePayPalOrderTxnStatus (
	cPguid IN CHAR,
    iPorderTxnStatus IN INT
  )
  AS
  BEGIN
    UPDATE
      ya_checkout_data_shadow
    SET
      order_txn_status = iPorderTxnStatus
      , last_updated_datetime = SYSDATE
    WHERE
     paypal_uid = cPguid;

    IF SQLCODE <> 0 THEN
      ROLLBACK;
    END IF;
    COMMIT;
  END UpdatePayPalOrderTxnStatus;

   PROCEDURE UpdatePayPalOrderStatus (
	cPpaymentTxnId IN CHAR,
    iPorderStatus IN INT
  )
  AS
  BEGIN
    UPDATE
      ya_paypal_status
    SET
      order_status = iPorderStatus
      , updated_datetime = SYSDATE
    WHERE
     payment_txn_id = cPpaymentTxnId;

    IF SQLCODE <> 0 THEN
      ROLLBACK;
    END IF;
    COMMIT;
  END UpdatePayPalOrderStatus;
  PROCEDURE GetPaypalResult (
    cPpaymentTxnId IN CHAR,
    curPresult OUT refcur
  )
	AS
	BEGIN
		OPEN curPresult FOR
				SELECT
					ps.paypal_data_type,ps.payment_uid,ps.txn_id,ps.shopper_id,ps.notify_response
					,ps.payment_status,ps.paypal_amount,ps.order_status,ps.payment_type
					,dl.payer_status,
					(select action_code from
						(select action_code from ya_paypal_action_log al
						 where payment_txn_id=cPpaymentTxnId
						order by created_datetime desc)
					where rownum<2) action_code
				FROM ya_paypal_status ps
				inner join ya_paypal_detail_log dl on dl.transaction_id=ps.txn_id and dl.paypal_data_type=ps.paypal_data_type
				where ps.payment_txn_id = cPpaymentTxnId;



	END GetPaypalResult;
	PROCEDURE GetPaypalResultByDataTypeUID (
    cPpaymentUId IN CHAR,
	iPpayPalDataType IN INT,
    curPresult OUT refcur
  )
	AS
	BEGIN
		OPEN curPresult FOR
			SELECT
				ps.paypal_data_type,ps.payment_uid,ps.txn_id,ps.shopper_id,ps.notify_response
				,ps.payment_status,ps.paypal_amount,ps.order_status,ps.payment_type,ps.payment_txn_id

			FROM ya_paypal_status ps

			where ps.payment_uid = cPpaymentUId and paypal_data_type=iPpayPalDataType;

	END GetPaypalResultByDataTypeUID;

	PROCEDURE GetTxnIdIdbyPaymentTxnId (
     cPpaymentTxnId IN CHAR,
	cPtxnId OUT CHAR,
	dPamount OUT DECIMAL
  )
  AS
  BEGIN

	 SELECT
        txn_id,paypal_amount INTO cPtxnId,dPamount
       FROM
	   ya_paypal_status
	   where
	   payment_txn_id=cPpaymentTxnId;
    IF SQLCODE <> 0 THEN
      ROLLBACK;
    END IF;
    COMMIT;
  END GetTxnIdIdbyPaymentTxnId;

	PROCEDURE GetPaypalNotifyResponse (
    cPpaymentUId IN CHAR,
	iPpayPalDataType IN CHAR,
    iPnotifyResponse OUT int

  )
	AS
	BEGIN
		SELECT
        notify_response INTO iPnotifyResponse
       FROM
	   ya_paypal_status
	   where
	   payment_uid=cPpaymentUId
	   and paypal_data_type=iPpayPalDataType;
      EXCEPTION

      WHEN no_data_found THEN
        SELECT -3 INTO iPnotifyResponse FROM DUAL; --set as no response and let program to process this data
	END GetPaypalNotifyResponse;

	PROCEDURE GetNoResponseIPNData (
    curPresult OUT refcur
  )
	AS
	BEGIN
		OPEN curPresult FOR
			select a.payment_uid,b.raw_data,a.created_datetime from
			(select ps.paypal_data_type,idl.payment_uid,min(id) id, ps.created_datetime
			from ya_paypal_status ps
			left join ya_paypal_invalid_detail_log idl on
			ps.paypal_data_type=idl.paypal_data_type and ps.payment_uid=idl.payment_uid
			where
			ps.notify_response=-2
			and ps.paypal_data_type=2
			and idl.verification_status=-1
			group by ps.paypal_data_type,idl.payment_uid,ps.created_datetime
			order by ps.created_datetime desc			) a,
			ya_paypal_invalid_detail_log b
			where a.id = b.id
			order by a.created_datetime desc;
	END GetNoResponseIPNData;

	PROCEDURE GetNoResponsePOData (
    curPresult OUT refcur
  )
	AS
	BEGIN


	  -- Empty temp table
	  EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_noresponse_po_data';


	  --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      --case 1: Not yet Prcoess order (try to place order)
      --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	  insert into temp_noresponse_po_data
        (paypal_data_type,payment_uid,txn_id,shopper_id,notify_response,payment_status,paypal_amount,order_status,payment_txn_id,payment_type,
        created_datetime,updated_datetime,order_num,backend_status,retry_count,status,site_id)
      select ps.paypal_data_type,ps.payment_uid,ps.txn_id,ps.shopper_id,
        ps.notify_response,ps.payment_status,ps.paypal_amount, ps.order_status,ps.payment_txn_id,
        ps.payment_type,ps.created_datetime,ps.updated_datetime,om.order_num,om.backend_status,ps.retry_count,status,cds.site_id
      from ya_paypal_status ps
      inner join ya_paypal_order_mapping om on ps.payment_uid=om.payment_uid --and ps.paypal_data_type=1
      left join ya_checkout_data_shadow cds on cds.paypal_uid=om.payment_uid
      where
        (om.order_num is null and om.backend_status is null and ps.payment_status=1 and
		ps.order_status=-2 and ps.created_datetime <= to_date(sysdate-2) and om.status in(0,-1));


	  --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      -- case 2: No response case (try to place order or apply credit)
      --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	  insert into temp_noresponse_po_data
		(paypal_data_type,payment_uid,txn_id,shopper_id,notify_response,payment_status,paypal_amount,order_status,payment_txn_id,payment_type,
		created_datetime,updated_datetime,order_num,backend_status,retry_count,status,site_id)
	  select ps.paypal_data_type,ps.payment_uid,ps.txn_id,ps.shopper_id,
        ps.notify_response,ps.payment_status,ps.paypal_amount, ps.order_status,ps.payment_txn_id,
        ps.payment_type,ps.created_datetime,ps.updated_datetime,om.order_num,om.backend_status,ps.retry_count,status,
        nvl(cds.site_id,oi.origin_id) as site_id
      from ya_paypal_status ps inner join ya_paypal_order_mapping om on ps.payment_uid=om.payment_uid --and ps.paypal_data_type=1
      left join ya_checkout_data_shadow cds on cds.paypal_uid=om.payment_uid
      left join order_info oi on oi.origin_order_id = TO_CHAR(om.order_num)
      where
        (ps.order_status=-1 and --no response
        om.status in (0,-1) and --payment completed
        ((om.order_num>0 and om.backend_status>0 and om.backend_status<3) -- no callback from backend
        or om.order_num is null) -- not yet place order
        )  and (oi.sts in (1,7) or oi.sts is null); -- order is new or on held

      --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      -- case 3 : Cannot apply paypal credit to order (try to apply credit to order again)
      --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      insert into temp_noresponse_po_data
        (paypal_data_type,payment_uid,txn_id,shopper_id,notify_response,payment_status,paypal_amount,order_status,payment_txn_id,payment_type,
		created_datetime,updated_datetime,order_num,backend_status,retry_count,status,site_id)
	  select ps.paypal_data_type,ps.payment_uid,ps.txn_id,ps.shopper_id,
        ps.notify_response,ps.payment_status,ps.paypal_amount, ps.order_status,ps.payment_txn_id,
        ps.payment_type,ps.created_datetime,ps.updated_datetime,om.order_num,om.backend_status,ps.retry_count,status,
		nvl(cds.site_id,oi.origin_id) as site_id
      from ya_paypal_status ps inner join ya_paypal_order_mapping om on ps.payment_uid=om.payment_uid --and ps.paypal_data_type=1
      left join ya_checkout_data_shadow cds on cds.paypal_uid=om.payment_uid
      left join order_info oi on oi.origin_order_id = TO_CHAR(om.order_num)
      where
       (notify_response in (1,2) -- data should be valid
       and order_status in (0,1,-1) -- paymentgateway may place credit before
       and ps.created_datetime>to_date('2007/03/10','yyyy/mm/dd') --cut off date. do not prcoess < cutoff date data
       and
       ((order_num>0 and backend_status>-2 and backend_status<3)  -- order has been created. prcoess all error(-1),notified(0),confirmed(1) and notified_credit(2) data
       or (order_num is null and status in (0,-1)) --no order has been created
       ))
       and (oi.sts in (1,7) or oi.sts is null); -- order is new or on held


	  OPEN curPresult FOR
	  select
		a.paypal_data_type,a.payment_uid,a.txn_id,a.shopper_id,a.notify_response,a.payment_status,a.paypal_amount,a.order_status,
		a.payment_txn_id,a.payment_type,a.created_datetime,a.updated_datetime,a.order_num,a.backend_status, a.retry_count, a.status, a.site_id
	  from temp_noresponse_po_data a
	  where a.paypal_data_type = 1
	        and  not exists
              (select cs.ref_num from credit_source cs where cs.ref_num=a.txn_id)
      union
	  select
		b.paypal_data_type,b.payment_uid,b.txn_id,b.shopper_id,b.notify_response,b.payment_status,b.paypal_amount,b.order_status,
		b.payment_txn_id,b.payment_type,b.created_datetime,b.updated_datetime,b.order_num,b.backend_status, b.retry_count, b.status, b.site_id
	  from temp_noresponse_po_data b
	  where b.paypal_data_type = 2
			and b.payment_uid not in (select payment_uid from temp_noresponse_po_data where paypal_data_type = 1)
	        and  not exists
              (select cs.ref_num from credit_source cs where cs.ref_num=b.txn_id);


	END GetNoResponsePOData;

	PROCEDURE GetPendingTransaction (
    curPresult OUT refcur
  )
	AS
	BEGIN
		OPEN curPresult FOR
			  select ss.status as sendcredit_status,ps.payment_txn_id,ps.payment_uid,ps.notify_response,ps.payment_status,
			pom.shopper_id, pil.payer_firstname, pil.payer_lastname, pom.order_num,
			pom.txn_id as transaction_id,  pom.paypal_status, pom.status ,pil.payer_user_email as payer_email,
			pil.payment_amount as amount,  pil.pending_reason, pil.payer_status, pil.payment_datetime, success.shopper_Id as success
			,pial.transaction_id, pial.payer_country, pial.payer_state, pial.payer_zip, pial.payer_city, pial.payer_street,backend_status,oi.origin_id as site_id
			from
			ya_paypal_order_mapping pom
            left join order_info oi on oi.origin_order_id = TO_CHAR(pom.order_num)
			inner join ya_paypal_detail_log pil on (
            paypal_data_type=2 and
     		(pom.paypal_status = 4 -- pending
            or pom.paypal_status = 1 and pom.status in ( 1,6,7,10) and pil.payment_status =1  --pending,amount increase,amount decrease,payer unverified
     		 )
			and pil.parent_transaction_id = pom.txn_id )
			left join (
				select distinct pom.shopper_id
				from
				ya_paypal_order_mapping pom
				inner join ya_paypal_detail_log pil on (
                paypal_data_type=2 and
    		    (pom.paypal_status = 4 -- pending
                or pom.paypal_status = 1 and pom.status in ( 1,6,7,10) and pil.payment_status =1  --pending,amount increase,amount decrease,payer unverified
     		 )
				and pil.parent_transaction_id = pom.txn_id )
				inner join ya_paypal_order_mapping sus on (
				sus.shopper_id = pom.shopper_id
				and sus.order_num is not null
				and sus.paypal_status = 1
				and sus.status = 0
				and sus.backend_status > 2
				)
			) success on (
				success.shopper_id = pom.shopper_id
				)
			left join (
				select transaction_id, payer_country, payer_state, payer_zip, payer_city, payer_street
				from ya_paypal_detail_address_log
				group by paypal_data_type,transaction_id, payer_country, payer_state, payer_zip, payer_city, payer_street having paypal_data_type=2
				) pial on pil.transaction_id = pial.transaction_id
                        left join ya_paypal_sendcredit_status ss on pom.payment_uid=ss.payment_uid
                        inner join ya_paypal_status ps on pom.payment_uid=ps.payment_uid and ps.paypal_data_type=2
			order by pom.created_datetime desc;
	END GetPendingTransaction;

	PROCEDURE GetExceptionTransaction (
    curPresult OUT refcur
  )
	AS
	BEGIN
		OPEN curPresult FOR
			select om.shopper_id,dl.payer_firstname, dl.payer_lastname,
			dl.transaction_id,  om.paypal_status, om.status ,dl.payer_user_email as payer_email,
			dl.payment_amount as amount,  dl.pending_reason, dl.payer_status, dl.payment_datetime,om.created_datetime
			from ya_paypal_detail_log dl
			left join ya_paypal_order_mapping om on dl.transaction_id=om.txn_id and dl.paypal_data_type=2
			where paypal_status not in (1)
			order by created_datetime desc; --not in complete payment status
	END GetExceptionTransaction;

	PROCEDURE GetNoOrderTransaction (
    curPresult OUT refcur
  )
	AS
	BEGIN
		OPEN curPresult FOR
			select
                       a.shopper_id,a.payer_user_email,a.payment_uid,a.notify_response
                       ,a.payment_status,a.order_status,a.payer_firstname, a.payer_lastname,
                       a.transaction_id,  a.paypal_status, a.status ,a.payer_email,
					   a.amount,  a.pending_reason, a.payer_status, a.payment_datetime,a.created_datetime,
						a.notify_response,a.order_status
            from (
                   select
						om.shopper_id,dl.payer_user_email,ps.payment_uid,ps.notify_response,ps.payment_status,ps.order_status
						,dl.payer_firstname, dl.payer_lastname,
						dl.transaction_id,  om.paypal_status, om.status ,dl.payer_user_email as payer_email,
						dl.payment_amount as amount,  dl.pending_reason, dl.payer_status, dl.payment_datetime,om.created_datetime
				   from ya_paypal_detail_log dl
				   left join ya_paypal_order_mapping om on dl.transaction_id=om.txn_id and dl.paypal_data_type=1
				   inner join ya_paypal_status ps on om.payment_uid=ps.payment_uid and ps.paypal_data_type=1
                   where
                       ((paypal_status=1 and ps.order_status=-2 and ps.created_datetime <= to_date(sysdate-1))
                       or (paypal_status=1 and ps.order_status not in (-2)))
                       and order_num is null and status<>4
                       and  not exists
					   (select cs.ref_num from credit_source  cs where exists
			             (select transaction_id from ya_paypal_detail_log pdl where pdl.transaction_id=cs.ref_num)
                        and cs.ref_num=dl.transaction_id)

                  union
                  select
						om.shopper_id,dl.payer_user_email,ps.payment_uid,ps.notify_response,ps.payment_status,ps.order_status
						,dl.payer_firstname, dl.payer_lastname,
						dl.transaction_id,  om.paypal_status, om.status ,dl.payer_user_email as payer_email,
						dl.payment_amount as amount,  dl.pending_reason, dl.payer_status, dl.payment_datetime,om.created_datetime

				  from ya_paypal_detail_log dl
				  left join ya_paypal_order_mapping om on dl.transaction_id=om.txn_id and dl.paypal_data_type=2
				  inner join ya_paypal_status ps on om.payment_uid=ps.payment_uid and ps.paypal_data_type=2
                  left outer join
                        (select
							ps.payment_uid
						from ya_paypal_detail_log dl
						left join ya_paypal_order_mapping om on dl.transaction_id=om.txn_id and dl.paypal_data_type=1
						inner join ya_paypal_status ps on om.payment_uid=ps.payment_uid and ps.paypal_data_type=1
						where
							((paypal_status=1 and ps.order_status=-2 and ps.created_datetime <= sysdate-1)
							or (paypal_status=1 and ps.order_status not in (-2)))
							and order_num is null and status<>4
							and  not exists (select cs.ref_num from credit_source  cs where exists
							(select transaction_id from ya_paypal_detail_log pdl where pdl.transaction_id=cs.ref_num)
							and cs.ref_num=dl.transaction_id)

                        ) b on ps.payment_uid=b.payment_uid
				  where
                        b.payment_uid is null

                        and
                        (((paypal_status=1 and ps.order_status=-2 and ps.created_datetime <= to_date(sysdate-1))
						or (paypal_status=1 and ps.order_status not in (-2)))
						and order_num is null and status<>4
						and not exists (select cs.ref_num from credit_source  cs where exists
						(select transaction_id from ya_paypal_detail_log pdl where pdl.transaction_id=cs.ref_num)
                        and cs.ref_num=dl.transaction_id)
                        )
            ) a
			order by created_datetime desc;
	END GetNoOrderTransaction;

	PROCEDURE InsertPOErrorLog (
		cPpaymentTxnId IN CHAR,
		cPex IN CLOB
  )
	AS
		iPLogId INT;

	BEGIN
		--SELECT 1 INTO iLtmp FROM ya_paypal_detail_log WHERE transaction_id = cPtransactionId and paypal_data_type=iPpaypalDataType;

		SELECT seq_paypal_po_error_log.nextval INTO iPLogId FROM DUAL;
		INSERT INTO ya_paypal_po_error_log
		(
		id,
		payment_txn_id,
		ex
		)
		VALUES
		(
		iPLogId,
		cPpaymentTxnId,
		cPex
		);
	END InsertPOErrorLog;
	PROCEDURE UpdateStatusToRefund (
		cPpaymentUId IN CHAR,
		iPresult OUT INT
  )
	AS
		iPtemp INT;

	BEGIN
		select action_code INTO iPtemp
		from (
			select action_code from ya_paypal_action_log where key=cPpaymentUId order by created_datetime desc
		)
		where rownum<2;
--		EXCEPTION WHEN no_data_found THEN
 --       SELECT NULL INTO iPtemp FROM DUAL;
--		if (iPtemp is null) or (iPtemp is not null and iPtemp>1001) then
		if iPtemp is not null and iPtemp>1001 then
			begin
				update ya_paypal_order_mapping
				set status=4
				where payment_uid=cPpaymentUId;
				select 1 into iPresult from DUAL;
			end;
		else
			select -1 into iPresult from DUAL;
		end if;


	END UpdateStatusToRefund;
	PROCEDURE InsertSendCreditStatus (

		cPpaymentUId IN CHAR,
		iPstatus IN INT

  )
	AS
		iLtmp INT;
	BEGIN
		SELECT 1 INTO iLtmp FROM ya_paypal_sendcredit_status WHERE payment_uid = cPpaymentUId;
		EXCEPTION
		WHEN no_data_found THEN
        SELECT NULL INTO iLtmp FROM DUAL;
		IF iLtmp IS NULL THEN
			INSERT INTO ya_paypal_sendcredit_status
			(
			payment_uid,
			status
			)
			VALUES
			(
			cPpaymentUId,
			iPstatus
			);
		Else
			UPDATE ya_paypal_sendcredit_status
			set status=iPstatus,
			updated_datetime=sysdate
			WHERE payment_uid=cPpaymentUId;
		End IF;

	END InsertSendCreditStatus;
      PROCEDURE UpdatePaypalOrderStatusByTxnId (
    cPtxnId IN CHAR,
    iPstatus IN INT
  )
  AS
  BEGIN
    UPDATE
      ya_paypal_order_mapping
    SET
      status = iPstatus
      , updated_datetime = SYSDATE
    WHERE
     txn_id = cPtxnId;

    IF SQLCODE <> 0 THEN
      ROLLBACK;
    END IF;
    COMMIT;
  END UpdatePaypalOrderStatusByTxnId;

  PROCEDURE UpdatePONoResponseRetryCount (
	cPpaymentUId IN CHAR
  )
  AS
  iLretryCount INT;
  BEGIN
    select retry_count+1 INTO iLretryCount from ya_paypal_status where payment_uid=cPpaymentUId and paypal_data_type=2;
    UPDATE
      ya_paypal_status
    SET
      retry_count = iLretryCount

    WHERE
     payment_uid=cPpaymentUId
	 and paypal_data_type=2;

    IF SQLCODE <> 0 THEN
      ROLLBACK;
    END IF;
    COMMIT;
  END UpdatePONoResponseRetryCount;

  PROCEDURE GetBackendOrderByTxnId (
    cPtxnId IN CHAR,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur,
	curPresult3 OUT refCur
  )
  AS
	iLsiteId INT;
	iLorderNum INT;
    iLorderId INT;
	iLpaymentAmt NUMBER(18,2);
	iLpaymentUId CHAR(32);
  BEGIN
	BEGIN
		select order_num INTO iLorderNum from ya_paypal_order_mapping where txn_id=cPtxnId;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		BEGIN
			iLorderNum:=-1;
			iLsiteId:=-1;
		END;
	END;
	BEGIN
      SELECT id,origin_id
      INTO iLorderId,iLsiteId
      FROM order_info
      WHERE origin_order_id = TO_CHAR(iLorderNum);
    EXCEPTION WHEN NO_DATA_FOUND THEN
      iLorderId := -1;
    END;

    OPEN curPresult1 FOR
	select order_num,backend_status from ya_paypal_order_mapping where txn_id=cPtxnId;

    IF iLorderId>0 THEN
    OPEN curPresult2 FOR
    select amt,coupon_amt,credit_amt,iLsiteId from billing_info where order_info_id =iLorderId;
	ELSE
	OPEN curPresult2 FOR
	select 0,0,0,-1 from dual;
	 END IF;
	BEGIN

		select payment_amount,payment_uid INTO iLpaymentAmt,iLpaymentUId  from ya_paypal_detail_log dl
		inner join ya_paypal_order_mapping om on dl.transaction_id=om.txn_id and paypal_data_type=2 and payment_status=1
		where transaction_id=cPtxnId;
	EXCEPTION WHEN NO_DATA_FOUND THEN
	  BEGIN
		iLpaymentAmt:=0;
		iLpaymentUId:='';
	  END;
	END;
	OPEN curPresult3 FOR
	select iLpaymentAmt,iLpaymentUId from dual;

	RETURN;
	END GetBackendOrderByTxnId;
		PROCEDURE UpdateShadowCouponCode (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
	cPguid IN CHAR,
    vcPcoupon_code IN VARCHAR2
  )
  AS
  BEGIN
    UPDATE ya_checkout_data_shadow
    SET
      coupon_code = vcPcoupon_code,
      last_updated_datetime = SYSDATE()
    WHERE
      shopper_id = cPshopper_id
      AND site_id = iPsite_id
	  AND paypal_uid=cPguid;
    COMMIT;
  EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
  END UpdateShadowCouponCode;
 PROCEDURE UpdateShadowApplicationCredit (
    cPshopper_id IN CHAR,
    iPsite_id IN INT,
	cPguid IN CHAR,
    deciPcredit_amount IN DECIMAL
  )
  AS
  BEGIN
    UPDATE ya_checkout_data_shadow
    SET credit_amount = deciPcredit_amount
    WHERE
      shopper_id = cPshopper_id
      AND site_id = iPsite_id
	  AND paypal_uid=cPguid;
    COMMIT;
  EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
  END UpdateShadowApplicationCredit;
 END Pkg_fe_PaypalAccess2;
/
