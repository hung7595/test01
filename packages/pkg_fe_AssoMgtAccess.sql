create or replace PACKAGE Pkg_Fe_Assomgtaccess AS

TYPE refcur IS REF CURSOR;

PROCEDURE GetAssoByAssoId
(
  iPassociateId IN INT,
  curPout OUT refcur
);

PROCEDURE UpdAsso
(
	iPassociateId IN INT,
	iPsiteId IN INT,
  cPassoApproved IN VARCHAR2,
	cPpayeeName IN VARCHAR2,
	cPpayeeAdd1 IN VARCHAR2,
	cPpayeeAdd2 IN VARCHAR2,
	cPpayeeCity IN VARCHAR2,
	cPpayeeState IN VARCHAR2,
	cPpayeeZip IN VARCHAR2,
	iPpayeeCid IN INT,
	cPpayeePhone IN VARCHAR2,
	cPpayeeEmail IN VARCHAR2,
	cPcontactName IN VARCHAR2,
	cPcontactAdd1 IN VARCHAR2,
	cPcontactAdd2 IN VARCHAR2,
	cPcontactCity IN VARCHAR2,
	cPcontactState IN VARCHAR2,
	cPcontactZip IN VARCHAR2,
	iPcontactCid IN INT,
	cPcontactPhone IN VARCHAR2,
	cPcontactEmail IN VARCHAR2,
	iPpaymentMethod IN INT,
	iPpaymentThreshold IN INT,
	iPreferenceSource IN INT,
	iPcommLang IN INT,
	cPnewsPref IN VARCHAR2,
	cPcompanyName IN VARCHAR2,
	cPcomment IN VARCHAR2,
	cPpaypalEmail IN VARCHAR2,
	iPcommissionId IN INT,
	cPssn IN VARCHAR2,
	iPtype IN INT
);

PROCEDURE GetLinkByLinkId
(
  iPlinkId IN INT,
  curPout OUT refcur
);

PROCEDURE GetLinkByLinkCode
(
  cPlinkCode IN VARCHAR2,
  curPout OUT refcur
);

PROCEDURE UpdLink
(
  iPlinkId IN INT,
  cPsiteName IN VARCHAR2,
  cPlinkCode IN VARCHAR2,
  cPlinkUrl IN VARCHAR2,
  cPlinkDesc IN VARCHAR2,
  cPisEnglish IN VARCHAR2,
  cPisChinese IN VARCHAR2,
  cPisJapanese IN VARCHAR2,
  cPisKorean IN VARCHAR2,
  cPisOther IN VARCHAR2,
  iPhitsType IN INT,
  cPisMusic IN VARCHAR2,
  cPisKaraoke IN VARCHAR2,
  cPisMovies IN VARCHAR2,
  cPisAnime IN VARCHAR2,
  cPisComics IN VARCHAR2,
  cPisBooks IN VARCHAR2,
  cPisVideoGames IN VARCHAR2,
  cPisElectronics IN VARCHAR2,
  iPlinkType IN INT
);

PROCEDURE GetAllAssoOrderByLinkId
(
  iPlinkId IN INT,
  dPstartDate IN DATE DEFAULT NULL,
  dPendDate IN DATE DEFAULT NULL,
  iPdateType IN INT,
  curPout OUT refcur
);

PROCEDURE GetAllAssoOrderByAssoId
(
  iPassociateId IN INT,
  dPstartDate IN DATE DEFAULT NULL,
  dPendDate IN DATE DEFAULT NULL,
  iPdateType IN INT,
  curPout OUT refcur
);

PROCEDURE GetAssoOrderByLinkId
(
  iPlinkId IN INT,
  iPorderStatus IN INT,
  dPstartDate IN DATE DEFAULT NULL,
  dPendDate IN DATE DEFAULT NULL,
  iPdateType IN INT,
  curPout OUT refcur
);

PROCEDURE GetAssoOrderByAssoId
(
  iPassociateId IN INT,
  iPorderStatus IN INT,
  dPstartDate IN DATE DEFAULT NULL,
  dPendDate IN DATE DEFAULT NULL,
  iPdateType IN INT,
  curPout OUT refcur
);

PROCEDURE GetAssoPaymentByAssoId
(
  iPassociateId IN INT,
  curPout OUT refcur
);

PROCEDURE GetAssoCommByAssoId
(
  iPassociateId IN INT,
  curPout OUT refcur
);

PROCEDURE GetPendingAsso
(
  iPsiteId IN INT,
  curPout OUT refcur
);

PROCEDURE GetPendingLink
(
  iPsiteId IN INT,
  curPout OUT refcur
);

PROCEDURE UpdAssoStatus
(
  iPassociateId IN INT,
  cPassociateApproved IN CHAR
);

PROCEDURE UpdLinkStatus
(
  iPlinkId IN INT,
  iPlinkStatus IN INT
);

PROCEDURE GetLinkByAssoId
(
  iPassociateId IN INT,
  curPout OUT refcur
);

PROCEDURE GetShopper
(
  cPshopperId VARCHAR2,
  curPout OUT refcur
);

PROCEDURE VoidAssoOrder
(
  iPorderNumber IN INT
);

PROCEDURE GetPaidCreditByAssoId
(
  iPassociateId IN INT,
  curPout OUT refcur
);

PROCEDURE VoidPaidCredit
(
  iPassociateId IN INT,
  cPchequeNumber IN VARCHAR2,
  iPcreditId IN INT
);

PROCEDURE CreatePayment
(
  iPassociateId IN INT,
  iPpaymentOption IN INT,
  cPchequeNumber IN VARCHAR2,
  deciPamount IN FLOAT,
  dtPpayDate IN DATE
);

PROCEDURE InsertLog
(
  cPmessage IN NCLOB
);

PROCEDURE GenerateLinkCode
(
  iPlinkId IN INT
);

PROCEDURE GetCommissionBalance
(
  iPAssociateId IN INT,
  dPbalance OUT FLOAT
);

PROCEDURE CreateAssoCredit
(
  iPAssociateId IN INT,
  dPcommission IN FLOAT,
  dtPpayDate IN DATE default sysdate
);

END Pkg_Fe_Assomgtaccess;
/



create or replace PACKAGE BODY Pkg_Fe_Assomgtaccess AS

PROCEDURE GetAssoByAssoId
(
  iPassociateId IN INT,
  curPout OUT refcur
)
IS
BEGIN
  OPEN curPout FOR
  SELECT * FROM YA_ASSOCIATE WHERE associate_id = iPassociateId;
END GetAssoByAssoId;

PROCEDURE UpdAsso
(
	iPassociateId IN INT,
	iPsiteId IN INT,
  cPassoApproved IN VARCHAR2,
	cPpayeeName IN VARCHAR2,
	cPpayeeAdd1 IN VARCHAR2,
	cPpayeeAdd2 IN VARCHAR2,
	cPpayeeCity IN VARCHAR2,
	cPpayeeState IN VARCHAR2,
	cPpayeeZip IN VARCHAR2,
	iPpayeeCid IN INT,
	cPpayeePhone IN VARCHAR2,
	cPpayeeEmail IN VARCHAR2,
	cPcontactName IN VARCHAR2,
	cPcontactAdd1 IN VARCHAR2,
	cPcontactAdd2 IN VARCHAR2,
	cPcontactCity IN VARCHAR2,
	cPcontactState IN VARCHAR2,
	cPcontactZip IN VARCHAR2,
	iPcontactCid IN INT,
	cPcontactPhone IN VARCHAR2,
	cPcontactEmail IN VARCHAR2,
	iPpaymentMethod IN INT,
	iPpaymentThreshold IN INT,
	iPreferenceSource IN INT,
	iPcommLang IN INT,
	cPnewsPref IN VARCHAR2,
	cPcompanyName IN VARCHAR2,
	cPcomment IN VARCHAR2,
	cPpaypalEmail IN VARCHAR2,
	iPcommissionId IN INT,
	cPssn IN VARCHAR2,
	iPtype IN INT
)
IS
BEGIN
  UPDATE YA_ASSOCIATE
  SET
    site_id = iPsiteId,
    associate_approved = cPassoApproved,
    PAYEE_NAME = cPpayeeName,
    PAYEE_ADDRESS1 = cPpayeeAdd1,
    PAYEE_ADDRESS2 = cPpayeeAdd2,
    PAYEE_CITY = cPpayeeCity,
    PAYEE_STATE = cPpayeeState,
    PAYEE_COUNTRY_ID = iPpayeeCid,
    PAYEE_ZIP = cPpayeeZip,
    PAYEE_PHONE = cPpayeePhone,
    PAYEE_EMAIL = cPpayeeEmail,
    CONTACT_NAME = cPcontactName,
    CONTACT_ADDRESS1 = cPcontactAdd1,
    CONTACT_ADDRESS2 = cPcontactAdd2,
    CONTACT_CITY = cPcontactCity,
    CONTACT_STATE = cPcontactState,
    CONTACT_ZIP = cPcontactZip,
    CONTACT_COUNTRY_ID = iPcontactCid,
    CONTACT_PHONE = cPcontactPhone,
    CONTACT_EMAIL = cPcontactEmail,
    PAYMENT_OPTION = iPpaymentMethod,
    PAYMENT_THRESHOLD = iPpaymentThreshold,
    HOW_LEARNED = iPreferenceSource,
    COMM_LANG = iPcommLang,
    NEWS_PREF = cPnewsPref,
    COMPANY_NAME = cPcompanyName,
    "COMMENT" = cPcomment,
    PAYPAL_EMAIL = cPpaypalEmail,
    COMMISSION_ID = iPcommissionId,
    TAXID_SSN = cPssn,
    TYPE_ID = iPtype
  WHERE
    associate_id = iPassociateId;

  IF (SQLCODE=0) THEN
  	COMMIT;
  ELSE
  	ROLLBACK;
  END IF;
END UpdAsso;

PROCEDURE GetLinkByLinkId
(
  iPlinkId IN INT,
  curPout OUT refcur
)
IS
BEGIN
  OPEN curPout FOR
  SELECT * FROM YA_ASSOCIATE_LINK WHERE link_id = iPlinkId;
END GetLinkByLinkId;

PROCEDURE GetLinkByLinkCode
(
  cPlinkCode IN VARCHAR2,
  curPout OUT refcur
)
IS
BEGIN
  OPEN curPout FOR
  SELECT * FROM YA_ASSOCIATE_LINK WHERE link_code = cPlinkCode;
END GetLinkByLinkCode;

PROCEDURE UpdLink
(
  iPlinkId IN INT,
  cPsiteName IN VARCHAR2,
  cPlinkCode IN VARCHAR2,
  cPlinkUrl IN VARCHAR2,
  cPlinkDesc IN VARCHAR2,
  cPisEnglish IN VARCHAR2,
  cPisChinese IN VARCHAR2,
  cPisJapanese IN VARCHAR2,
  cPisKorean IN VARCHAR2,
  cPisOther IN VARCHAR2,
  iPhitsType IN INT,
  cPisMusic IN VARCHAR2,
  cPisKaraoke IN VARCHAR2,
  cPisMovies IN VARCHAR2,
  cPisAnime IN VARCHAR2,
  cPisComics IN VARCHAR2,
  cPisBooks IN VARCHAR2,
  cPisVideoGames IN VARCHAR2,
  cPisElectronics IN VARCHAR2,
  iPlinkType IN INT
)
IS
BEGIN
  UPDATE YA_ASSOCIATE_LINK
  SET
    site_name = cPsiteName,
    link_code = cPlinkCode,
    link_type = iPlinkType,
    link_url = cPlinkUrl,
    link_desc = cPlinkDesc,
    is_english = cPisEnglish,
    is_chinese = cPisChinese,
    is_japanese = cPisJapanese,
    is_korean = cPisKorean,
    is_other = cPisOther,
    hits_type = iPhitsType,
    is_music = cPisMusic,
    is_karaoke = cPisKaraoke,
    is_movies = cPisMovies,
    is_anime = cPisAnime,
    is_comics = cPisComics,
    is_books = cPisBooks,
    is_video_games = cPisVideoGames,
    is_electronics = cPisElectronics
  WHERE link_id = iPlinkId;

  IF (SQLCODE=0) THEN
  	COMMIT;
  ELSE
  	ROLLBACK;
  END IF;
END UpdLink;

PROCEDURE GetAllAssoOrderByLinkId
(
  iPlinkId IN INT,
  dPstartDate IN DATE DEFAULT NULL,
  dPendDate IN DATE DEFAULT NULL,
  iPdateType IN INT,
  curPout OUT refcur
)
IS
BEGIN
  IF ((dPstartDate IS NULL)OR(dPendDate IS NULL)) THEN
    OPEN curPout FOR
    SELECT *
    FROM viewAssoLinkOrderLang
    WHERE link_id = iPlinkId;
  ELSE
    OPEN curPout FOR
    SELECT *
    FROM viewAssoLinkOrderLang
    WHERE link_id = iPlinkId
    AND
      CASE iPdateType
      WHEN 1 THEN order_date /* order date */
      ELSE last_change_date /* last change date */
      END
      BETWEEN dPstartDate AND dPendDate;
  END IF;
END GetAllAssoOrderByLinkId;

PROCEDURE GetAllAssoOrderByAssoId
(
  iPassociateId IN INT,
  dPstartDate IN DATE DEFAULT NULL,
  dPendDate IN DATE DEFAULT NULL,
  iPdateType IN INT,
  curPout OUT refcur
)
IS
BEGIN
  IF ((dPstartDate IS NULL)OR(dPendDate IS NULL)) THEN
    OPEN curPout FOR
    SELECT *
    FROM viewAssoLinkOrderLang
    WHERE link_id IN (SELECT link_id FROM YA_ASSOCIATE_LINK WHERE associate_id = iPassociateId);
  ELSE
    OPEN curPout FOR
    SELECT *
    FROM viewAssoLinkOrderLang
    WHERE link_id IN
    (
      SELECT link_id FROM YA_ASSOCIATE_LINK WHERE associate_id = iPassociateId
    )
    AND
      CASE iPdateType
      WHEN 1 THEN order_date /* order date */
      ELSE last_change_date /* last change date */
      END
      BETWEEN dPstartDate AND dPendDate;
  END IF;
END GetAllAssoOrderByAssoId;

PROCEDURE GetAssoOrderByLinkId
(
  iPlinkId IN INT,
  iPorderStatus IN INT,
  dPstartDate IN DATE DEFAULT NULL,
  dPendDate IN DATE DEFAULT NULL,
  iPdateType IN INT,
  curPout OUT refcur
)
IS
BEGIN
  IF ((dPstartDate IS NULL)OR(dPendDate IS NULL)) THEN
    OPEN curPout FOR
    SELECT *
    FROM viewAssoLinkOrderLang
    WHERE link_id = iPlinkId;
  ELSE
    OPEN curPout FOR
    SELECT *
    FROM viewAssoLinkOrderLang
    WHERE link_id = iPlinkId
    AND credit_status = iPorderStatus
    AND
      CASE iPdateType
      WHEN 1 THEN order_date /* order date */
      ELSE last_change_date /* last change date */
      END
      BETWEEN dPstartDate AND dPendDate;
  END IF;
END GetAssoOrderByLinkId;

PROCEDURE GetAssoOrderByAssoId
(
  iPassociateId IN INT,
  iPorderStatus IN INT,
  dPstartDate IN DATE DEFAULT NULL,
  dPendDate IN DATE DEFAULT NULL,
  iPdateType IN INT,
  curPout OUT refcur
)
IS
BEGIN
  IF ((dPstartDate IS NULL)OR(dPendDate IS NULL)) THEN
    OPEN curPout FOR
    SELECT *
    FROM viewAssoLinkOrderLang
    WHERE link_id IN (SELECT link_id FROM YA_ASSOCIATE_LINK WHERE associate_id = iPassociateId) AND credit_status = iPorderStatus;
  ELSE
    OPEN curPout FOR
    SELECT *
    FROM viewAssoLinkOrderLang
    WHERE link_id IN
    (
      SELECT link_id FROM YA_ASSOCIATE_LINK WHERE associate_id = iPassociateId
    )
    AND credit_status = iPorderStatus
    AND
      CASE iPdateType
      WHEN 1 THEN order_date /* order date */
      ELSE last_change_date /* last change date */
      END
      BETWEEN dPstartDate AND dPendDate;
  END IF;
END GetAssoOrderByAssoId;

PROCEDURE GetAssoPaymentByAssoId
(
  iPassociateId IN INT,
  curPout OUT refcur
)
IS
BEGIN
  OPEN curPout FOR
  SELECT * FROM YA_ASSOCIATE_PAY_HISTORY
  WHERE associate_id = iPassociateId
  ORDER BY pay_date DESC;
END GetAssoPaymentByAssoId;

PROCEDURE GetAssoCommByAssoId
(
  iPassociateId IN INT,
  curPout OUT refcur
)
IS
BEGIN
  OPEN curPout FOR
  SELECT * FROM YA_ASSOCIATE_COMMISSION_HIST
  WHERE associate_id = iPassociateId
  ORDER BY valid_date DESC;
END GetAssoCommByAssoId;

PROCEDURE GetPendingAsso
(
  iPsiteId IN INT,
  curPout OUT refcur
)
IS
BEGIN
  OPEN curPout FOR
  SELECT l.* FROM YA_ASSOCIATE_LINK l
  inner join YA_ASSOCIATE a ON a.associate_id = l.associate_id
  WHERE a.site_id = iPsiteId
    AND l.link_status = 1
    AND LOWER(a.associate_approved) = 'n'
  ORDER BY l.link_id;
END GetPendingAsso;

PROCEDURE GetPendingLink
(
  iPsiteId IN INT,
  curPout OUT refcur
)
IS
BEGIN
  OPEN curPout FOR
  SELECT l.* FROM YA_ASSOCIATE_LINK l
  inner join YA_ASSOCIATE a ON a.associate_id = l.associate_id
  WHERE a.site_id = iPsiteId
    AND l.link_status = 1
    AND LOWER(a.associate_approved) = 'y'
  ORDER BY l.link_id;
END GetPendingLink;

PROCEDURE UpdAssoStatus
(
  iPassociateId IN INT,
  cPassociateApproved IN CHAR
)
IS
BEGIN
  UPDATE YA_ASSOCIATE
  SET associate_approved = cPassociateApproved
  WHERE associate_id = iPassociateId;

  IF (SQLCODE=0) THEN
  	COMMIT;
  ELSE
  	ROLLBACK;
  END IF;
END UpdAssoStatus;

PROCEDURE UpdLinkStatus
(
  iPlinkId IN INT,
  iPlinkStatus IN INT
)
IS
BEGIN
  UPDATE YA_ASSOCIATE_LINK
  SET link_status = iPlinkStatus
  WHERE link_id = iPlinkId;

  IF (SQLCODE=0) THEN
  	COMMIT;
  ELSE
  	ROLLBACK;
  END IF;
END UpdLinkStatus;

PROCEDURE GetLinkByAssoId
(
  iPassociateId IN INT,
  curPout OUT refcur
)
IS
BEGIN
  OPEN curPout FOR
  SELECT * FROM YA_ASSOCIATE_LINK WHERE associate_id = iPassociateId;
END GetLinkByAssoId;

PROCEDURE GetShopper
(
  cPshopperId VARCHAR2,
  curPout OUT refcur
)
IS
BEGIN
  OPEN curPout FOR
  SELECT * FROM YA_SHOPPER WHERE shopper_id = cPshopperId;
END GetShopper;

PROCEDURE VoidAssoOrder
(
  iPorderNumber IN INT
)
IS
BEGIN
  UPDATE YA_ASSOCIATE_LINK_ORDERS
  SET credit_status = 4, last_change_date = SYSDATE
  WHERE order_num = iPorderNumber
  AND credit_status <> 4;

  IF (SQLCODE=0) THEN
  	COMMIT;
  ELSE
  	ROLLBACK;
  END IF;
END VoidAssoOrder;

PROCEDURE GetPaidCreditByAssoId
(
  iPassociateId IN INT,
  curPout OUT refcur
)
IS
BEGIN
  OPEN curPout FOR
  SELECT p.associate_id, p.pay_date, p.cheque_num, p.amount_paid, c.credit_id, c.current_balance
  FROM YA_ASSOCIATE_PAY_HISTORY p
  inner join YA_FRONTEND_CREDIT_SYSTEM c ON p.cheque_num = 'YA_ASSO_'||c.credit_id
  WHERE associate_id = iPassociateId
  ORDER BY pay_date DESC;
END GetPaidCreditByAssoId;

PROCEDURE VoidPaidCredit
(
  iPassociateId IN INT,
  cPchequeNumber IN VARCHAR2,
  iPcreditId IN INT
)
IS
  dLdebitAmount FLOAT;
  iLcount INT;
BEGIN
  SELECT current_balance INTO dLdebitAmount FROM YA_FRONTEND_CREDIT_SYSTEM WHERE credit_id = iPcreditId FOR UPDATE;
  SELECT current_balance INTO dLdebitAmount FROM YA_FRONTEND_CREDIT_SYSTEM WHERE credit_id = iPcreditId;

  IF (dLdebitAmount>0) THEN
    UPDATE YA_FRONTEND_CREDIT_SYSTEM
    SET
      current_balance = current_balance - dLdebitAmount
    WHERE
      credit_id = iPcreditId
      AND current_balance = dLdebitAmount;

    SELECT
      COUNT(1) INTO iLcount
    FROM
      YA_FRONTEND_CREDIT_SYSTEM
    WHERE
      credit_id = iPcreditId
      AND current_balance = 0;

    IF (iLcount=1) THEN
      INSERT INTO YA_FRONTEND_CREDIT_SYSTEM_TXN (credit_id, debit_amount, debit_ordernum, snapshot_balance, transaction_remark)
      VALUES (iPcreditId, dLdebitAmount, 999999999, 0, 'Associate Credit Rollback');

      INSERT INTO YA_ASSOCIATE_PAY_HISTORY
      (
      associate_id,
      pay_date,
      amount_paid,
      cheque_num,
      payment_option
      )
      VALUES
      (
      iPassociateId,
      SYSDATE,
      -1*dLdebitAmount,
      'VOID '||cPchequeNumber,
      1 -- paid by credit
      );

      IF (SQLCODE=0) THEN
      	COMMIT;
      ELSE
      	ROLLBACK;
      END IF;
    ELSE
      ROLLBACK;
    END IF;
  ELSE
    ROLLBACK;
  END IF;
END VoidPaidCredit;

PROCEDURE CreatePayment
(
  iPassociateId IN INT,
  iPpaymentOption IN INT,
  cPchequeNumber IN VARCHAR2,
  deciPamount IN FLOAT,
  dtPpayDate IN DATE
)
IS
  dtLpayDate DATE;
  iLpayHistoryId INT;
BEGIN
  if (dtPpayDate is not null) then
    dtLpayDate := dtPpayDate;
  else
    dtLpayDate := SYSDATE;
  end if;
  
  select seq_ya_asso_pay_history.nextval into iLpayHistoryId from dual;

  INSERT INTO YA_ASSOCIATE_PAY_HISTORY
  (
    id,
    associate_id,
    pay_date,
    amount_paid,
    cheque_num,
    payment_option
  )
  VALUES
  (
    iLpayHistoryId,
    iPassociateId,
    dtLpayDate,
    deciPamount,
    cPchequeNumber,
    iPpaymentOption
  );

  IF (SQLCODE=0) THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END CreatePayment;

PROCEDURE InsertLog
(
  cPmessage IN NCLOB
)
IS
BEGIN
  INSERT INTO YA_ASSOCIATE_MGT_LOG (id, ts, message)
  VALUES(seq_associate_mgt_log.NEXTVAL, SYSDATE, cPmessage);

  IF (SQLCODE=0) THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END InsertLog;

PROCEDURE GenerateLinkCode
(
  iPlinkId IN INT
)
IS
  cLlinkCode VARCHAR(8);
  iLcheck INT;
  iLlength INT;
BEGIN
  SELECT COUNT(1) INTO iLcheck FROM YA_ASSOCIATE_LINK WHERE link_id = iPlinkId AND LENGTH(link_code)<6;

  IF (iLcheck=1) THEN
    iLcheck := 1;
    iLlength := 8;
    WHILE (iLcheck>0)
    LOOP
      SELECT dbms_random.string('X', iLlength) str INTO cLlinkCode FROM dual;
      SELECT COUNT(1) INTO iLcheck FROM YA_ASSOCIATE_LINK WHERE link_code = cLlinkCode;
    END LOOP;

    UPDATE YA_ASSOCIATE_LINK SET link_code = cLlinkCode WHERE link_id = iPlinkId;

    IF (SQLCODE=0) THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  ELSE
    dbms_output.put_line('non empty link code already exists');
  END IF;
END GenerateLinkCode;

PROCEDURE GetCommissionBalance
(
  iPAssociateId IN INT,
  dPbalance OUT FLOAT
)
IS
  dPtotalGain FLOAT;
  dPtotalPaid FLOAT;
  dPlegacyAmount FLOAT;
BEGIN
  SELECT NVL(SUM(NVL(lo.credit_amount, lo.quantity*lo.unit_price*ch.comm_rate)), 0) into dPtotalGain
  FROM YA_ASSOCIATE_LINK l
  inner join YA_ASSOCIATE_LINK_ORDERS lo
  ON l.associate_id = iPAssociateId AND l.link_id = lo.link_id
  left join YA_ASSOCIATE_COMMISSION_HIST ch
  ON l.associate_id = ch.associate_id
  AND TO_CHAR(lo.order_date, 'yyyy') = TO_CHAR(ch.valid_date, 'yyyy')
  AND TO_CHAR(lo.order_date, 'mm') = TO_CHAR(ch.valid_date, 'mm')
  WHERE credit_status = 2;

  SELECT NVL(SUM(TOTAL_CREDIT-TOTAL_CREDIT_PAID), 0) into dPlegacyAmount FROM YA_ASSOCIATE_LEGACY_HISTORY
  WHERE link_id in (SELECT link_id FROM YA_ASSOCIATE_LINK WHERE associate_id = iPAssociateId);

  SELECT NVL(SUM(amount_paid), 0) into dPtotalPaid
  FROM YA_ASSOCIATE_PAY_HISTORY
  WHERE associate_id = iPAssociateId;

  dPbalance := dPtotalGain + dPlegacyAmount - dPtotalPaid;
END GetCommissionBalance;

PROCEDURE CreateAssoCredit
(
  iPAssociateId IN INT,
  dPcommission IN FLOAT,
  dtPpayDate IN DATE default sysdate
)
IS
  cLshopperId VARCHAR(32);
  iLsiteId INT;
  cLcreditCode VARCHAR(255);
  iLcheck INT;
  iLlength INT;
  iLcreditId INT;
  iLpayHistoryId INT;
BEGIN
  select shopper_id into cLshopperId from ya_associate where associate_id = iPAssociateId;
  iLcheck := 1;
  iLlength := 9;
  WHILE (iLcheck>0)
  LOOP
    SELECT 'YA_ASSO_'||dbms_random.string('X', iLlength) str INTO cLcreditCode FROM dual;
    SELECT COUNT(1) INTO iLcheck FROM ya_frontend_credit_system WHERE credit_code = cLcreditCode;
  END LOOP;
  select shopper_id, site_id into cLshopperId, iLsiteId from ya_associate where associate_id = iPAssociateId;

  select SEQ_FRONTEND_CREDIT_SYSTEM.nextval into iLcreditId from dual;

  insert into ya_frontend_credit_system (credit_id, site_id, shopper_id, credit_code, credit_type_id, initial_balance, current_balance, transaction_datetime, bogus, remark, currency)
  values (iLcreditId, iLsiteId, cLshopperId, cLcreditCode, 3, dPcommission, dPcommission, dtPpayDate, 'N', '', 'USD');

  insert into ya_frontend_credit_system_txn (credit_id, credit_amount, snapshot_balance, transaction_datetime)
  values (iLcreditId, dPcommission, dPcommission, dtPpayDate);

  select seq_ya_asso_pay_history.nextval into iLpayHistoryId from dual;

  insert into ya_associate_pay_history (id, associate_id, pay_date, amount_paid, cheque_num, payment_option)
  values (iLpayHistoryId, iPAssociateId, dtPpayDate, dPcommission, 'YA_ASSO_'||to_char(iLcreditId), 1);

  IF (SQLCODE=0) THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END CreateAssoCredit;

END Pkg_Fe_Assomgtaccess;
/


