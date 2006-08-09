CREATE OR REPLACE PACKAGE Pkg_fe_asso AS

TYPE cur_return IS REF CURSOR;
TYPE cur_asso IS REF CURSOR RETURN YA_ASSOCIATE%ROWTYPE;
TYPE cur_assoCommDetail IS REF CURSOR RETURN YA_ASSOCIATE_COMMISSION_DETAIL%ROWTYPE;

PROCEDURE sp_fe_asso_getProductLot
(
  iPproductLotId IN INT,
  iPlangId IN INT,
  curPout_1 OUT cur_return
);
PROCEDURE sp_fe_asso_getCreativeText
(
  iPcreativeId IN INT,
  iPlangId IN INT,
  curPout_1 OUT cur_return
);
PROCEDURE sp_fe_asso_getCreativeButton
(
  iPcreativeId IN INT,
  iPlangId IN INT,
  curPout_1 OUT cur_return
);
PROCEDURE sp_fe_asso_getContentPageInfo
(
  iPpageId IN INT,
  iPsiteId IN INT,
  curPout_1 OUT cur_return,
  curPout_2 OUT cur_return,
  curPout_3 OUT cur_return  --product lot
);
PROCEDURE sp_fe_asso_genLinkCode
(
	iLinkId IN INT
);
PROCEDURE sp_fe_asso_myLogin
(
	cEmail IN VARCHAR2,
	iSiteId OUT INT,
	cPassword OUT VARCHAR2,
	iAssociateId OUT INT,
	cShopperId OUT VARCHAR2,
	cName OUT VARCHAR2,
	iLangId OUT INT
);
PROCEDURE sp_fe_asso_selAssoId
(
	cSsn IN VARCHAR2,
	cPayeeName IN VARCHAR2,
	cPayeeEmailAddress IN VARCHAR2,
	cur_out1 OUT cur_return
);
PROCEDURE sp_fe_asso_anonymousShopper
(
	cShopperId IN VARCHAR2,
	nIsAnonymous OUT NUMBER
);
PROCEDURE sp_fe_asso_readAsso
(
	cShopperId IN VARCHAR2,
	iSiteId IN INT,
	cur_out1 OUT cur_return
);
PROCEDURE sp_fe_asso_isAsso
(
	iSiteId IN INT,
	cShopperId IN VARCHAR2,
	iAssociateId OUT INT
);
PROCEDURE sp_fe_asso_getComm
(
	iAssociateId IN INT,
	cur_out1 OUT cur_return
);
PROCEDURE sp_fe_asso_getLinkName
(
	iLinkId IN INT,
	cLinkName OUT VARCHAR2,
	iLangId OUT INT
);
PROCEDURE sp_fe_asso_insAsso
(
	cPSSn IN VARCHAR2,
	cComp IN VARCHAR2,
	cShopperId IN VARCHAR2,
	iSiteId IN INT,
	cPName IN VARCHAR2,
	cPAdd1 IN VARCHAR2,
	cPAdd2 IN VARCHAR2,
	cPCity IN VARCHAR2,
	cPState IN VARCHAR2,
	cPZip IN VARCHAR2,
	iPCid IN INT,
	cPPhone IN VARCHAR2,
	cPEmail IN VARCHAR2,
	cCName IN VARCHAR2,
	cCAdd1 IN VARCHAR2,
	cCAdd2 IN VARCHAR2,
	cCCity IN VARCHAR2,
	cCState IN VARCHAR2,
	cCZip IN VARCHAR2,
	iCCid IN INT,
	cCPhone IN VARCHAR2,
	cCEmail IN VARCHAR2,
	iHow IN INT,
	iPayment IN INT,
	iPaymentOption IN INT,
	iCommLang IN INT,
	cNewsPref IN VARCHAR2,
	cPaypalEmail IN VARCHAR2,
	iLangId IN INT,
	iAssociateId IN INT,
	iRowAffected OUT INT
);
PROCEDURE sp_fe_asso_insAssoHitsRaw
(
	cCode IN VARCHAR2,
	iRowAffected OUT INT
);
PROCEDURE sp_fe_asso_insLink
(
	iLinkId IN INT,
	iAssociateId IN INT,
	cSiteName IN VARCHAR2,
	iLinkType IN INT,
	cLinkUrl IN VARCHAR2,
	cLinkDesc IN VARCHAR2,
	cIsEnglish IN VARCHAR2,
	cIsChinese IN VARCHAR2,
	cIsJapanese IN VARCHAR2,
	cIsKorean IN VARCHAR2,
	cIsOther IN VARCHAR2,
	iHitsType IN INT,
	cIsMusic IN VARCHAR2,
	cIsKaraoke IN VARCHAR2,
	cIsMovies IN VARCHAR2,
	cIsAnime IN VARCHAR2,
	cIsComics IN VARCHAR2,
	cIsBooks IN VARCHAR2,
	cIsVideoGames IN VARCHAR2,
	cIsElectronics IN VARCHAR2,
	iLangId IN INT,
	iRowAffected OUT INT
);
PROCEDURE sp_fe_asso_updAsso
(
	cPSSN IN VARCHAR2,
	cShopperId IN VARCHAR2,
	iSiteID IN INT,
	cPName IN VARCHAR2,
	cPAdd1 IN VARCHAR2,
	cPAdd2 IN VARCHAR2,
	cPCity IN VARCHAR2,
	cPState IN VARCHAR2,
	cPZip IN VARCHAR2,
	iPCid IN INT,
	cPPhone IN VARCHAR2,
	cPEmail IN VARCHAR2,
	cCName IN VARCHAR2,
	cCAdd1 IN VARCHAR2,
	cCAdd2 IN VARCHAR2,
	cCCity IN VARCHAR2,
	cCState IN VARCHAR2,
	cCZip IN VARCHAR2,
	iCCid IN INT,
	cCPhone IN VARCHAR2,
	cCEmail IN VARCHAR2,
	iPayment IN INT,
	iPaymentOption IN INT,
	iCommLang IN INT,
	cNewsPref IN VARCHAR2,
	cPaypalEmail IN VARCHAR2,
	iLangId IN INT,
	iAssociateId OUT INT,
	iRowAffected OUT INT
);
PROCEDURE sp_fe_asso_updComm
(
	deci11 IN FLOAT,
	deci12 IN FLOAT,
	deci13 IN FLOAT,
	deci21 IN FLOAT,
	deci22 IN FLOAT,
	deci23 IN FLOAT,
	deci31 IN FLOAT,
	deci32 IN FLOAT,
	deci33 IN FLOAT,
	deci41 IN FLOAT,
	deci42 IN FLOAT,
	deci43 IN FLOAT,
	deci51 IN FLOAT,
	deci52 IN FLOAT,
	deci53 IN FLOAT,
	iCommId IN INT,
	iRowAffected OUT INT
);
PROCEDURE sp_fe_asso_updLink
(
	iLinkId IN INT,
	cSiteName IN VARCHAR2,
	iLinkType IN INT,
	cLinkUrl IN VARCHAR2,
	cLinkDesc IN VARCHAR2,
	cIsEnglish IN VARCHAR2,
	cIsChinese IN VARCHAR2,
	cIsJapanese IN VARCHAR2,
	cIsKorean IN VARCHAR2,
	cIsOther IN VARCHAR2,
	iHitsType IN INT,
	cIsMusic IN VARCHAR2,
	cIsKaraoke IN VARCHAR2,
	cIsMovies IN VARCHAR2,
	cIsAnime IN VARCHAR2,
	cIsComics IN VARCHAR2,
	cIsBooks IN VARCHAR2,
	cIsVideoGames IN VARCHAR2,
	cIsElectronics IN VARCHAR2,
	iLangId IN INT,
	iRowAffected OUT INT
);
PROCEDURE sp_fe_asso_link
(
	cShopperId IN VARCHAR2,
	iSiteId IN INT,
	iLangId OUT INT,
	cur_out1 OUT cur_return,
	cur_out2 OUT cur_return
);
PROCEDURE sp_fe_asso_linkDetail
(
	iLinkId IN INT,
	cur_out1 OUT cur_return
);
PROCEDURE sp_fe_asso_linkPageview
(
	iLinkId IN INT,
	cur_out1 OUT cur_return
);
PROCEDURE sp_fe_asso_pageview
(
	cShopperId IN VARCHAR2,
	iSiteId IN INT,
	cur_out1 OUT cur_return
);
PROCEDURE sp_fe_asso_password
(
	cEmail IN VARCHAR2,
	cur_out1 OUT cur_return
);
PROCEDURE sp_fe_asso_payHistory
(
	cShopperId IN VARCHAR2,
	iSiteId IN INT,
	deciTotalCommision OUT FLOAT,
	cur_out1 OUT cur_return
);
PROCEDURE sp_fe_asso_login
(
	iSiteId IN INT,
	cEmail IN VARCHAR2,
	cPassword OUT VARCHAR2,
	iAssociateId OUT INT,
	cShopperId OUT VARCHAR2,
	cName OUT VARCHAR2,
	iLangId OUT INT,
	iRowAffected OUT INT
);
PROCEDURE sp_fe_asso_getCreditSummary
(
	iAssociateId IN INT,
	cur_out1 OUT cur_return
);
PROCEDURE sp_fe_asso_createComm
(
	deci11 IN FLOAT,
	deci12 IN FLOAT,
	deci13 IN FLOAT,
	deci21 IN FLOAT,
	deci22 IN FLOAT,
	deci23 IN FLOAT,
	deci31 IN FLOAT,
	deci32 IN FLOAT,
	deci33 IN FLOAT,
	deci41 IN FLOAT,
	deci42 IN FLOAT,
	deci43 IN FLOAT,
	deci51 IN FLOAT,
	deci52 IN FLOAT,
	deci53 IN FLOAT,
	iAssocaiteId IN INT,
	iCommId OUT INT,
	iRowAffected OUT INT
);
PROCEDURE sp_fe_asso_selImgLotLang
(
	iLotId IN INT,
	iLangId IN INT,
	cur_out1 OUT cur_return
);
PROCEDURE sp_fe_asso_exportSales
(
	cMonth VARCHAR2,
	cYear VARCHAR2,
	iAssociateId INT,
	iLangId INT,
	iCreditStatus INT,
	cur_out1 OUT cur_return,
	cur_out2 OUT cur_return
);
PROCEDURE sp_fe_asso_monthlyCredit
(
	iAssociateId IN INT,
	deciPercentage OUT FLOAT,
	deciOldPercentage OUT FLOAT,
	deciLastApproved OUT FLOAT,
	cur_out1 OUT cur_return,
	cur_out2 OUT cur_return
);
PROCEDURE sp_fe_asso_selOrderByAid
(
	cMonth IN VARCHAR2,
	cYear IN VARCHAR2,
	iAssociateId IN INT,
	tiLangId IN INT,
	iCreditStatus IN INT,
	iNeedGroup IN INT,
	iNeedLinkInfo IN INT,
	iBestSeller IN INT,
	iCustomer OUT INT,
	deciPercentage OUT FLOAT,
	iNextLevel OUT INT,
	iLangId OUT INT,
	deciThisPeriodComm OUT FLOAT,
	deciTotalComm OUT FLOAT,
	cur_out01 OUT cur_return,
	cur_out02 OUT cur_return,
	cur_out03 OUT cur_return,
	cur_out04 OUT cur_return,
	cur_out05 OUT cur_return,
	cur_out06 OUT cur_return,
	cur_out07 OUT cur_return,
	cur_out08 OUT cur_return,
	cur_out09 OUT cur_return,
	cur_out10 OUT cur_return,
	cur_out11 OUT cur_return,
	cur_out12 OUT cur_return,
	cur_out13 OUT cur_return,
	cur_out14 OUT cur_return
);
PROCEDURE sp_fe_asso_selOrderByLid
(
	cMonth IN VARCHAR2,
	cYear IN VARCHAR2,
	iAssociateId IN INT,
	iLinkId IN INT,
	tiLangId IN INT,
	iCreditStatus IN INT,
	iNeedGroup IN INT,
	iBestSeller IN INT,
	iCustomer OUT INT,
	deciPercentage OUT FLOAT,
	iNextLevel OUT INT,
	iLangId OUT INT,
	deciThisPeriodComm OUT FLOAT,
	deciTotalComm OUT FLOAT,
	cur_out01 OUT cur_return,
	cur_out02 OUT cur_return,
	cur_out03 OUT cur_return,
	cur_out04 OUT cur_return,
	cur_out05 OUT cur_return,
	cur_out06 OUT cur_return,
	cur_out07 OUT cur_return,
	cur_out08 OUT cur_return,
	cur_out09 OUT cur_return,
	cur_out10 OUT cur_return,
	cur_out11 OUT cur_return,
	cur_out12 OUT cur_return,
	cur_out13 OUT cur_return,
	cur_out14 OUT cur_return
);

END Pkg_fe_asso;
/



CREATE OR REPLACE PACKAGE BODY Pkg_fe_asso AS


PROCEDURE sp_fe_asso_genLinkCode
(
	iLinkId IN INT
) IS
iLength INT;
iCharCode INT;
iCount INT;
cLinkCode VARCHAR2(8);
iCheck INT;
cOldLinkCode VARCHAR2(8);
BEGIN

SELECT link_code INTO cOldLinkCode FROM YA_ASSOCIATE_LINK WHERE link_id = iLinkId;
IF (cOldLinkCode IS NULL) OR (LENGTH(cOldLinkCode)<1) THEN
	WHILE (iCheck>0) LOOP
		WHILE (iCount<iLength) LOOP
			WHILE (NOT(((iCharCode>=ASCII('0'))AND(iCharCode<=ASCII('9')))OR((iCharCode>=ASCII('A'))AND(iCharCode<=ASCII('Z'))))) LOOP
				SELECT (1+ABS(MOD(dbms_random.random,ASCII('Z')))) INTO iCharCode FROM dual;
			END LOOP;
			cLinkCode := cLinkCode || CHR(iCharCode);
			iCharCode := 0;
			iCount := iCount+1;
		END LOOP;
		SELECT COUNT(*) INTO iCheck FROM YA_ASSOCIATE_LINK WHERE link_code=cLinkCode;
	END LOOP;
END IF;

UPDATE
	YA_ASSOCIATE_LINK
SET
	link_code = cLinkCode
WHERE
	link_id = iLinkId;

IF (SQLCODE=0) THEN
	COMMIT;
ELSE
	ROLLBACK;
END IF;

END sp_fe_asso_genLinkCode;


PROCEDURE sp_fe_asso_myLogin
(
	cEmail IN VARCHAR2,
	iSiteId OUT INT,
	cPassword OUT VARCHAR2,
	iAssociateId OUT INT,
	cShopperId OUT VARCHAR2,
	cName OUT VARCHAR2,
	iLangId OUT INT
) IS
BEGIN

SELECT
	site_id,
	associate_id,
	shopper_id,
	contact_name,
	PASSWORD,
	NVL(lang_id, 1)
	INTO
	iSiteId,
	iAssociateId,
	cShopperId,
	cName,
	cPassword,
	iLangId
FROM (
   SELECT
      YA_ASSOCIATE.site_id,
      YA_ASSOCIATE.associate_id,
      YA_SHOPPER.shopper_id,
      YA_ASSOCIATE.contact_name,
      YA_SHOPPER.PASSWORD,
      YA_ASSOCIATE.lang_id
   FROM
      YA_SHOPPER LEFT OUTER JOIN YA_ASSOCIATE
   ON
      YA_SHOPPER.shopper_id = YA_ASSOCIATE.shopper_id
   WHERE
      LOWER(YA_SHOPPER.email) = LOWER(cEmail)
	)
WHERE
	ROWNUM = 1;

END sp_fe_asso_myLogin;


PROCEDURE sp_fe_asso_selAssoId(cSsn IN VARCHAR2, cPayeeName IN VARCHAR2, cPayeeEmailAddress IN VARCHAR2, cur_out1 OUT cur_return) IS
BEGIN

IF (LENGTH(cSsn)>0) THEN
	OPEN cur_out1 FOR
	SELECT * FROM YA_ASSOCIATE WHERE taxid_ssn=cSsn;
ELSIF (LENGTH(cPayeeName)>0) THEN
	OPEN cur_out1 FOR
	SELECT * FROM YA_ASSOCIATE WHERE payee_name LIKE '%'+cPayeeName+'%';
ELSIF (LENGTH(cPayeeEmailAddress)>0) THEN
	OPEN cur_out1 FOR
	SELECT * FROM YA_ASSOCIATE WHERE payee_email LIKE '%'+cPayeeEmailAddress+'%';
END IF;

END sp_fe_asso_selAssoId;


PROCEDURE sp_fe_asso_anonymousShopper(cShopperId IN VARCHAR2, nIsAnonymous OUT NUMBER) IS
	cAnonymous CHAR(1);
	iCount INT;
BEGIN

SELECT 'Y' INTO cAnonymous FROM dual;
SELECT COUNT(1) INTO iCount FROM YA_SHOPPER WHERE shopper_id = cShopperId;
IF (iCount>0) THEN
   SELECT anonymous INTO cAnonymous FROM YA_SHOPPER WHERE shopper_id = cShopperId;
END IF;

IF (cAnonymous='Y') THEN
	nIsAnonymous := 1;
ELSE
	nIsAnonymous := 0;
END IF;

END sp_fe_asso_anonymousShopper;


PROCEDURE sp_fe_asso_readAsso(cShopperId IN VARCHAR2, ISiteId IN INT, cur_out1 OUT cur_return) IS
BEGIN

OPEN cur_out1 FOR
SELECT
	*
FROM
	YA_ASSOCIATE
WHERE
	shopper_id = cShopperId
	AND
	site_id = ISiteId;

END sp_fe_asso_readAsso;


PROCEDURE sp_fe_asso_isAsso(iSiteId IN INT, cShopperId IN VARCHAR2, iAssociateId OUT INT) IS
BEGIN

SELECT
NVL(associate_id, -1) INTO iAssociateid
FROM
YA_ASSOCIATE
WHERE
associate_approved='Y'
AND site_id=iSiteId
AND shopper_id=cShopperId;

EXCEPTION
WHEN NO_DATA_FOUND THEN
	iAssociateId := -1;
WHEN OTHERS THEN
	iAssociateId := -1;

END sp_fe_asso_isAsso;


PROCEDURE sp_fe_asso_getComm(iAssociateId IN INT, cur_out1 OUT cur_return) IS
BEGIN

OPEN cur_out1 FOR
SELECT
*
FROM
YA_ASSOCIATE_COMMISSION_DETAIL
WHERE
commission_id = (SELECT commission_id FROM YA_ASSOCIATE WHERE associate_id = iAssociateId);

END sp_fe_asso_getComm;


PROCEDURE sp_fe_asso_getLinkName(iLinkId IN INT, cLinkName OUT VARCHAR2, iLangId OUT INT) IS
	TYPE typeLinkDetails IS RECORD(c_link_name VARCHAR2(100), i_lang_id INT);
	ret_link_details typeLinkDetails;
BEGIN

SELECT
	site_name,
	NVL(lang_id, -1)
	INTO
	ret_link_details
FROM
	YA_ASSOCIATE_LINK
WHERE
	link_id=iLinkId;

cLinkName := ret_link_details.c_link_name;
iLangId := ret_link_details.i_lang_id;
/*
exception
WHEN NO_DATA_FOUND THEN
	iLangId := -1;
WHEN OTHERS THEN
	iLangId := -2;
*/
END sp_fe_asso_getLinkName;


PROCEDURE sp_fe_asso_insAsso
(
	cPSSn IN VARCHAR2,
	cComp IN VARCHAR2,
	cShopperId IN VARCHAR2,
	iSiteId IN INT,
	cPName IN VARCHAR2,
	cPAdd1 IN VARCHAR2,
	cPAdd2 IN VARCHAR2,
	cPCity IN VARCHAR2,
	cPState IN VARCHAR2,
	cPZip IN VARCHAR2,
	iPCid IN INT,
	cPPhone IN VARCHAR2,
	cPEmail IN VARCHAR2,
	cCName IN VARCHAR2,
	cCAdd1 IN VARCHAR2,
	cCAdd2 IN VARCHAR2,
	cCCity IN VARCHAR2,
	cCState IN VARCHAR2,
	cCZip IN VARCHAR2,
	iCCid IN INT,
	cCPhone IN VARCHAR2,
	cCEmail IN VARCHAR2,
	iHow IN INT,
	iPayment IN INT,
	iPaymentOption IN INT,
	iCommLang IN INT,
	cNewsPref IN VARCHAR2,
	cPaypalEmail IN VARCHAR2,
	iLangId IN INT,
	iAssociateId IN INT,
	iRowAffected OUT INT
) IS
	iCount INT;
	oriPaymentOption INT;
	cSsnApproved CHAR(1);
BEGIN

SELECT COUNT(*) INTO iCount FROM YA_ASSOCIATE WHERE shopper_id=cShopperId and site_id=iSiteId;
IF (iCount<1) THEN
	cSsnApproved := 'N';

	INSERT INTO YA_ASSOCIATE
	(
		taxid_ssn, company_name,
		shopper_id, site_id,
		payee_name, payee_address1,
		payee_address2, payee_city,
		payee_state, payee_zip,
		payee_country_id, payee_phone,
		payee_email, contact_name,
		contact_address1, contact_address2,
		contact_city, contact_state,
		contact_zip, contact_country_id,
		contact_phone, contact_email,
		how_learned, payment_threshold,
		payment_option, comm_lang,
		news_pref, join_date,
		paypal_email, ssn_approved,
		lang_id, associate_id
	)
	VALUES
	(
		cPSSN, cComp,
		cShopperId, ISiteId,
		cPName, cPAdd1,
		cPAdd2, cPCity,
		cPState, cPZip,
		iPCid, cPPhone,
		cPEmail, cCName,
		cCAdd1, cCAdd2,
		cCCity, cCState,
		cCZip, iCCid,
		cCPhone, cCEmail,
		iHow, iPayment,
		iPaymentOption, iCommLang,
		cNewsPref, (SYSDATE),
		cPaypalEmail, cSsnApproved,
		iLangId, iAssociateId
	);

ELSE
	UPDATE YA_ASSOCIATE
	SET taxid_ssn = cPSSN,
		company_name = cComp,
		payee_name = cPName,
		payee_address1 = cPAdd1,
		payee_address2 = cPAdd2,
		payee_city = cPCity,
		payee_state = cPState,
		payee_country_id = iPCid,
		payee_zip = cPZip,
		payee_phone = cPPhone,
		payee_email = cPEmail,
		contact_name = cCName,
		contact_address1 = cCAdd1,
		contact_address2 = cCAdd2,
		contact_city = cCCity,
		contact_state = cCState,
		contact_zip = cCZip,
		contact_country_id = iCCid,
		contact_phone = cCPhone,
		contact_email = cCEmail,
		how_learned = iHow,
		payment_threshold = iPayment,
		payment_option = iPaymentOption,
		comm_lang = iCommLang,
		news_pref = cNewsPref,
		paypal_email = cPaypalEmail,
		lang_id = iLangId
  WHERE  
    shopper_id =cShopperId 
    and site_id=iSiteId;

END IF;
iRowAffected := SQL%ROWCOUNT;

IF (iRowAffected>0) AND (SQLCODE=0) THEN
	COMMIT;
ELSE
	ROLLBACK;
END IF;

END sp_fe_asso_insAsso;


PROCEDURE sp_fe_asso_insAssoHitsRaw(cCode IN VARCHAR2, iRowAffected OUT INT) IS
	iLinkId INT;
BEGIN

SELECT link_id INTO iLinkId FROM YA_ASSOCIATE_LINK WHERE link_code = cCode;

INSERT INTO YA_ASSOCIATE_HITS_RAW (link_id, hit_datetime) VALUES(iLinkId, SYSDATE);
iRowAffected := SQL%ROWCOUNT;

IF (iRowAffected>0) THEN
	COMMIT;
ELSE
	ROLLBACK;
END IF;

END sp_fe_asso_insAssoHitsRaw;


PROCEDURE sp_fe_asso_insLink
(
	iLinkId IN INT,
	iAssociateId IN INT,
	cSiteName IN VARCHAR2,
	iLinkType IN INT,
	cLinkUrl IN VARCHAR2,
	cLinkDesc IN VARCHAR2,
	cIsEnglish IN VARCHAR2,
	cIsChinese IN VARCHAR2,
	cIsJapanese IN VARCHAR2,
	cIsKorean IN VARCHAR2,
	cIsOther IN VARCHAR2,
	iHitsType IN INT,
	cIsMusic IN VARCHAR2,
	cIsKaraoke IN VARCHAR2,
	cIsMovies IN VARCHAR2,
	cIsAnime IN VARCHAR2,
	cIsComics IN VARCHAR2,
	cIsBooks IN VARCHAR2,
	cIsVideoGames IN VARCHAR2,
	cIsElectronics IN VARCHAR2,
	iLangId IN INT,
	iRowAffected OUT INT
) IS
BEGIN

INSERT INTO YA_ASSOCIATE_LINK
(
	link_url,
	link_desc,
	associate_id,
	link_type,
	site_name,
	link_code,
	link_percentage,
	is_english,
	is_chinese,
	is_japanese,
	is_korean,
	is_other,
	is_music,
	is_karaoke,
	is_movies,
	is_anime,
	is_comics,
	is_books,
	is_video_games,
	is_electronics,
	hits_type,
	created_date,
	lang_id,
	link_id
)
VALUES
(
	cLinkUrl,
	cLinkDesc,
	iAssociateId,
	iLinkType,
	cSiteName,
	' ',
	0.1,
	cIsEnglish,
	cIsChinese,
	cIsJapanese,
	cIsKorean,
	cIsOther,
	cIsMusic,
	cIsKaraoke,
	cIsMovies,
	cIsAnime,
	cIsComics,
	cIsBooks,
	cIsVideoGames,
	cIsElectronics,
	iHitsType,
	(SYSDATE),
	iLangId,
	iLinkId
);
iRowAffected := SQL%ROWCOUNT;

IF (iRowAffected>0) AND (SQLCODE=0) THEN
	COMMIT;
ELSE
	ROLLBACK;
END IF;

END sp_fe_asso_insLink;


PROCEDURE sp_fe_asso_updAsso
(
	cPSSN IN VARCHAR2,
	cShopperId IN VARCHAR2,
	iSiteID IN INT,
	cPName IN VARCHAR2,
	cPAdd1 IN VARCHAR2,
	cPAdd2 IN VARCHAR2,
	cPCity IN VARCHAR2,
	cPState IN VARCHAR2,
	cPZip IN VARCHAR2,
	iPCid IN INT,
	cPPhone IN VARCHAR2,
	cPEmail IN VARCHAR2,
	cCName IN VARCHAR2,
	cCAdd1 IN VARCHAR2,
	cCAdd2 IN VARCHAR2,
	cCCity IN VARCHAR2,
	cCState IN VARCHAR2,
	cCZip IN VARCHAR2,
	iCCid IN INT,
	cCPhone IN VARCHAR2,
	cCEmail IN VARCHAR2,
	iPayment IN INT,
	iPaymentOption IN INT,
	iCommLang IN INT,
	cNewsPref IN VARCHAR2,
	cPaypalEmail IN VARCHAR2,
	iLangId IN INT,
	iAssociateId OUT INT,
	iRowAffected OUT INT
) IS
	oriPaymentOption INT;
	cSsnApproved CHAR(1);
BEGIN

  UPDATE YA_ASSOCIATE
  SET taxid_ssn = cPSSN,
  	payee_name = cPName,
  	payee_address1 = cPAdd1,
  	payee_address2 = cPAdd2,
  	payee_city = cPCity,
  	payee_state = cPState,
  	payee_country_id = iPCid,
  	payee_zip = cPZip,
  	payee_phone = cPPhone,
  	payee_email = cPEmail,
  	contact_name = cCName,
  	contact_address1 = cCAdd1,
  	contact_address2 = cCAdd2,
  	contact_city = cCCity,
  	contact_state = cCState,
  	contact_zip = cCZip,
  	contact_country_id = iCCid,
  	contact_phone = cCPhone,
  	contact_email = cCEmail,
  	payment_threshold = iPayment,
  	payment_option = iPaymentOption,
  	comm_lang = iCommLang,
  	news_pref = cNewsPref,
  	paypal_email = cPaypalEmail,
  	lang_id = iLangId
	WHERE  
    shopper_id=cShopperId 
    AND site_id=ISiteID;

SELECT associate_id INTO iAssociateId FROM YA_ASSOCIATE WHERE ((shopper_id = cShopperId)  AND (site_id=iSiteId));
iRowAffected := SQL%ROWCOUNT;

IF (iRowAffected>0) THEN
	COMMIT;
ELSE
	ROLLBACK;
END IF;

END sp_fe_asso_updAsso;


PROCEDURE sp_fe_asso_updComm
(
	deci11 IN FLOAT,
	deci12 IN FLOAT,
	deci13 IN FLOAT,
	deci21 IN FLOAT,
	deci22 IN FLOAT,
	deci23 IN FLOAT,
	deci31 IN FLOAT,
	deci32 IN FLOAT,
	deci33 IN FLOAT,
	deci41 IN FLOAT,
	deci42 IN FLOAT,
	deci43 IN FLOAT,
	deci51 IN FLOAT,
	deci52 IN FLOAT,
	deci53 IN FLOAT,
	iCommId IN INT,
	iRowAffected OUT INT
) IS
BEGIN

UPDATE YA_ASSOCIATE_COMMISSION_DETAIL SET percentage=deci11 WHERE commission_id = iCommId AND comm_type_id = 1 AND payment_option = 1;
UPDATE YA_ASSOCIATE_COMMISSION_DETAIL SET percentage=deci12 WHERE commission_id = iCommId AND comm_type_id = 1 AND payment_option = 2;
UPDATE YA_ASSOCIATE_COMMISSION_DETAIL SET percentage=deci13 WHERE commission_id = iCommId AND comm_type_id = 1 AND payment_option = 3;
UPDATE YA_ASSOCIATE_COMMISSION_DETAIL SET percentage=deci21 WHERE commission_id = iCommId AND comm_type_id = 2 AND payment_option = 1;
UPDATE YA_ASSOCIATE_COMMISSION_DETAIL SET percentage=deci22 WHERE commission_id = iCommId AND comm_type_id = 2 AND payment_option = 2;
UPDATE YA_ASSOCIATE_COMMISSION_DETAIL SET percentage=deci23 WHERE commission_id = iCommId AND comm_type_id = 2 AND payment_option = 3;
UPDATE YA_ASSOCIATE_COMMISSION_DETAIL SET percentage=deci31 WHERE commission_id = iCommId AND comm_type_id = 3 AND payment_option = 1;
UPDATE YA_ASSOCIATE_COMMISSION_DETAIL SET percentage=deci32 WHERE commission_id = iCommId AND comm_type_id = 3 AND payment_option = 2;
UPDATE YA_ASSOCIATE_COMMISSION_DETAIL SET percentage=deci33 WHERE commission_id = iCommId AND comm_type_id = 3 AND payment_option = 3;
UPDATE YA_ASSOCIATE_COMMISSION_DETAIL SET percentage=deci41 WHERE commission_id = iCommId AND comm_type_id = 4 AND payment_option = 1;
UPDATE YA_ASSOCIATE_COMMISSION_DETAIL SET percentage=deci42 WHERE commission_id = iCommId AND comm_type_id = 4 AND payment_option = 2;
UPDATE YA_ASSOCIATE_COMMISSION_DETAIL SET percentage=deci43 WHERE commission_id = iCommId AND comm_type_id = 4 AND payment_option = 3;
UPDATE YA_ASSOCIATE_COMMISSION_DETAIL SET percentage=deci51 WHERE commission_id = iCommId AND comm_type_id = 5 AND payment_option = 1;
UPDATE YA_ASSOCIATE_COMMISSION_DETAIL SET percentage=deci52 WHERE commission_id = iCommId AND comm_type_id = 5 AND payment_option = 2;
UPDATE YA_ASSOCIATE_COMMISSION_DETAIL SET percentage=deci53 WHERE commission_id = iCommId AND comm_type_id = 5 AND payment_option = 3;

IF (SQLCODE!=0) THEN
	iRowAffected := 0;
	ROLLBACK;
ELSE
	iRowAffected := SQL%ROWCOUNT;
	COMMIT;
END IF;

END sp_fe_asso_updComm;


PROCEDURE sp_fe_asso_updLink
(
	iLinkId IN INT,
	cSiteName IN VARCHAR2,
	iLinkType IN INT,
	cLinkUrl IN VARCHAR2,
	cLinkDesc IN VARCHAR2,
	cIsEnglish IN VARCHAR2,
	cIsChinese IN VARCHAR2,
	cIsJapanese IN VARCHAR2,
	cIsKorean IN VARCHAR2,
	cIsOther IN VARCHAR2,
	iHitsType IN INT,
	cIsMusic IN VARCHAR2,
	cIsKaraoke IN VARCHAR2,
	cIsMovies IN VARCHAR2,
	cIsAnime IN VARCHAR2,
	cIsComics IN VARCHAR2,
	cIsBooks IN VARCHAR2,
	cIsVideoGames IN VARCHAR2,
	cIsElectronics IN VARCHAR2,
	iLangId IN INT,
	iRowAffected OUT INT
) IS
BEGIN

UPDATE YA_ASSOCIATE_LINK SET
	site_name = cSiteName,
	link_type = iLinkType,
	link_desc = cLinkDesc,
	link_url = cLinkUrl,
	link_status = 4 ,
	is_english = cIsEnglish,
	is_chinese = cIsChinese,
	is_japanese = cIsJapanese,
	is_korean = cIsKorean,
	is_other = cIsOther,
	is_music = cIsMusic,
	is_karaoke = cIsKaraoke,
	is_movies = cIsMovies,
	is_anime =  cIsAnime,
	is_comics = cIsComics,
	is_books = cIsBooks,
	is_video_games = cIsVideoGames,
	is_electronics = cIsElectronics,
	hits_type = iHitsType,
	lang_id = iLangId
WHERE link_id = iLinkId;

IF (SQLCODE!=0) THEN
	iRowAffected := 0;
	ROLLBACK;
ELSE
	iRowAffected := SQL%ROWCOUNT;
	COMMIT;
END IF;

END sp_fe_asso_updLink;


PROCEDURE sp_fe_asso_link
(
	cShopperId IN VARCHAR2,
	iSiteId IN INT,
	iLangId OUT INT,
	cur_out1 OUT cur_return,
	cur_out2 OUT cur_return
) IS
BEGIN

OPEN cur_out1 FOR
SELECT NVL(SUM(hits), 0)  AS total, al.link_id
FROM YA_ASSOCIATE_HITS_SUMMARY ah
	RIGHT OUTER JOIN
	   (SELECT al.link_id  FROM YA_ASSOCIATE_LINK al
		    INNER JOIN (SELECT * FROM YA_ASSOCIATE WHERE shopper_id = cShopperId) a ON al.associate_id = a.associate_id AND a.site_id = ISiteId
		    AND (al.link_status = 2 OR al.link_status = 4)) al
	ON al.link_id = ah.link_id
GROUP BY al.link_id;

OPEN cur_out2 FOR
SELECT a.associate_id, al.site_name, al.link_id, ar.credit_status, NVL(SUM(ar.credit_amount),0) AS credit, al.link_code,
NVL(ah.total_credit,0) AS total
 FROM (SELECT * FROM YA_ASSOCIATE WHERE shopper_id = cShopperId AND site_id = ISiteId)  a
	INNER JOIN YA_ASSOCIATE_LINK al ON a.associate_id = al.associate_id AND al.link_status > 1
	LEFT OUTER JOIN YA_ASSOCIATE_LEGACY_HISTORY ah ON ah.link_id = al.link_id
	 LEFT OUTER JOIN YA_ASSOCIATE_LINK_ORDERS ar ON ar.link_id = al.link_id AND ar.credit_status IS NOT NULL
GROUP BY a.associate_id, al.link_id, ar.credit_status, al.site_name, al.link_code, ah.total_credit
ORDER BY al.link_id DESC;

SELECT        NVL(YA_ASSOCIATE.lang_id, 1) INTO iLangId
FROM             YA_SHOPPER INNER JOIN
                          YA_ASSOCIATE ON YA_SHOPPER.shopper_id = YA_ASSOCIATE.shopper_id
WHERE ((YA_ASSOCIATE.shopper_id=cShopperId) AND (ROWNUM=1));

END sp_fe_asso_link;


PROCEDURE sp_fe_asso_linkDetail
(
	iLinkId IN INT,
	cur_out1 OUT cur_return
) IS
BEGIN

OPEN cur_out1 FOR
SELECT link_status, link_code, link_id, associate_id, site_name, link_type, link_url, link_desc, IS_english, IS_chinese,
	is_japanese, IS_korean, IS_other, hits_type, IS_music, IS_karaoke, IS_movies, IS_anime, IS_comics,
	 IS_books, IS_video_games, IS_electronics, lang_id, created_date
FROM YA_ASSOCIATE_LINK
WHERE link_id=iLinkId;

END sp_fe_asso_linkDetail;


PROCEDURE sp_fe_asso_linkPageview
(
	iLinkId IN INT,
	cur_out1 OUT cur_return
) IS
BEGIN

OPEN cur_out1 FOR
SELECT ah.hit_day, ah.hits, al.link_id, al.site_name, TO_CHAR(ah.hit_day, 'mm/dd/yy') AS hitDay
FROM (SELECT * FROM YA_ASSOCIATE_LINK WHERE link_id=iLinkId AND (link_status = 2 OR link_status = 4)) al
INNER JOIN
(SELECT * FROM YA_ASSOCIATE_HITS_SUMMARY WHERE link_id=iLinkId AND (hit_day >= (SYSDATE)-31)) ah
 ON al.link_id = ah.link_id
 ORDER BY hit_day DESC;

END sp_fe_asso_linkPageview;


PROCEDURE sp_fe_asso_pageview
(
	cShopperId IN VARCHAR2,
	iSiteId IN INT,
	cur_out1 OUT cur_return
) IS
BEGIN

OPEN cur_out1 FOR
SELECT SUM(ah.hits) AS month_hit,
	TO_CHAR(ah.hit_day, 'fmmm') || '/' || TO_CHAR(ah.hit_day, 'yyyy') AS hit_date,
	TO_NUMBER(TO_CHAR(ah.hit_day, 'mm')) AS MONTH, TO_NUMBER(TO_CHAR(ah.hit_day, 'yyyy')) AS YEAR
 FROM YA_ASSOCIATE_LINK al
	INNER JOIN YA_ASSOCIATE_HITS_SUMMARY ah ON al.link_id = ah.link_id
WHERE al.associate_id =
	(SELECT associate_id
	FROM YA_ASSOCIATE
	WHERE shopper_id = cShopperId AND associate_approved = 'Y' AND site_id = ISiteId)
		AND ah.hit_day >= ADD_MONTHS((SYSDATE), -11)
 GROUP BY TO_CHAR(ah.hit_day, 'fmmm') || '/' || TO_CHAR(ah.hit_day, 'yyyy'), TO_NUMBER(TO_CHAR(ah.hit_day, 'yyyy')), TO_NUMBER(TO_CHAR(ah.hit_day, 'mm'))
ORDER BY YEAR ASC , MONTH ASC;

END sp_fe_asso_pageview;


PROCEDURE sp_fe_asso_password
(
	cEmail IN VARCHAR2,
	cur_out1 OUT cur_return
) IS
BEGIN

OPEN cur_out1 FOR
SELECT PASSWORD, firstname, lastname, comm_lang, NVL(lang_id, 1) AS lang_id
FROM YA_SHOPPER INNER JOIN YA_ASSOCIATE ON YA_SHOPPER.shopper_id = YA_ASSOCIATE.shopper_id
WHERE email=cEmail;

END sp_fe_asso_password;


PROCEDURE sp_fe_asso_payHistory
(
	cShopperId IN VARCHAR2,
	iSiteId IN INT,
	deciTotalCommision OUT FLOAT,
	cur_out1 OUT cur_return
) IS
BEGIN

OPEN cur_out1 FOR
SELECT TO_CHAR( pay_date, 'mm/dd/yy') AS payDate, amount_paid, cheque_num, pay_date
FROM YA_ASSOCIATE_PAY_HISTORY yaph, YA_ASSOCIATE ya
WHERE ya.associate_approved='Y' AND ya.shopper_id=cShopperId
AND ya.site_id = ISiteId
AND ya.associate_id = yaph.associate_id ORDER BY pay_date DESC;

SELECT SUM(amount_paid) INTO deciTotalCommision
FROM YA_ASSOCIATE_PAY_HISTORY yaph, YA_ASSOCIATE ya
WHERE ya.associate_approved='Y' AND ya.shopper_id=cShopperId
AND ya.site_id = ISiteId
AND ya.associate_id = yaph.associate_id;

END sp_fe_asso_payHistory;


PROCEDURE sp_fe_asso_login
(
	iSiteId IN INT,
	cEmail IN VARCHAR2,
	cPassword OUT VARCHAR2,
	iAssociateId OUT INT,
	cShopperId OUT VARCHAR2,
	cName OUT VARCHAR2,
	iLangId OUT INT,
	iRowAffected OUT INT
) IS
	TYPE typeAssoDetails IS RECORD(c_password VARCHAR2(255), i_associate_id INT, c_shopper_id VARCHAR2(32), c_name VARCHAR2(255), i_lang_id INT);
	ret_asso_details typeAssoDetails;
BEGIN

SELECT      YA_SHOPPER.PASSWORD, YA_ASSOCIATE.associate_id, YA_SHOPPER.shopper_id, YA_ASSOCIATE.contact_name, NVL(YA_ASSOCIATE.lang_id, 1) AS lang_id INTO ret_asso_details
FROM        YA_SHOPPER LEFT OUTER JOIN
                      YA_ASSOCIATE ON YA_ASSOCIATE.shopper_id = YA_SHOPPER.shopper_id
WHERE LOWER(YA_SHOPPER.email) = LOWER(cEmail) AND YA_ASSOCIATE.site_id=iSiteId AND YA_ASSOCIATE.associate_approved='Y' AND ROWNUM=1;

cPassword := ret_asso_details.c_password;
iAssociateId := ret_asso_details.i_associate_id;
cShopperId := ret_asso_details.c_shopper_id;
cName := ret_asso_details.c_name;
iLangId := ret_asso_details.i_lang_id;

iRowAffected := SQL%ROWCOUNT;


END sp_fe_asso_login;


PROCEDURE sp_fe_asso_getCreditSummary
(
	iAssociateId IN INT,
	cur_out1 OUT cur_return
) IS
	TYPE typeLegacyCreditDetails IS RECORD(deci_tot_legacy_credit FLOAT, deci_tot_legacy_credit_paid FLOAT);
	ret_legacy_credit_details typeLegacyCreditDetails;

	deciTotLegacyCredit FLOAT;
  	deciTotLegacyCreditPaid FLOAT;
	deciTotApprovedCredit FLOAT;
	deciTotApprovedCreditNew FLOAT;
	deciTotCreditPaid FLOAT;
	cCutOffDate VARCHAR2(10);
	deciTotNormalComm FLOAT;
	deciTotOverrideComm FLOAT;
BEGIN

cCutOffDate := '07/01/2005';

SELECT SUM(t1.total_credit),
         SUM(t1.total_credit_paid) INTO ret_legacy_credit_details
FROM YA_ASSOCIATE_LEGACY_HISTORY t1,
         YA_ASSOCIATE_LINK t2
WHERE t1.link_id = t2.link_id
     AND t2.associate_id = iAssociateId;

deciTotLegacyCredit := ret_legacy_credit_details.deci_tot_legacy_credit;
deciTotLegacyCreditPaid := ret_legacy_credit_details.deci_tot_legacy_credit_paid;

SELECT SUM(t1.credit_amount) INTO deciTotApprovedCredit
FROM YA_ASSOCIATE_LINK_ORDERS t1
WHERE t1.credit_status = 2 /* Approved */
	AND t1.last_change_date < TO_DATE(cCutOffDate, 'mm/dd/yyyy')
	AND t1.link_id IN (SELECT t2.link_id
			FROM YA_ASSOCIATE_LINK t2
			WHERE t2.associate_id = iAssociateId);

SELECT SUM(t1.amount_paid) INTO deciTotCreditPaid
FROM YA_ASSOCIATE_PAY_HISTORY t1
WHERE t1.associate_id = iAssociateId;

SELECT
	SUM((quantity * unit_price * comm_rate)) INTO deciTotApprovedCreditNew
FROM
	YA_ASSOCIATE_LINK_ORDERS lo, YA_ASSOCIATE_LINK l, YA_ASSOCIATE_COMMISSION_HIST ch
WHERE
	lo.link_id = l.link_id
	AND
	ch.associate_id = l.associate_id
	AND
	ch.valid_date = TO_DATE(TO_CHAR(lo.order_date, 'mm') || '/01/' || TO_CHAR(lo.order_date,'yyyy'), 'mm/dd/yyyy')
	AND
	(lo.last_change_date >= TO_DATE(cCutOffDate, 'mm/dd/yyyy'))
	AND
	l.associate_id = iAssociateId
	AND
	credit_status = 2;

SELECT SUM((credit_amount)) INTO deciTotOverrideComm
FROM
	YA_ASSOCIATE_LINK_ORDERS yalo
INNER JOIN
	YA_ASSOCIATE_LINK yal
ON
	yalo.link_id = yal.link_id
INNER JOIN
	YA_ASSOCIATE_COMMISSION_HIST yach
ON
	yach.associate_id = yal.associate_id AND
	yach.valid_date = TO_DATE(TO_CHAR(yalo.order_date, 'mm') || '/01/' || TO_CHAR(yalo.order_date,'yyyy'), 'mm/dd/yyyy')
WHERE
	(yalo.last_change_date >= TO_DATE(cCutOffDate, 'mm/dd/yyyy')) AND
	yal.associate_id = iAssociateId AND
	credit_status = 2 AND
	credit_amount IS NOT NULL;

SELECT  SUM((quantity * unit_price * comm_rate)) INTO deciTotNormalComm
FROM
	YA_ASSOCIATE_LINK_ORDERS yalo
INNER JOIN
	YA_ASSOCIATE_LINK yal
ON
	yalo.link_id = yal.link_id
INNER JOIN
	YA_ASSOCIATE_COMMISSION_HIST yach
ON
	yach.associate_id = yal.associate_id AND
	yach.valid_date = TO_DATE(TO_CHAR(yalo.order_date, 'mm') || '/01/' || TO_CHAR(yalo.order_date,'yyyy'), 'mm/dd/yyyy')
WHERE
	(yalo.last_change_date >= TO_DATE(cCutOffDate, 'mm/dd/yyyy')) AND
	yal.associate_id = iAssociateId AND
	credit_status = 2 AND
	credit_amount IS NULL;

deciTotApprovedCreditNew := NVL(deciTotOverrideComm,0) + NVL(deciTotNormalComm,0);

OPEN cur_out1 FOR
SELECT NVL(deciTotLegacyCredit ,0.0) -
	NVL(deciTotLegacyCreditPaid,0.0) +
	NVL(deciTotApprovedCredit,0.0) +
	NVL(deciTotApprovedCreditNew,0.0) -
	NVL(deciTotCreditPaid,0.0) AS outstanding_credit,
	NVL(deciTotLegacyCredit ,0.0) +
	NVL(deciTotApprovedCreditNew,0.0) +
	NVL(deciTotApprovedCredit,0.0) AS total_credits
FROM YA_ASSOCIATE
WHERE ROWNUM=1;

END sp_fe_asso_getCreditSummary;


PROCEDURE sp_fe_asso_createComm
(
	deci11 IN FLOAT,
	deci12 IN FLOAT,
	deci13 IN FLOAT,
	deci21 IN FLOAT,
	deci22 IN FLOAT,
	deci23 IN FLOAT,
	deci31 IN FLOAT,
	deci32 IN FLOAT,
	deci33 IN FLOAT,
	deci41 IN FLOAT,
	deci42 IN FLOAT,
	deci43 IN FLOAT,
	deci51 IN FLOAT,
	deci52 IN FLOAT,
	deci53 IN FLOAT,
	iAssocaiteId IN INT,
	iCommId OUT INT,
	iRowAffected OUT INT
) IS
	iId INT;
BEGIN

SELECT MAX(commission_id)+1 INTO iId FROM YA_ASSOCIATE_COMMISSION;

INSERT INTO YA_ASSOCIATE_COMMISSION (commission_id, commission_desc, created_date, updated_date,created_by, updated_by)
VALUES (iId, 'custom commission tier', (SYSDATE), (SYSDATE), 'system', 'system');

INSERT INTO YA_ASSOCIATE_COMMISSION_DETAIL (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 1, 1, deci11);

INSERT INTO YA_ASSOCIATE_COMMISSION_DETAIL (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 1, 2, deci12);

INSERT INTO YA_ASSOCIATE_COMMISSION_DETAIL (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 1, 3, deci13);

INSERT INTO YA_ASSOCIATE_COMMISSION_DETAIL (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 2, 1, deci21);

INSERT INTO YA_ASSOCIATE_COMMISSION_DETAIL (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 2, 2, deci22);

INSERT INTO YA_ASSOCIATE_COMMISSION_DETAIL (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 2, 3, deci23);

INSERT INTO YA_ASSOCIATE_COMMISSION_DETAIL (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 3, 1, deci31);

INSERT INTO YA_ASSOCIATE_COMMISSION_DETAIL (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 3, 2, deci32);

INSERT INTO YA_ASSOCIATE_COMMISSION_DETAIL (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 3, 3, deci33);

INSERT INTO YA_ASSOCIATE_COMMISSION_DETAIL (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 4, 1, deci41);

INSERT INTO YA_ASSOCIATE_COMMISSION_DETAIL (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 4, 2, deci42);

INSERT INTO YA_ASSOCIATE_COMMISSION_DETAIL (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 4, 3, deci43);

INSERT INTO YA_ASSOCIATE_COMMISSION_DETAIL (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 5, 1, deci51);

INSERT INTO YA_ASSOCIATE_COMMISSION_DETAIL (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 5, 2, deci52);

INSERT INTO YA_ASSOCIATE_COMMISSION_DETAIL (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 5, 3, deci53);

UPDATE YA_ASSOCIATE SET commission_id=iId WHERE associate_id = iAssocaiteId;

IF (SQLCODE!=0) THEN
	iRowAffected := 0;
	ROLLBACK;
ELSE
	iRowAffected := SQL%ROWCOUNT;
	iCommId := iId;
	COMMIT;
END IF;

END sp_fe_asso_createComm;


PROCEDURE sp_fe_asso_selImgLotLang
(
	iLotId IN INT,
	iLangId IN INT,
	cur_out1 OUT cur_return
) IS
	iTemp INT;
BEGIN

SELECT COUNT(*) INTO iTemp FROM YA_IMG_LOT_LANG WHERE image_lot_id=iLotId AND lang_id=iLangId AND NOT image_loc='';
IF (iTemp>0) THEN
	OPEN cur_out1 FOR
	SELECT * FROM YA_IMG_LOT_LANG WHERE image_lot_id=iLotId AND lang_id=iLangId AND NOT image_loc='';
ELSE
	OPEN cur_out1 FOR
	SELECT * FROM YA_IMG_LOT_LANG WHERE image_lot_id=iLotId AND preferred_flag='Y';
END IF;

END sp_fe_asso_selImgLotLang;


PROCEDURE sp_fe_asso_exportSales
(
	cMonth VARCHAR2,
	cYear VARCHAR2,
	iAssociateId INT,
	iLangId INT,
	iCreditStatus INT,
	cur_out1 OUT cur_return,
	cur_out2 OUT cur_return
) IS
	dtStartDate DATE;
	dtEndDate DATE;
BEGIN

dtStartDate := TO_DATE(cMonth || '/01/' || cYear, 'mm/dd/yyyy');
dtEndDate := ADD_MONTHS(dtStartDate, 1);

IF (iCreditStatus<>1) THEN
	OPEN cur_out1 FOR
	SELECT  TO_CHAR(order_date, 'mm/dd/yyyy') AS order_date, TO_CHAR(last_change_date, 'mm/dd/yyyy') AS posting_date, YA_PROD_LANG.prod_name_u AS prod_name, yalo.sku, SUM(yalo.quantity) AS items,
		SUM(yalo.unit_price * yalo.quantity) AS price, link_id,
	                      NVL(yg.group_id, 18) AS group_id
	FROM       (SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, yal.link_id, credit_amount
		 FROM YA_ASSOCIATE_LINK_ORDERS
		    INNER JOIN
		      (SELECT * FROM YA_ASSOCIATE_LINK WHERE associate_id=iAssociateId) yal
		    ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
		WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= dtStartDate) AND
	                                  (YA_ASSOCIATE_LINK_ORDERS.last_change_date <  dtEndDate) AND
	                 	               (credit_status = 2) AND (unit_price > 0)) yalo
		LEFT OUTER  JOIN
	                      YA_PRODUCT ON yalo.sku = YA_PRODUCT.sku LEFT OUTER  JOIN
	                      YA_PROD_LANG ON yalo.sku = YA_PROD_LANG.sku  LEFT OUTER  JOIN
		   (SELECT * FROM YA_GROUP WHERE division_id=1) yg
	                       ON yg.account_id = YA_PRODUCT.account_id
	WHERE      (YA_PROD_LANG.lang_id = iLangId)
	GROUP BY YA_PROD_LANG.prod_name_u,  yalo.sku, yg.group_id, link_id,
	TO_CHAR(order_date, 'mm/dd/yyyy'), TO_CHAR(last_change_date, 'mm/dd/yyyy')
	ORDER BY group_id, posting_date, prod_name;
END IF;

IF (iCreditStatus<>2) THEN
	IF (cur_out1 IS NOT NULL) THEN
		OPEN cur_out2 FOR
		SELECT  TO_CHAR(order_date, 'mm/dd/yyyy') AS order_date,
			TO_CHAR(last_change_date, 'mm/dd/yyyy') AS posting_date,
			YA_PROD_LANG.prod_name_u AS prod_name,
			yalo.sku,
			SUM(yalo.quantity) AS items,
			SUM(yalo.unit_price * yalo.quantity) AS price,
			link_id,
			NVL(yg.group_id, 18) AS group_id
		FROM
			(
			SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, yal.link_id
			FROM YA_ASSOCIATE_LINK_ORDERS
			INNER JOIN
				(
				SELECT * FROM YA_ASSOCIATE_LINK WHERE associate_id=iAssociateId
				) yal
			ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
			WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= dtStartDate) AND
				(YA_ASSOCIATE_LINK_ORDERS.last_change_date <  dtEndDate) AND
				(credit_status = 1) AND (unit_price > 0)
			) yalo
		LEFT OUTER  JOIN
			YA_PRODUCT
			ON yalo.sku = YA_PRODUCT.sku
		LEFT OUTER  JOIN
			YA_PROD_LANG
			ON yalo.sku = YA_PROD_LANG.sku
		LEFT OUTER  JOIN
			(
			SELECT * FROM YA_GROUP WHERE division_id=1
			) yg
			ON yg.account_id = YA_PRODUCT.account_id
		WHERE      (YA_PROD_LANG.lang_id = iLangId)
		GROUP BY YA_PROD_LANG.prod_name_u,  yalo.sku, yg.group_id, link_id,
		TO_CHAR(order_date, 'mm/dd/yyyy'), TO_CHAR(last_change_date, 'mm/dd/yyyy')
		ORDER BY group_id, posting_date, prod_name;
	ELSE
		OPEN cur_out1 FOR
		SELECT  TO_CHAR(order_date, 'mm/dd/yyyy') AS order_date, TO_CHAR(last_change_date, 'mm/dd/yyyy') AS posting_date, YA_PROD_LANG.prod_name_u AS prod_name, yalo.sku, SUM(yalo.quantity) AS items,
			SUM(yalo.unit_price * yalo.quantity) AS price, link_id,
		                      NVL(yg.group_id, 18) AS group_id
		FROM       (SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, yal.link_id
			 FROM YA_ASSOCIATE_LINK_ORDERS
			    INNER JOIN
			      (SELECT * FROM YA_ASSOCIATE_LINK WHERE associate_id=iAssociateId) yal
			    ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
			WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= dtStartDate) AND
		                                  (YA_ASSOCIATE_LINK_ORDERS.last_change_date <  dtEndDate) AND
		                 	               (credit_status = 1) AND (unit_price > 0)) yalo
			LEFT OUTER  JOIN
		                      YA_PRODUCT ON yalo.sku = YA_PRODUCT.sku LEFT OUTER  JOIN
		                      YA_PROD_LANG ON yalo.sku = YA_PROD_LANG.sku  LEFT OUTER  JOIN
			   (SELECT * FROM YA_GROUP WHERE division_id=1) yg
		                       ON yg.account_id = YA_PRODUCT.account_id
		WHERE      (YA_PROD_LANG.lang_id = iLangId)
		GROUP BY YA_PROD_LANG.prod_name_u,  yalo.sku, yg.group_id, link_id,
		TO_CHAR(order_date, 'mm/dd/yyyy'), TO_CHAR(last_change_date, 'mm/dd/yyyy')
		ORDER BY group_id, posting_date, prod_name;
	END IF;
END IF;
END sp_fe_asso_exportSales;


PROCEDURE sp_fe_asso_monthlyCredit
(
	iAssociateId IN INT,
	deciPercentage OUT FLOAT,
	deciOldPercentage OUT FLOAT,
	deciLastApproved OUT FLOAT,
	cur_out1 OUT cur_return,
	cur_out2 OUT cur_return
) IS
	iCustomer INT;
	cStartDate VARCHAR2(10);
	cEndDate VARCHAR2(10);
	dtDate DATE;
   iCount INT;
BEGIN

OPEN cur_out1 FOR
SELECT
	associate_id,
	SUM(commission) AS credit_amount,
	order_month AS MONTH,
	order_year AS YEAR,
	TO_CHAR(order_month) || '/' || TO_CHAR(order_year) AS order_date, credit_status
FROM
	(SELECT
		yalo.associate_id, credit_status,
		TO_NUMBER(TO_CHAR(last_change_date,'fmmm')) AS order_month,
		TO_NUMBER(TO_CHAR(last_change_date, 'yyyy')) AS order_year,
		SUM(NVL(yalo.unit_price, 0) * NVL(yalo.quantity, 0)) * NVL(comm_rate, (SELECT link_percentage  FROM YA_ASSOCIATE_LINK WHERE (associate_id=iAssociateId) AND (ROWNUM=1)))  AS commission
	FROM
		(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, associate_id
		 FROM YA_ASSOCIATE_LINK_ORDERS INNER JOIN
			(SELECT * FROM YA_ASSOCIATE_LINK WHERE associate_id=iAssociateId) yal
			ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
		WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= ADD_MONTHS(SYSDATE, -11) AND YA_ASSOCIATE_LINK_ORDERS.Credit_status = 2)) yalo
			LEFT OUTER JOIN YA_ASSOCIATE_COMMISSION_HIST yach ON yach.associate_id=iAssociateId
			AND yach.valid_date = TO_DATE(TO_CHAR(order_date, 'mm') || '/01/' || TO_CHAR(order_date, 'yyyy'), 'mm/dd/yyyy')
	GROUP BY yalo.associate_id, last_change_date, comm_rate, credit_status
	) yar
GROUP BY yar.credit_status,
	TO_CHAR(order_month) || '/' || TO_CHAR(order_year),
	order_month,
	order_year,
	yar.associate_id
ORDER BY order_year, order_month;

OPEN cur_out2 FOR
SELECT
	associate_id,
	SUM(NVL(commission, 0)) AS credit_amount,
	order_month AS MONTH,
	order_year AS YEAR,
	TO_CHAR(order_month) || '/' || TO_CHAR(order_year) AS order_date, credit_status
FROM
	(SELECT
		yalo.associate_id, credit_status,
		TO_NUMBER(TO_CHAR(order_date, 'fmmm')) AS order_month,
		TO_NUMBER(TO_CHAR(order_date, 'yyyy')) AS order_year,
		SUM(NVL(yalo.unit_price, 0) * NVL(yalo.quantity, 0)) * NVL(comm_rate, (SELECT link_percentage  FROM YA_ASSOCIATE_LINK WHERE (associate_id=iAssociateId) AND (ROWNUM=1)))  AS commission
	FROM
		(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, associate_id
		 FROM YA_ASSOCIATE_LINK_ORDERS INNER JOIN
			      (SELECT * FROM YA_ASSOCIATE_LINK WHERE associate_id=iAssociateId) yal
			    ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
		WHERE (YA_ASSOCIATE_LINK_ORDERS.order_date >= ADD_MONTHS(SYSDATE, -11) AND YA_ASSOCIATE_LINK_ORDERS.Credit_status <>2)) yalo
		LEFT OUTER JOIN YA_ASSOCIATE_COMMISSION_HIST yach ON yach.associate_id =iAssociateId
                  AND yach.valid_date = TO_DATE(TO_CHAR(order_date, 'mm') || '/01/' || TO_CHAR(order_date, 'yyyy'), 'mm/dd/yyyy')
	GROUP BY yalo.associate_id,order_date, comm_rate, credit_status
	) yar
GROUP BY yar.credit_status,
	TO_CHAR(order_month) || '/' || TO_CHAR(order_year),
	order_month,
	order_year,
	yar.associate_id
ORDER BY order_year, order_month;

dtDate := (SYSDATE);

cStartDate := TO_CHAR(dtDate, 'mm') || '/01/' || TO_CHAR(dtDate, 'yyyy');
dtDate := ADD_MONTHS(dtDate, 1);
cEndDate := TO_CHAR(dtDate, 'mm') || '/01/' || TO_CHAR(dtDate, 'yyyy');

SELECT COUNT(customerId) INTO iCustomer
FROM DM_NEW_SHOPPER
WHERE DM_NEW_SHOPPER.validorder='Y'
AND DM_NEW_SHOPPER.feorderid IN
	(SELECT DISTINCT TO_CHAR(order_num) AS orderId
	FROM YA_ASSOCIATE_LINK_ORDERS INNER JOIN
		(SELECT link_id FROM YA_ASSOCIATE_LINK WHERE associate_id=iAssociateId) yal
		ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
	WHERE order_date >= TO_DATE(cStartDate, 'mm/dd/yyyy') AND order_date < TO_DATE(cEndDate, 'mm/dd/yyyy') AND credit_status <> 4);

dbms_output.put_line(iCustomer);

SELECT COUNT(1) INTO iCount
FROM YA_ASSOCIATE_COMMISSION_DETAIL cd INNER JOIN
	(SELECT comm_type_id, nc_max FROM YA_ASSOCIATE_COMMISSION_TYPE ct WHERE ((nc_min <= iCustomer AND nc_max >= iCustomer) OR nc_max < iCustomer)) ct
	ON ct.comm_type_id =cd.comm_type_id
	 INNER JOIN (SELECT commission_id, payment_option FROM YA_ASSOCIATE WHERE associate_id=iAssociateId) ya
	ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option;
IF (iCount>0) THEN
   SELECT percentage INTO deciPercentage
   FROM YA_ASSOCIATE_COMMISSION_DETAIL cd INNER JOIN
      (SELECT comm_type_id, nc_max FROM YA_ASSOCIATE_COMMISSION_TYPE ct WHERE ((nc_min <= iCustomer AND nc_max >= iCustomer) OR nc_max < iCustomer)) ct
      ON ct.comm_type_id =cd.comm_type_id
       INNER JOIN (SELECT commission_id, payment_option FROM YA_ASSOCIATE WHERE associate_id=iAssociateId) ya
      ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
   WHERE ROWNUM=1;
   dbms_output.put_line(deciPercentage);
   dbms_output.put_line(TO_CHAR(deciPercentage));
   dbms_output.put_line(SYSDATE);
ELSE
	SELECT percentage INTO deciPercentage
	FROM YA_ASSOCIATE_COMMISSION_DETAIL cd INNER JOIN
		(SELECT comm_type_id, nc_max FROM YA_ASSOCIATE_COMMISSION_TYPE ct WHERE nc_min <= iCustomer) ct
		ON ct.comm_type_id =cd.comm_type_id
		 INNER JOIN (SELECT commission_id, payment_option FROM YA_ASSOCIATE WHERE associate_id=iAssociateId) ya
		ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
   WHERE ROWNUM=1;
END IF;
/*
IF deciPercentage IS null THEN
	SELECT percentage INTO deciPercentage
	FROM ya_associate_commission_detail cd INNER JOIN
		(SELECT comm_type_id, nc_max FROM ya_associate_commission_type ct WHERE nc_min <= iCustomer ) ct
		ON ct.comm_type_id =cd.comm_type_id
		 INNER JOIN (SELECT commission_id, payment_option FROM ya_associate WHERE associate_id=iAssociateId) ya
		ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option;
END IF;
*/
SELECT link_percentage INTO deciOldPercentage FROM YA_ASSOCIATE_LINK WHERE (associate_id=iAssociateId) AND (ROWNUM=1);


SELECT SUM(commission) INTO deciLastApproved
FROM (
	SELECT  (
   /*
		sum(
			yalo.unit_price * yalo.quantity
		       )
		      *
			nvl (
				comm_rate,
				nvl(
					percentage,
					(SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = iAssociateId AND rownum=1)
				)
			)
		)
      */
      SUM(NVL(credit_amount, yalo.unit_price*yalo.quantity*NVL(comm_rate, NVL(percentage, (SELECT comm_rate FROM YA_ASSOCIATE_COMMISSION_HIST WHERE associate_id = iAssociateId AND ROWNUM=1)))))
   )
		  AS commission
	FROM (
		SELECT order_date, last_change_date, sku, NVL(quantity, 0) AS quantity, NVL(unit_price, 0) AS unit_price, credit_status, credit_amount
		FROM YA_ASSOCIATE_LINK_ORDERS
			INNER JOIN
			(
			SELECT * FROM YA_ASSOCIATE_LINK WHERE associate_id=iAssociateId
			) yal
			  ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
		WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
	                                  (YA_ASSOCIATE_LINK_ORDERS.last_change_date < TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
	                 	               (credit_status = 2)
	            ) yalo
		LEFT OUTER JOIN YA_ASSOCIATE_COMMISSION_HIST yach ON yach.associate_id = iAssociateId
		AND yach.valid_date = TO_DATE(TO_CHAR(order_date, 'mm') || '/01/' ||TO_CHAR(order_date, 'yyyy'),'mm/dd/yyyy'),
		(SELECT percentage  FROM YA_ASSOCIATE_COMMISSION_DETAIL cd INNER JOIN
		(SELECT comm_type_id, nc_max FROM YA_ASSOCIATE_COMMISSION_TYPE ct WHERE ((nc_min <= iCustomer AND nc_max >= iCustomer) OR nc_max < iCustomer) ORDER BY nc_min DESC) ct
	ON ct.comm_type_id =cd.comm_type_id
	 INNER JOIN (SELECT commission_id, payment_option FROM YA_ASSOCIATE WHERE associate_id=iAssociateId) ya
	ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option WHERE ROWNUM=1)t
GROUP BY TO_NUMBER(TO_CHAR(order_date, 'mm')), TO_NUMBER(TO_CHAR(order_date, 'yyyy')) , comm_rate, t.percentage) a;


END sp_fe_asso_monthlyCredit;


PROCEDURE sp_fe_asso_selOrderByAid
(
	cMonth IN VARCHAR2,
	cYear IN VARCHAR2,
	iAssociateId IN INT,
	tiLangId IN INT,
	iCreditStatus IN INT,
	iNeedGroup IN INT,
	iNeedLinkInfo IN INT,
	iBestSeller IN INT,
	iCustomer OUT INT,
	deciPercentage OUT FLOAT,
	iNextLevel OUT INT,
	iLangId OUT INT,
	deciThisPeriodComm OUT FLOAT,
	deciTotalComm OUT FLOAT,
	cur_out01 OUT cur_return,
	cur_out02 OUT cur_return,
	cur_out03 OUT cur_return,
	cur_out04 OUT cur_return,
	cur_out05 OUT cur_return,
	cur_out06 OUT cur_return,
	cur_out07 OUT cur_return,
	cur_out08 OUT cur_return,
	cur_out09 OUT cur_return,
	cur_out10 OUT cur_return,
	cur_out11 OUT cur_return,
	cur_out12 OUT cur_return,
	cur_out13 OUT cur_return,
	cur_out14 OUT cur_return
) IS

	cStartDate VARCHAR(10);
	cEndDate VARCHAR(10);
	cCutOffDate VARCHAR(10);

	TYPE typePercentageNextLevel IS RECORD(percentage FLOAT, next_level INT);
	ret_percentage_next_level typePercentageNextLevel;

	cur_temp01 cur_return;
	cur_temp02 cur_return;
	cur_temp03 cur_return;
	cur_temp04 cur_return;
	cur_temp05 cur_return;
	cur_temp06 cur_return;
	cur_temp07 cur_return;
	cur_temp08 cur_return;
	cur_temp09 cur_return;
	cur_temp10 cur_return;
	cur_temp11 cur_return;
	cur_temp12 cur_return;
	cur_temp13 cur_return;
	cur_temp14 cur_return;

BEGIN

cStartDate := cMonth || '/01/' || cYear;
cEndDate := TO_CHAR(ADD_MONTHS(TO_DATE(cStartDate, 'mm/dd/yyyy'), 1), 'mm/dd/yyyy');
cCutOffDate := '07/01/2005';


SELECT COUNT(customerId) INTO iCustomer
FROM DM_NEW_SHOPPER
WHERE DM_NEW_SHOPPER.validOrder = 'Y'
	AND DM_NEW_SHOPPER.feOrderId IN
	(SELECT  DISTINCT TO_CHAR(order_num) AS orderId
	FROM
		(SELECT *
		FROM YA_ASSOCIATE_LINK_ORDERS
		WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)) YA_ASSOCIATE_LINK_ORDERS
	INNER JOIN
		(SELECT link_id
		FROM YA_ASSOCIATE_LINK
		WHERE associate_id=iAssociateId) yal
	ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
	WHERE order_date >= TO_DATE(cStartDate, 'mm/dd/yyyy') AND order_date < TO_DATE(cEndDate, 'mm/dd/yyyy') AND credit_status <> 4);


IF (TO_DATE(cStartDate, 'mm/dd/yyyy') < TO_DATE(cCutOffDate, 'mm/dd/yyyy')) THEN
	SELECT link_percentage INTO deciPercentage FROM YA_ASSOCIATE_LINK WHERE associate_id=iAssociateId AND ROWNUM=1 ORDER BY link_id ASC;
	iNextLevel := 0;
ELSE
   SELECT comm_rate, 0 INTO ret_percentage_next_level FROM YA_ASSOCIATE_COMMISSION_HIST ach WHERE valid_date = TO_DATE(cStartDate, 'mm/dd/yyyy') AND associate_id = iAssociateId AND ROWNUM = 1;
	deciPercentage := ret_percentage_next_level.percentage;
	iNextLevel := ret_percentage_next_level.next_level;

	IF (deciPercentage IS NULL) THEN
		SELECT percentage, nc_max + 1 - iCustomer INTO ret_percentage_next_level
		FROM YA_ASSOCIATE_COMMISSION_DETAIL cd INNER JOIN
				(SELECT comm_type_id, nc_max
				FROM YA_ASSOCIATE_COMMISSION_TYPE ct
				WHERE nc_min <= iCustomer ) ct
			ON ct.comm_type_id =cd.comm_type_id
			 INNER JOIN (SELECT commission_id, payment_option
				FROM YA_ASSOCIATE
				WHERE associate_id=iAssociateId) ya
		ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option AND ROWNUM = 1;

   ELSE
		SELECT deciPercentage, nc_max + 1 - iCustomer INTO ret_percentage_next_level
		FROM YA_ASSOCIATE_COMMISSION_DETAIL cd INNER JOIN
				(SELECT comm_type_id, nc_max
				FROM YA_ASSOCIATE_COMMISSION_TYPE ct
				WHERE nc_min <= iCustomer ) ct
			ON ct.comm_type_id =cd.comm_type_id
			 INNER JOIN (SELECT commission_id, payment_option
				FROM YA_ASSOCIATE
				WHERE associate_id=iAssociateId) ya
		ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option AND ROWNUM = 1;
	END IF;
	deciPercentage := ret_percentage_next_level.percentage;
	iNextLevel := ret_percentage_next_level.next_level;
END IF;

/*use new comm %*/
SELECT SUM(NVL(credit_amount,unit_price * quantity * deciPercentage)) INTO deciTotalComm
FROM YA_ASSOCIATE_LINK_ORDERS
WHERE
	(last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
	(last_change_date < TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
	link_id IN (SELECT link_id FROM YA_ASSOCIATE_LINK WHERE associate_id=iAssociateId) AND
	credit_status = 2;

SELECT SUM(NVL(credit_amount,unit_price * quantity * NVL(deciPercentage,0))) INTO deciThisPeriodComm
FROM YA_ASSOCIATE_LINK_ORDERS
WHERE
	(last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
	(last_change_date < TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
	order_date >= TO_DATE(cStartDate, 'mm/dd/yyyy') AND order_date < TO_DATE(cEndDate, 'mm/dd/yyyy') AND
	link_id IN (SELECT link_id FROM YA_ASSOCIATE_LINK WHERE associate_id=iAssociateId) AND
	credit_status = 2;


IF (iNeedGroup = 1) THEN
	IF (iCreditStatus <> 1) THEN

		OPEN cur_out01 FOR
		SELECT  TO_CHAR(order_date, 'mm/dd/yyyy') AS order_date, TO_CHAR(last_change_date, 'mm/dd/yyyy') AS posting_date,
			CASE
				WHEN (YA_PROD_LANG.prod_name_u IS NULL OR YA_PROD_LANG.prod_name_u = '')
				THEN (SELECT prod_name_u FROM YA_PROD_LANG WHERE sku=yalo.sku AND lang_id = 1)
				ELSE YA_PROD_LANG.prod_name_u
				END
			AS prod_name,
			yalo.sku, SUM(yalo.quantity) AS items,
			SUM(yalo.unit_price * yalo.quantity) AS price, yalo.link_id,
			yg.group_id
		FROM
			(SELECT order_date, last_change_date, sku, NVL(quantity, 0) AS quantity, NVL(unit_price, 0) AS unit_price, credit_status, yal.link_id
			FROM
				(SELECT *
				FROM YA_ASSOCIATE_LINK_ORDERS
				WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) YA_ASSOCIATE_LINK_ORDERS
			INNER JOIN
				(SELECT *
				FROM YA_ASSOCIATE_LINK
				WHERE associate_id=iAssociateId
				) yal
			ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
			WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
				(YA_ASSOCIATE_LINK_ORDERS.last_change_date <  TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (unit_price > 0)) yalo
		LEFT OUTER  JOIN
			YA_PRODUCT ON yalo.sku = YA_PRODUCT.sku
		LEFT OUTER  JOIN
			YA_PROD_LANG ON yalo.sku = YA_PROD_LANG.sku
		LEFT OUTER  JOIN
			(SELECT * FROM YA_GROUP WHERE division_id=1) yg
			ON yg.account_id = YA_PRODUCT.account_id
		WHERE      (YA_PROD_LANG.lang_id = tiLangId)
		GROUP BY YA_PROD_LANG.prod_name_u,  yalo.sku, yg.group_id, link_id,
			TO_CHAR(order_date, 'mm/dd/yyyy'), TO_CHAR(last_change_date, 'mm/dd/yyyy')
		ORDER BY group_id, posting_date, prod_name;

		OPEN cur_out02 FOR
		SELECT DISTINCT yg.group_id
		FROM
			(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status
			FROM
				(SELECT *
				FROM YA_ASSOCIATE_LINK_ORDERS
				WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) YA_ASSOCIATE_LINK_ORDERS
			INNER JOIN
				(SELECT *
				FROM YA_ASSOCIATE_LINK
				WHERE associate_id=iAssociateId
				) yal
			ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
			WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
				(YA_ASSOCIATE_LINK_ORDERS.last_change_date <  TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (unit_price > 0)) yalo
		LEFT OUTER  JOIN
			YA_PRODUCT ON yalo.sku = YA_PRODUCT.sku
		LEFT OUTER  JOIN
			(SELECT * FROM YA_GROUP WHERE division_id=1) yg
			ON yg.account_id = YA_PRODUCT.account_id;
	END IF;

	IF (iCreditStatus <>2) THEN
		OPEN cur_temp03 FOR
		SELECT   TO_CHAR(yalo.order_date, 'mm/dd/yyyy') AS order_date,
			CASE
				WHEN (YA_PROD_LANG.prod_name_u IS NULL OR YA_PROD_LANG.prod_name_u = '')
				THEN (SELECT prod_name_u FROM YA_PROD_LANG WHERE sku=yalo.sku AND lang_id = 1)
				ELSE YA_PROD_LANG.prod_name_u
				END
			AS prod_name, yalo.sku,
			SUM(yalo.quantity) AS items,
			SUM(yalo.unit_price * yalo.quantity) AS price, link_id,
			yg.group_id
		FROM
			(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, YA_ASSOCIATE_LINK_ORDERS.link_id
			FROM
				(SELECT *
				FROM YA_ASSOCIATE_LINK_ORDERS
				WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) YA_ASSOCIATE_LINK_ORDERS
			INNER JOIN
				(SELECT *
				FROM YA_ASSOCIATE_LINK
				WHERE associate_id=iAssociateId
				) yal
			ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
			WHERE (YA_ASSOCIATE_LINK_ORDERS.order_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
				(YA_ASSOCIATE_LINK_ORDERS.order_date < TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 1) AND (unit_price > 0)
			) yalo
		LEFT OUTER  JOIN
			YA_PRODUCT ON yalo.sku = YA_PRODUCT.sku
		LEFT OUTER  JOIN
			YA_PROD_LANG ON yalo.sku = YA_PROD_LANG.sku
		LEFT OUTER  JOIN
			(SELECT * FROM YA_GROUP WHERE division_id=1) yg
		ON yg.account_id = YA_PRODUCT.account_id
		WHERE      (YA_PROD_LANG.lang_id = tiLangId OR YA_PROD_LANG.lang_id = 1)
		GROUP BY YA_PROD_LANG.prod_name_u,  yalo.sku, yg.group_id, order_date, link_id
		ORDER BY group_id, order_date, prod_name;

		IF (cur_out01 IS NULL) THEN
			cur_out01 := cur_temp03;
		ELSIF (cur_out02 IS NULL) THEN
			cur_out02 := cur_temp03;
		ELSIF (cur_out03 IS NULL) THEN
			cur_out03 := cur_temp03;
		ELSIF (cur_out04 IS NULL) THEN
			cur_out04 := cur_temp03;
		ELSIF (cur_out05 IS NULL) THEN
			cur_out05 := cur_temp03;
		ELSIF (cur_out06 IS NULL) THEN
			cur_out06 := cur_temp03;
		ELSIF (cur_out07 IS NULL) THEN
			cur_out07 := cur_temp03;
		ELSIF (cur_out08 IS NULL) THEN
			cur_out08 := cur_temp03;
		ELSIF (cur_out09 IS NULL) THEN
			cur_out09 := cur_temp03;
		ELSIF (cur_out10 IS NULL) THEN
			cur_out10 := cur_temp03;
		ELSE
			cur_out11 := cur_temp03;
		END IF;

		OPEN cur_temp04 FOR
		SELECT    DISTINCT  yg.group_id
		FROM
			(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status
			FROM
				(SELECT *
				FROM YA_ASSOCIATE_LINK_ORDERS
				WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) YA_ASSOCIATE_LINK_ORDERS
			INNER JOIN
				(SELECT *
				FROM YA_ASSOCIATE_LINK
				WHERE associate_id=iAssociateId
				) yal
			ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
			WHERE (YA_ASSOCIATE_LINK_ORDERS.order_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
				(YA_ASSOCIATE_LINK_ORDERS.order_date <  TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 1) AND (unit_price > 0)
			) yalo
		LEFT OUTER  JOIN
			YA_PRODUCT ON yalo.sku = YA_PRODUCT.sku
		LEFT OUTER  JOIN
			(SELECT * FROM YA_GROUP WHERE division_id=1) yg
		ON yg.account_id = YA_PRODUCT.account_id;

		IF (cur_out01 IS NULL) THEN
			cur_out01 := cur_temp04;
		ELSIF (cur_out02 IS NULL) THEN
			cur_out02 := cur_temp04;
		ELSIF (cur_out03 IS NULL) THEN
			cur_out03 := cur_temp04;
		ELSIF (cur_out04 IS NULL) THEN
			cur_out04 := cur_temp04;
		ELSIF (cur_out05 IS NULL) THEN
			cur_out05 := cur_temp04;
		ELSIF (cur_out06 IS NULL) THEN
			cur_out06 := cur_temp04;
		ELSIF (cur_out07 IS NULL) THEN
			cur_out07 := cur_temp04;
		ELSIF (cur_out08 IS NULL) THEN
			cur_out08 := cur_temp04;
		ELSIF (cur_out09 IS NULL) THEN
			cur_out09 := cur_temp04;
		ELSIF (cur_out10 IS NULL) THEN
			cur_out10 := cur_temp04;
		ELSIF (cur_out11 IS NULL) THEN
			cur_out11 := cur_temp04;
		ELSIF (cur_out12 IS NULL) THEN
			cur_out12 := cur_temp04;
		ELSIF (cur_out13 IS NULL) THEN
			cur_out13 := cur_temp04;
		ELSIF (cur_out14 IS NULL) THEN
			cur_out14 := cur_temp04;
		ELSE
			cur_out14 := cur_temp04;
		END IF;

		OPEN cur_temp05 FOR
		SELECT    SUM(yalo.quantity) AS items,
			SUM(yalo.unit_price * yalo.quantity) AS price
		FROM
			(SELECT order_date, last_change_date, sku, NVL(quantity, 0) AS quantity, NVL(unit_price, 0) AS unit_price, credit_status
			FROM
				(SELECT *
				FROM YA_ASSOCIATE_LINK_ORDERS
				WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) YA_ASSOCIATE_LINK_ORDERS
			INNER JOIN
				(SELECT *
				FROM YA_ASSOCIATE_LINK
				WHERE associate_id=iAssociateId
				) yal
			ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
			WHERE (YA_ASSOCIATE_LINK_ORDERS.order_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
		                                  (YA_ASSOCIATE_LINK_ORDERS.order_date <  TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
		                 	               (credit_status =1) AND (unit_price > 0)
			) yalo
		GROUP BY TO_NUMBER(TO_CHAR(order_date, 'fmmm'));

		IF (cur_out01 IS NULL) THEN
			cur_out01 := cur_temp05;
		ELSIF (cur_out02 IS NULL) THEN
			cur_out02 := cur_temp05;
		ELSIF (cur_out03 IS NULL) THEN
			cur_out03 := cur_temp05;
		ELSIF (cur_out04 IS NULL) THEN
			cur_out04 := cur_temp05;
		ELSIF (cur_out05 IS NULL) THEN
			cur_out05 := cur_temp05;
		ELSIF (cur_out06 IS NULL) THEN
			cur_out06 := cur_temp05;
		ELSIF (cur_out07 IS NULL) THEN
			cur_out07 := cur_temp05;
		ELSIF (cur_out08 IS NULL) THEN
			cur_out08 := cur_temp05;
		ELSIF (cur_out09 IS NULL) THEN
			cur_out09 := cur_temp05;
		ELSIF (cur_out10 IS NULL) THEN
			cur_out10 := cur_temp05;
		ELSIF (cur_out11 IS NULL) THEN
			cur_out11 := cur_temp05;
		ELSIF (cur_out12 IS NULL) THEN
			cur_out12 := cur_temp05;
		ELSIF (cur_out13 IS NULL) THEN
			cur_out13 := cur_temp05;
		ELSIF (cur_out14 IS NULL) THEN
			cur_out14 := cur_temp05;
		ELSE
			cur_out14 := cur_temp05;
		END IF;

	END IF;

	IF (TO_DATE(cStartDate, 'mm/dd/yyyy') < TO_DATE(cCutOffDate, 'mm/dd/yyyy')) THEN
		OPEN cur_temp06 FOR
		SELECT    SUM(yalo.quantity) AS items,
			SUM(yalo.unit_price * yalo.quantity) AS price,
			TO_NUMBER(TO_CHAR(order_date,'fmmm')) AS posting_month,
			TO_NUMBER(TO_CHAR(order_date,'yyyy')) AS posting_year,
			(SELECT link_percentage FROM YA_ASSOCIATE_LINK WHERE associate_id=iAssociateId AND ROWNUM=1) AS percentage,
			--sum(yalo.unit_price * yalo.quantity) * (SELECT link_percentage FROM ya_associate_link WHERE associate_id=iAssociateId AND rownum = 1)  AS commission
			SUM(NVL(yalo.credit_amount, yalo.unit_price * yalo.quantity* NVL(comm_rate, NVL(percentage, (SELECT comm_rate FROM YA_ASSOCIATE_COMMISSION_HIST WHERE associate_id = 8050 AND ROWNUM=1))))) AS commission
		FROM
			(SELECT order_date, last_change_date, sku,NVL(quantity, 0) AS quantity, NVL(unit_price, 0) AS unit_price, credit_status, credit_amount
			FROM
				(SELECT *
				FROM YA_ASSOCIATE_LINK_ORDERS
				WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) YA_ASSOCIATE_LINK_ORDERS
			INNER JOIN
				(SELECT *
				FROM YA_ASSOCIATE_LINK
				WHERE associate_id=iAssociateId
				) yal
			ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
			WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
				(YA_ASSOCIATE_LINK_ORDERS.last_change_date < TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (unit_price > 0)
			) yalo
			LEFT OUTER JOIN YA_ASSOCIATE_COMMISSION_HIST yach ON yach.associate_id = iAssociateId
				AND yach.valid_date = TO_DATE(TO_CHAR(order_date, 'mm') || '/01/' || TO_CHAR(order_date, 'yyyy'), 'mm/dd/yyyy'),
				(SELECT percentage
				FROM YA_ASSOCIATE_COMMISSION_DETAIL cd
				INNER JOIN
					(SELECT comm_type_id, nc_max
					FROM YA_ASSOCIATE_COMMISSION_TYPE ct
               WHERE ((nc_min <=iCustomer AND nc_max >=iCustomer) OR (nc_max < iCustomer))
               ORDER BY nc_min DESC
					) ct
				ON ct.comm_type_id =cd.comm_type_id
				INNER JOIN
					(SELECT commission_id, payment_option
					FROM YA_ASSOCIATE
					WHERE associate_id=iAssociateId
					) ya
				ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
            WHERE ROWNUM=1
				)t
		GROUP BY TO_NUMBER(TO_CHAR(order_date,'fmmm')), TO_NUMBER(TO_CHAR(order_date, 'yyyy')) , comm_rate, t.percentage;

		IF (cur_out01 IS NULL) THEN
			cur_out01 := cur_temp06;
		ELSIF (cur_out02 IS NULL) THEN
			cur_out02 := cur_temp06;
		ELSIF (cur_out03 IS NULL) THEN
			cur_out03 := cur_temp06;
		ELSIF (cur_out04 IS NULL) THEN
			cur_out04 := cur_temp06;
		ELSIF (cur_out05 IS NULL) THEN
			cur_out05 := cur_temp06;
		ELSIF (cur_out06 IS NULL) THEN
			cur_out06 := cur_temp06;
		ELSIF (cur_out07 IS NULL) THEN
			cur_out07 := cur_temp06;
		ELSIF (cur_out08 IS NULL) THEN
			cur_out08 := cur_temp06;
		ELSIF (cur_out09 IS NULL) THEN
			cur_out09 := cur_temp06;
		ELSIF (cur_out10 IS NULL) THEN
			cur_out10 := cur_temp06;
		ELSIF (cur_out11 IS NULL) THEN
			cur_out11 := cur_temp06;
		ELSIF (cur_out12 IS NULL) THEN
			cur_out12 := cur_temp06;
		ELSIF (cur_out13 IS NULL) THEN
			cur_out13 := cur_temp06;
		ELSIF (cur_out14 IS NULL) THEN
			cur_out14 := cur_temp06;
		ELSE
			cur_out14 := cur_temp06;
		END IF;
	ELSE
		OPEN cur_temp07 FOR
		SELECT    SUM(yalo.quantity) AS items,
			SUM(yalo.unit_price * yalo.quantity) AS price,
			TO_NUMBER(TO_CHAR(order_date, 'fmmm')) AS posting_month,
			TO_NUMBER(TO_CHAR(order_date, 'yyyy')) AS posting_year,
			NVL(comm_rate, NVL(percentage, (SELECT comm_rate FROM YA_ASSOCIATE_COMMISSION_HIST WHERE associate_id = iAssociateId AND ROWNUM=1))) AS percentage,
			--sum(yalo.unit_price * yalo.quantity) * nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = iAssociateId AND rownum=1)))  AS commission
			SUM(NVL(yalo.credit_amount, yalo.unit_price * yalo.quantity* NVL(comm_rate, NVL(percentage, (SELECT comm_rate FROM YA_ASSOCIATE_COMMISSION_HIST WHERE associate_id = 8050 AND ROWNUM=1))))) AS commission
		FROM
			(SELECT order_date, last_change_date, sku, NVL(quantity, 0) AS quantity, NVL(unit_price, 0) AS unit_price, credit_status, credit_amount
			FROM
				(SELECT *
				FROM YA_ASSOCIATE_LINK_ORDERS
				WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) YA_ASSOCIATE_LINK_ORDERS
			INNER JOIN
				(SELECT *
				FROM YA_ASSOCIATE_LINK
				WHERE associate_id=iAssociateId
				) yal
			ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
			WHERE
				(YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
				(YA_ASSOCIATE_LINK_ORDERS.last_change_date < TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (unit_price > 0)
			) yalo
		LEFT OUTER JOIN YA_ASSOCIATE_COMMISSION_HIST yach ON yach.associate_id = iAssociateId
			AND yach.valid_date = TO_DATE(TO_CHAR(order_date, 'mm') || '/01/' || TO_CHAR(order_date, 'yyyy'), 'mm/dd/yyyy'),
			(SELECT percentage
			FROM YA_ASSOCIATE_COMMISSION_DETAIL cd
			INNER JOIN
				(SELECT comm_type_id, 	nc_max
				FROM YA_ASSOCIATE_COMMISSION_TYPE ct
				WHERE ((nc_min <=iCustomer AND nc_max >=iCustomer) OR (nc_max < iCustomer))
            ORDER BY nc_min DESC
				) ct
			ON ct.comm_type_id =cd.comm_type_id
			INNER JOIN
				(SELECT commission_id, payment_option
				FROM YA_ASSOCIATE
				WHERE associate_id=iAssociateId
				) ya
			ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
         WHERE ROWNUM=1
			)t
		GROUP BY TO_NUMBER(TO_CHAR(order_date,'fmmm')), TO_NUMBER(TO_CHAR(order_date, 'yyyy')) , comm_rate, t.percentage;

		IF (cur_out01 IS NULL) THEN
			cur_out01 := cur_temp07;
		ELSIF (cur_out02 IS NULL) THEN
			cur_out02 := cur_temp07;
		ELSIF (cur_out03 IS NULL) THEN
			cur_out03 := cur_temp07;
		ELSIF (cur_out04 IS NULL) THEN
			cur_out04 := cur_temp07;
		ELSIF (cur_out05 IS NULL) THEN
			cur_out05 := cur_temp07;
		ELSIF (cur_out06 IS NULL) THEN
			cur_out06 := cur_temp07;
		ELSIF (cur_out07 IS NULL) THEN
			cur_out07 := cur_temp07;
		ELSIF (cur_out08 IS NULL) THEN
			cur_out08 := cur_temp07;
		ELSIF (cur_out09 IS NULL) THEN
			cur_out09 := cur_temp07;
		ELSIF (cur_out10 IS NULL) THEN
			cur_out10 := cur_temp07;
		ELSIF (cur_out11 IS NULL) THEN
			cur_out11 := cur_temp07;
		ELSIF (cur_out12 IS NULL) THEN
			cur_out12 := cur_temp07;
		ELSIF (cur_out13 IS NULL) THEN
			cur_out13 := cur_temp07;
		ELSIF (cur_out14 IS NULL) THEN
			cur_out14 := cur_temp07;
		ELSE
			cur_out14 := cur_temp07;
		END IF;
	END IF;

END IF;

IF (iNeedGroup = 0) THEN

	IF (iBestSeller = 1) THEN
		OPEN cur_temp08 FOR
      SELECT * FROM (
         SELECT
            CASE
               WHEN (YA_PROD_LANG.prod_name_u IS NULL OR YA_PROD_LANG.prod_name_u = '')
               THEN (SELECT prod_name_u FROM YA_PROD_LANG WHERE sku=yalo.sku AND lang_id = 1)
               ELSE
               YA_PROD_LANG.prod_name_u
               END
            AS prod_name,
            yalo.sku,
            SUM(yalo.quantity) AS items, link_id,
            SUM(yalo.unit_price * yalo.quantity) AS price
         FROM
            (SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, YA_ASSOCIATE_LINK_ORDERS.link_id
            FROM
               (SELECT *
               FROM YA_ASSOCIATE_LINK_ORDERS
               WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
               ) YA_ASSOCIATE_LINK_ORDERS
            INNER JOIN
               (SELECT *
               FROM YA_ASSOCIATE_LINK
               WHERE associate_id=iAssociateId
               ) yal
            ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
            WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
               (YA_ASSOCIATE_LINK_ORDERS.last_change_date <  TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
               (credit_status = 2 OR credit_status = 1) AND (unit_price > 0)
            ) yalo
            LEFT OUTER  JOIN YA_PRODUCT ON yalo.sku = YA_PRODUCT.sku
            LEFT OUTER  JOIN YA_PROD_LANG ON yalo.sku = YA_PROD_LANG.sku
         WHERE      (YA_PROD_LANG.lang_id = tiLangId)
         GROUP BY YA_PROD_LANG.prod_name_u,  yalo.sku, link_id
         ORDER BY items DESC)
      WHERE (ROWNUM<=20);

		IF (cur_out01 IS NULL) THEN
			cur_out01 := cur_temp08;
		ELSIF (cur_out02 IS NULL) THEN
			cur_out02 := cur_temp08;
		ELSIF (cur_out03 IS NULL) THEN
			cur_out03 := cur_temp08;
		ELSIF (cur_out04 IS NULL) THEN
			cur_out04 := cur_temp08;
		ELSIF (cur_out05 IS NULL) THEN
			cur_out05 := cur_temp08;
		ELSIF (cur_out06 IS NULL) THEN
			cur_out06 := cur_temp08;
		ELSIF (cur_out07 IS NULL) THEN
			cur_out07 := cur_temp08;
		ELSIF (cur_out08 IS NULL) THEN
			cur_out08 := cur_temp08;
		ELSIF (cur_out09 IS NULL) THEN
			cur_out09 := cur_temp08;
		ELSIF (cur_out10 IS NULL) THEN
			cur_out10 := cur_temp08;
		ELSIF (cur_out11 IS NULL) THEN
			cur_out11 := cur_temp08;
		ELSIF (cur_out12 IS NULL) THEN
			cur_out12 := cur_temp08;
		ELSIF (cur_out13 IS NULL) THEN
			cur_out13 := cur_temp08;
		ELSIF (cur_out14 IS NULL) THEN
			cur_out14 := cur_temp08;
		ELSE
			cur_out14 := cur_temp08;
		END IF;
	ELSE
		IF (iCreditStatus <> 1)  THEN
			OPEN cur_temp09 FOR
			SELECT  TO_CHAR(order_date, 'mm/dd/yyyy') AS order_date,
				TO_CHAR(last_change_date, 'mm/dd/yyyy') AS posting_date,
				CASE
					WHEN (YA_PROD_LANG.prod_name_u IS NULL OR YA_PROD_LANG.prod_name_u = '')
					THEN (SELECT prod_name_u FROM YA_PROD_LANG WHERE sku=yalo.sku AND lang_id = 1)
					ELSE
					YA_PROD_LANG.prod_name_u
					END
				AS prod_name,
				yalo.sku,
				SUM(yalo.quantity) AS items, link_id,
				SUM(yalo.unit_price * yalo.quantity) AS price
			FROM
				(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, YA_ASSOCIATE_LINK_ORDERS.link_id
				FROM
					(SELECT *
					FROM YA_ASSOCIATE_LINK_ORDERS
					WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
					) YA_ASSOCIATE_LINK_ORDERS
				INNER JOIN
					(SELECT *
					FROM YA_ASSOCIATE_LINK
					WHERE associate_id=iAssociateId
					) yal
				ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
				WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
			                                  (YA_ASSOCIATE_LINK_ORDERS.last_change_date <  TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
			                 	               (credit_status = 2) AND (unit_price > 0)) yalo
				LEFT OUTER  JOIN YA_PRODUCT ON yalo.sku = YA_PRODUCT.sku
				LEFT OUTER  JOIN YA_PROD_LANG ON yalo.sku = YA_PROD_LANG.sku
			WHERE      (YA_PROD_LANG.lang_id = tiLangId)
			GROUP BY YA_PROD_LANG.prod_name_u,  yalo.sku, link_id,
				TO_CHAR(order_date, 'mm/dd/yyyy'), TO_CHAR(last_change_date, 'mm/dd/yyyy')
			ORDER BY posting_date, prod_name;

			IF (cur_out01 IS NULL) THEN
				cur_out01 := cur_temp09;
			ELSIF (cur_out02 IS NULL) THEN
				cur_out02 := cur_temp09;
			ELSIF (cur_out03 IS NULL) THEN
				cur_out03 := cur_temp09;
			ELSIF (cur_out04 IS NULL) THEN
				cur_out04 := cur_temp09;
			ELSIF (cur_out05 IS NULL) THEN
				cur_out05 := cur_temp09;
			ELSIF (cur_out06 IS NULL) THEN
				cur_out06 := cur_temp09;
			ELSIF (cur_out07 IS NULL) THEN
				cur_out07 := cur_temp09;
			ELSIF (cur_out08 IS NULL) THEN
				cur_out08 := cur_temp09;
			ELSIF (cur_out09 IS NULL) THEN
				cur_out09 := cur_temp09;
			ELSIF (cur_out10 IS NULL) THEN
				cur_out10 := cur_temp09;
			ELSIF (cur_out11 IS NULL) THEN
				cur_out11 := cur_temp09;
			ELSIF (cur_out12 IS NULL) THEN
				cur_out12 := cur_temp09;
			ELSIF (cur_out13 IS NULL) THEN
				cur_out13 := cur_temp09;
			ELSIF (cur_out14 IS NULL) THEN
				cur_out14 := cur_temp09;
			ELSE
				cur_out14 := cur_temp09;
			END IF;
		END IF;

		IF (iCreditStatus <>2) THEN
			OPEN cur_temp10 FOR
			SELECT  TO_CHAR(order_date, 'mm/dd/yyyy') AS order_date, TO_CHAR(last_change_date, 'mm/dd/yyyy') AS posting_date,
			                CASE
					WHEN (YA_PROD_LANG.prod_name_u IS NULL OR YA_PROD_LANG.prod_name_u = '')
					THEN (SELECT prod_name_u FROM YA_PROD_LANG WHERE sku=yalo.sku AND lang_id = 1)
					ELSE YA_PROD_LANG.prod_name_u
					END
				AS prod_name,
				yalo.sku, SUM(yalo.quantity) AS items,
				SUM(yalo.unit_price * yalo.quantity) AS price, yalo.link_id,
			                      yg.group_id
			FROM
				(SELECT order_date, last_change_date, sku, NVL(quantity, 0) AS quantity, NVL(unit_price, 0) AS unit_price, credit_status, yal.link_id
				FROM
					(SELECT *
					FROM YA_ASSOCIATE_LINK_ORDERS
					WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
					) YA_ASSOCIATE_LINK_ORDERS
				INNER JOIN
					(SELECT *
					FROM YA_ASSOCIATE_LINK
					WHERE associate_id=iAssociateId
					) yal
				ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
				WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
			                                  (YA_ASSOCIATE_LINK_ORDERS.last_change_date <  TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
			                 	               (credit_status = 1) AND (unit_price > 0)
				) yalo
				LEFT OUTER  JOIN YA_PRODUCT ON yalo.sku = YA_PRODUCT.sku
				LEFT OUTER  JOIN YA_PROD_LANG ON yalo.sku = YA_PROD_LANG.sku
				LEFT OUTER  JOIN
					(SELECT *
					FROM YA_GROUP
					WHERE division_id=1
					) yg
				ON yg.account_id = YA_PRODUCT.account_id
			WHERE      (YA_PROD_LANG.lang_id = tiLangId)
			GROUP BY YA_PROD_LANG.prod_name_u,  yalo.sku, yg.group_id, link_id,
				TO_CHAR(order_date, 'mm/dd/yyyy'), TO_CHAR(last_change_date, 'mm/dd/yyyy')
			ORDER BY group_id, posting_date, prod_name;

			IF (cur_out01 IS NULL) THEN
				cur_out01 := cur_temp10;
			ELSIF (cur_out02 IS NULL) THEN
				cur_out02 := cur_temp10;
			ELSIF (cur_out03 IS NULL) THEN
				cur_out03 := cur_temp10;
			ELSIF (cur_out04 IS NULL) THEN
				cur_out04 := cur_temp10;
			ELSIF (cur_out05 IS NULL) THEN
				cur_out05 := cur_temp10;
			ELSIF (cur_out06 IS NULL) THEN
				cur_out06 := cur_temp10;
			ELSIF (cur_out07 IS NULL) THEN
				cur_out07 := cur_temp10;
			ELSIF (cur_out08 IS NULL) THEN
				cur_out08 := cur_temp10;
			ELSIF (cur_out09 IS NULL) THEN
				cur_out09 := cur_temp10;
			ELSIF (cur_out10 IS NULL) THEN
				cur_out10 := cur_temp10;
			ELSIF (cur_out11 IS NULL) THEN
				cur_out11 := cur_temp10;
			ELSIF (cur_out12 IS NULL) THEN
				cur_out12 := cur_temp10;
			ELSIF (cur_out13 IS NULL) THEN
				cur_out13 := cur_temp10;
			ELSIF (cur_out14 IS NULL) THEN
				cur_out14 := cur_temp10;
			ELSE
				cur_out14 := cur_temp10;
			END IF;

			OPEN cur_temp11 FOR
			SELECT    SUM(yalo.quantity) AS items,
				SUM(yalo.unit_price * yalo.quantity) AS price
			FROM
				(SELECT order_date, last_change_date, sku, NVL(quantity, 0) AS quantity, NVL(unit_price, 0) AS unit_price, credit_status
				 FROM
					(SELECT *
					FROM YA_ASSOCIATE_LINK_ORDERS
					WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
					) YA_ASSOCIATE_LINK_ORDERS
				INNER JOIN
					(SELECT *
					FROM YA_ASSOCIATE_LINK
					WHERE associate_id=iAssociateId
					) yal
				ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
				WHERE (YA_ASSOCIATE_LINK_ORDERS.order_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
			                                  (YA_ASSOCIATE_LINK_ORDERS.order_date <  TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
			                 	               (credit_status =1) AND (unit_price > 0)
				) yalo
			GROUP BY TO_NUMBER(TO_CHAR(order_date, 'fmmm'));

			IF (cur_out01 IS NULL) THEN
				cur_out01 := cur_temp11;
			ELSIF (cur_out02 IS NULL) THEN
				cur_out02 := cur_temp11;
			ELSIF (cur_out03 IS NULL) THEN
				cur_out03 := cur_temp11;
			ELSIF (cur_out04 IS NULL) THEN
				cur_out04 := cur_temp11;
			ELSIF (cur_out05 IS NULL) THEN
				cur_out05 := cur_temp11;
			ELSIF (cur_out06 IS NULL) THEN
				cur_out06 := cur_temp11;
			ELSIF (cur_out07 IS NULL) THEN
				cur_out07 := cur_temp11;
			ELSIF (cur_out08 IS NULL) THEN
				cur_out08 := cur_temp11;
			ELSIF (cur_out09 IS NULL) THEN
				cur_out09 := cur_temp11;
			ELSIF (cur_out10 IS NULL) THEN
				cur_out10 := cur_temp11;
			ELSIF (cur_out11 IS NULL) THEN
				cur_out11 := cur_temp11;
			ELSIF (cur_out12 IS NULL) THEN
				cur_out12 := cur_temp11;
			ELSIF (cur_out13 IS NULL) THEN
				cur_out13 := cur_temp11;
			ELSIF (cur_out14 IS NULL) THEN
				cur_out14 := cur_temp11;
			ELSE
				cur_out14 := cur_temp11;
			END IF;
		END IF;
	END IF;

	IF (cStartDate < cCutOffDate) THEN
		OPEN cur_temp12 FOR
		SELECT    SUM(yalo.quantity) AS items,
			SUM(yalo.unit_price * yalo.quantity) AS price,
			TO_NUMBER(TO_CHAR(order_date, 'fmmm')) AS posting_month,
			TO_NUMBER(TO_CHAR(order_date, 'yyyy')) AS posting_year,
			(SELECT link_percentage FROM YA_ASSOCIATE_LINK WHERE associate_id=iAssociateId AND ROWNUM=1 ) AS percentage,
			--sum(yalo.unit_price * yalo.quantity) * (SELECT link_percentage FROM ya_associate_link WHERE associate_id=iAssociateId AND rownum=1) AS commission
			SUM(NVL(yalo.credit_amount, yalo.unit_price * yalo.quantity* NVL(comm_rate, NVL(percentage, (SELECT comm_rate FROM YA_ASSOCIATE_COMMISSION_HIST WHERE associate_id = 8050 AND ROWNUM=1))))) AS commission
		FROM
			(SELECT order_date, last_change_date, sku, NVL(quantity, 0) AS quantity, NVL(unit_price, 0) AS unit_price, credit_status, credit_amount
			FROM
				(SELECT *
				FROM YA_ASSOCIATE_LINK_ORDERS
				WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) YA_ASSOCIATE_LINK_ORDERS
			INNER JOIN
				(SELECT *
				FROM YA_ASSOCIATE_LINK
				WHERE associate_id=iAssociateId
				) yal
			ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
			WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
				(YA_ASSOCIATE_LINK_ORDERS.last_change_date < TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (unit_price > 0)
			) yalo
		LEFT OUTER JOIN YA_ASSOCIATE_COMMISSION_HIST yach ON yach.associate_id = iAssociateId
			AND yach.valid_date = TO_DATE(TO_CHAR(order_date, 'mm') || '/01/' || TO_CHAR(order_date, 'yyyy'), 'mm/dd/yyyy'),
			(SELECT percentage  FROM YA_ASSOCIATE_COMMISSION_DETAIL cd INNER JOIN
			(SELECT comm_type_id, nc_max FROM YA_ASSOCIATE_COMMISSION_TYPE ct WHERE ((nc_min <= iCustomer AND nc_max >= iCustomer) OR nc_max < iCustomer)) ct
			ON ct.comm_type_id =cd.comm_type_id
			INNER JOIN
				(SELECT commission_id, payment_option
				FROM YA_ASSOCIATE
				WHERE associate_id=iAssociateId
				) ya
			ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
         WHERE ROWNUM=1
			)t
		GROUP BY TO_NUMBER(TO_CHAR(order_date, 'fmmm')), TO_NUMBER(TO_CHAR(order_date, 'yyyy')) , comm_rate, t.percentage;

		IF (cur_out01 IS NULL) THEN
			cur_out01 := cur_temp12;
		ELSIF (cur_out02 IS NULL) THEN
			cur_out02 := cur_temp12;
		ELSIF (cur_out03 IS NULL) THEN
			cur_out03 := cur_temp12;
		ELSIF (cur_out04 IS NULL) THEN
			cur_out04 := cur_temp12;
		ELSIF (cur_out05 IS NULL) THEN
			cur_out05 := cur_temp12;
		ELSIF (cur_out06 IS NULL) THEN
			cur_out06 := cur_temp12;
		ELSIF (cur_out07 IS NULL) THEN
			cur_out07 := cur_temp12;
		ELSIF (cur_out08 IS NULL) THEN
			cur_out08 := cur_temp12;
		ELSIF (cur_out09 IS NULL) THEN
			cur_out09 := cur_temp12;
		ELSIF (cur_out10 IS NULL) THEN
			cur_out10 := cur_temp12;
		ELSIF (cur_out11 IS NULL) THEN
			cur_out11 := cur_temp12;
		ELSIF (cur_out12 IS NULL) THEN
			cur_out12 := cur_temp12;
		ELSIF (cur_out13 IS NULL) THEN
			cur_out13 := cur_temp12;
		ELSIF (cur_out14 IS NULL) THEN
			cur_out14 := cur_temp12;
		ELSE
			cur_out14 := cur_temp12;
		END IF;
	ELSE
		OPEN cur_temp13 FOR
		SELECT    SUM(yalo.quantity) AS items,
			SUM(yalo.unit_price * yalo.quantity) AS price,
			TO_NUMBER(TO_CHAR(order_date, 'fmmm')) AS posting_month,
			TO_NUMBER(TO_CHAR(order_date, 'yyyy')) AS posting_year,
			NVL(comm_rate, NVL(percentage, (SELECT comm_rate FROM YA_ASSOCIATE_COMMISSION_HIST WHERE associate_id = iAssociateId AND ROWNUM=1))) AS percentage,
			--sum(yalo.unit_price * yalo.quantity) * nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = iAssociateId AND rownum=1 )))  AS commission
			SUM(NVL(yalo.credit_amount, yalo.unit_price * yalo.quantity* NVL(comm_rate, NVL(percentage, (SELECT comm_rate FROM YA_ASSOCIATE_COMMISSION_HIST WHERE associate_id = 8050 AND ROWNUM=1))))) AS commission
		FROM
			(SELECT order_date, last_change_date, sku, NVL(quantity, 0) AS quantity, NVL(unit_price, 0) AS unit_price, credit_status, credit_amount
			FROM
				(SELECT *
				FROM YA_ASSOCIATE_LINK_ORDERS
				WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) YA_ASSOCIATE_LINK_ORDERS
			INNER JOIN
				(SELECT *
				FROM YA_ASSOCIATE_LINK
				WHERE associate_id=iAssociateId
				) yal
			ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
			WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
				(YA_ASSOCIATE_LINK_ORDERS.last_change_date < TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (unit_price > 0)
			) yalo
			LEFT OUTER JOIN YA_ASSOCIATE_COMMISSION_HIST yach ON yach.associate_id = iAssociateId
				AND yach.valid_date = TO_DATE(TO_CHAR(order_date, 'mm') || '/01/' || TO_CHAR(order_date, 'yyyy'), 'mm/dd/yyyy'),
				(SELECT percentage  FROM YA_ASSOCIATE_COMMISSION_DETAIL cd INNER JOIN
				(SELECT comm_type_id, nc_max FROM YA_ASSOCIATE_COMMISSION_TYPE ct WHERE ((nc_min <= iCustomer AND nc_max >= iCustomer) OR nc_max < iCustomer)) ct
				ON ct.comm_type_id =cd.comm_type_id
				INNER JOIN
					(SELECT commission_id, payment_option
					FROM YA_ASSOCIATE
					WHERE associate_id=iAssociateId
					) ya
			ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
         WHERE ROWNUM=1
			)t
		GROUP BY TO_NUMBER(TO_CHAR(order_date, 'fmmm')), TO_NUMBER(TO_CHAR(order_date, 'yyyy')), comm_rate, t.percentage;

		IF (cur_out01 IS NULL) THEN
			cur_out01 := cur_temp13;
		ELSIF (cur_out02 IS NULL) THEN
			cur_out02 := cur_temp13;
		ELSIF (cur_out03 IS NULL) THEN
			cur_out03 := cur_temp13;
		ELSIF (cur_out04 IS NULL) THEN
			cur_out04 := cur_temp13;
		ELSIF (cur_out05 IS NULL) THEN
			cur_out05 := cur_temp13;
		ELSIF (cur_out06 IS NULL) THEN
			cur_out06 := cur_temp13;
		ELSIF (cur_out07 IS NULL) THEN
			cur_out07 := cur_temp13;
		ELSIF (cur_out08 IS NULL) THEN
			cur_out08 := cur_temp13;
		ELSIF (cur_out09 IS NULL) THEN
			cur_out09 := cur_temp13;
		ELSIF (cur_out10 IS NULL) THEN
			cur_out10 := cur_temp13;
		ELSIF (cur_out11 IS NULL) THEN
			cur_out11 := cur_temp13;
		ELSIF (cur_out12 IS NULL) THEN
			cur_out12 := cur_temp13;
		ELSIF (cur_out13 IS NULL) THEN
			cur_out13 := cur_temp13;
		ELSIF (cur_out14 IS NULL) THEN
			cur_out14 := cur_temp13;
		ELSE
			cur_out14 := cur_temp13;
		END IF;
	END IF;
END IF;

IF (iNeedLinkInfo = 1) THEN
	OPEN cur_temp14 FOR
	SELECT link_id, '<B>' || site_name || '</B> (' || link_code || ')' AS site_name FROM YA_ASSOCIATE_LINK WHERE associate_id = iAssociateId;
	IF (cur_out01 IS NULL) THEN
		cur_out01 := cur_temp14;
	ELSIF (cur_out02 IS NULL) THEN
		cur_out02 := cur_temp14;
	ELSIF (cur_out03 IS NULL) THEN
		cur_out03 := cur_temp14;
	ELSIF (cur_out04 IS NULL) THEN
		cur_out04 := cur_temp14;
	ELSIF (cur_out05 IS NULL) THEN
		cur_out05 := cur_temp14;
	ELSIF (cur_out06 IS NULL) THEN
		cur_out06 := cur_temp14;
	ELSIF (cur_out07 IS NULL) THEN
		cur_out07 := cur_temp14;
	ELSIF (cur_out08 IS NULL) THEN
		cur_out08 := cur_temp14;
	ELSIF (cur_out09 IS NULL) THEN
		cur_out09 := cur_temp14;
	ELSIF (cur_out10 IS NULL) THEN
		cur_out10 := cur_temp14;
	ELSIF (cur_out11 IS NULL) THEN
		cur_out11 := cur_temp14;
	ELSIF (cur_out12 IS NULL) THEN
		cur_out12 := cur_temp14;
	ELSIF (cur_out13 IS NULL) THEN
		cur_out13 := cur_temp14;
	ELSIF (cur_out14 IS NULL) THEN
		cur_out14 := cur_temp14;
	ELSE
		cur_out14 := cur_temp14;
	END IF;
	SELECT NVL(lang_id, 1) INTO iLangId FROM YA_ASSOCIATE_LINK WHERE associate_id = iAssociateId AND ROWNUM=1;
END IF;


IF (cur_out01 IS NULL) THEN
	OPEN cur_out01 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out02 IS NULL) THEN
	OPEN cur_out02 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out03 IS NULL) THEN
	OPEN cur_out03 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out04 IS NULL) THEN
	OPEN cur_out04 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out05 IS NULL) THEN
	OPEN cur_out05 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out06 IS NULL) THEN
	OPEN cur_out06 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out07 IS NULL) THEN
	OPEN cur_out07 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out08 IS NULL) THEN
	OPEN cur_out08 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out09 IS NULL) THEN
	OPEN cur_out09 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out10 IS NULL) THEN
	OPEN cur_out10 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out11 IS NULL) THEN
	OPEN cur_out11 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out12 IS NULL) THEN
	OPEN cur_out12 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out13 IS NULL) THEN
	OPEN cur_out13 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out14 IS NULL) THEN
	OPEN cur_out14 FOR
	SELECT 'null_cursor' FROM dual;
END IF;


END sp_fe_asso_selOrderByAid;


PROCEDURE sp_fe_asso_selOrderByLid
(
	cMonth IN VARCHAR2,
	cYear IN VARCHAR2,
	iAssociateId IN INT,
	iLinkId IN INT,
	tiLangId IN INT,
	iCreditStatus IN INT,
	iNeedGroup IN INT,
	iBestSeller IN INT,
	iCustomer OUT INT,
	deciPercentage OUT FLOAT,
	iNextLevel OUT INT,
	iLangId OUT INT,
	deciThisPeriodComm OUT FLOAT,
	deciTotalComm OUT FLOAT,
	cur_out01 OUT cur_return,
	cur_out02 OUT cur_return,
	cur_out03 OUT cur_return,
	cur_out04 OUT cur_return,
	cur_out05 OUT cur_return,
	cur_out06 OUT cur_return,
	cur_out07 OUT cur_return,
	cur_out08 OUT cur_return,
	cur_out09 OUT cur_return,
	cur_out10 OUT cur_return,
	cur_out11 OUT cur_return,
	cur_out12 OUT cur_return,
	cur_out13 OUT cur_return,
	cur_out14 OUT cur_return
) IS

	cStartDate VARCHAR(10);
	cEndDate VARCHAR(10);
	cCutOffDate VARCHAR(10);

	TYPE typePercentageNextLevel IS RECORD(percentage FLOAT, next_level INT);
	ret_percentage_next_level typePercentageNextLevel;

	cur_temp01 cur_return;
	cur_temp02 cur_return;
	cur_temp03 cur_return;
	cur_temp04 cur_return;
	cur_temp05 cur_return;
	cur_temp06 cur_return;
	cur_temp07 cur_return;
	cur_temp08 cur_return;
	cur_temp09 cur_return;
	cur_temp10 cur_return;
	cur_temp11 cur_return;
	cur_temp12 cur_return;
	cur_temp13 cur_return;
	cur_temp14 cur_return;

BEGIN

cStartDate := cMonth || '/01/' || cYear;
cEndDate := TO_CHAR(ADD_MONTHS(TO_DATE(cStartDate, 'mm/dd/yyyy'), 1), 'mm/dd/yyyy');
cCutOffDate := '07/01/2005';

SELECT COUNT(customerId) INTO iCustomer
FROM DM_NEW_SHOPPER
WHERE DM_NEW_SHOPPER.validOrder = 'Y'
	AND DM_NEW_SHOPPER.feOrderId IN
	(SELECT  DISTINCT TO_CHAR(order_num) AS orderId
	FROM
		(SELECT *
		FROM YA_ASSOCIATE_LINK_ORDERS
		WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)) YA_ASSOCIATE_LINK_ORDERS
	INNER JOIN
		(SELECT link_id
		FROM YA_ASSOCIATE_LINK
		WHERE associate_id=iAssociateId) yal
	ON YA_ASSOCIATE_LINK_ORDERS.link_id = yal.link_id
	WHERE order_date >= TO_DATE(cStartDate, 'mm/dd/yyyy') AND order_date < TO_DATE(cEndDate, 'mm/dd/yyyy') AND credit_status <> 4);


IF (TO_DATE(cStartDate, 'mm/dd/yyyy') < TO_DATE(cCutOffDate, 'mm/dd/yyyy')) THEN
	SELECT link_percentage INTO deciPercentage FROM YA_ASSOCIATE_LINK WHERE associate_id=iAssociateId AND ROWNUM=1 ORDER BY link_id ASC;
	iNextLevel := 0;
ELSE
/*
	SELECT percentage, nc_max + 1 - iCustomer INTO ret_percentage_next_level
	FROM ya_associate_commission_detail cd INNER JOIN
			(SELECT comm_type_id, nc_max
			FROM ya_associate_commission_type ct
			WHERE nc_min <= iCustomer AND nc_max >= iCustomer) ct
		ON ct.comm_type_id =cd.comm_type_id
		 INNER JOIN (SELECT commission_id, payment_option
			FROM ya_associate
			WHERE associate_id=iAssociateId) ya
	ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option;

	deciPercentage := ret_percentage_next_level.percentage;
	iNextLevel := ret_percentage_next_level.next_level;

	IF (deciPercentage IS null) THEN
		SELECT percentage, nc_max + 1 - iCustomer INTO ret_percentage_next_level
		FROM ya_associate_commission_detail cd INNER JOIN
				(SELECT comm_type_id, nc_max
				FROM ya_associate_commission_type ct
				WHERE nc_min <= iCustomer ) ct
			ON ct.comm_type_id =cd.comm_type_id
			 INNER JOIN (SELECT commission_id, payment_option
				FROM ya_associate
				WHERE associate_id=iAssociateId) ya
		ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option;

		deciPercentage := ret_percentage_next_level.percentage;
		iNextLevel := ret_percentage_next_level.next_level;
	END IF;
*/
   SELECT comm_rate, 0 INTO ret_percentage_next_level FROM YA_ASSOCIATE_COMMISSION_HIST ach WHERE valid_date = TO_DATE(cStartDate, 'mm/dd/yyyy') AND associate_id = iAssociateId AND ROWNUM = 1;
	deciPercentage := ret_percentage_next_level.percentage;
	iNextLevel := ret_percentage_next_level.next_level;

	IF (deciPercentage IS NULL) THEN
		SELECT percentage, nc_max + 1 - iCustomer INTO ret_percentage_next_level
		FROM YA_ASSOCIATE_COMMISSION_DETAIL cd INNER JOIN
				(SELECT comm_type_id, nc_max
				FROM YA_ASSOCIATE_COMMISSION_TYPE ct
				WHERE nc_min <= iCustomer ) ct
			ON ct.comm_type_id =cd.comm_type_id
			 INNER JOIN (SELECT commission_id, payment_option
				FROM YA_ASSOCIATE
				WHERE associate_id=iAssociateId) ya
		ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option AND ROWNUM = 1;

   ELSE
		SELECT deciPercentage, nc_max + 1 - iCustomer INTO ret_percentage_next_level
		FROM YA_ASSOCIATE_COMMISSION_DETAIL cd INNER JOIN
				(SELECT comm_type_id, nc_max
				FROM YA_ASSOCIATE_COMMISSION_TYPE ct
				WHERE nc_min <= iCustomer ) ct
			ON ct.comm_type_id =cd.comm_type_id
			 INNER JOIN (SELECT commission_id, payment_option
				FROM YA_ASSOCIATE
				WHERE associate_id=iAssociateId) ya
		ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option AND ROWNUM = 1;
	END IF;
	deciPercentage := ret_percentage_next_level.percentage;
	iNextLevel := ret_percentage_next_level.next_level;
END IF;

/*use new comm %*/
SELECT SUM(NVL(credit_amount,unit_price * quantity * deciPercentage)) INTO deciTotalComm
FROM YA_ASSOCIATE_LINK_ORDERS
WHERE
	(last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
	(last_change_date < TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
	link_id IN (SELECT link_id FROM YA_ASSOCIATE_LINK WHERE associate_id=iAssociateId) AND
	credit_status = 2;

SELECT SUM(NVL(credit_amount,unit_price * quantity * NVL(deciPercentage,0))) INTO deciThisPeriodComm
FROM YA_ASSOCIATE_LINK_ORDERS
WHERE
	(last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
	(last_change_date < TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
	order_date >= TO_DATE(cStartDate, 'mm/dd/yyyy') AND order_date < TO_DATE(cEndDate, 'mm/dd/yyyy') AND
	link_id IN (SELECT link_id FROM YA_ASSOCIATE_LINK WHERE associate_id=iAssociateId) AND
	credit_status = 2;


IF (iNeedGroup = 1) THEN
	IF (iCreditStatus <> 1) THEN

		OPEN cur_out01 FOR
		SELECT  TO_CHAR(order_date, 'mm/dd/yyyy') AS order_date, TO_CHAR(last_change_date, 'mm/dd/yyyy') AS posting_date,
			CASE
				WHEN (YA_PROD_LANG.prod_name_u IS NULL OR YA_PROD_LANG.prod_name_u = '')
				THEN (SELECT prod_name_u FROM YA_PROD_LANG WHERE sku=yalo.sku AND lang_id = 1)
				ELSE YA_PROD_LANG.prod_name_u
				END
			AS prod_name,
			yalo.sku, SUM(yalo.quantity) AS items,
			SUM(yalo.unit_price * yalo.quantity) AS price, yalo.link_id,
			yg.group_id
		FROM
			(SELECT order_date, last_change_date, sku, NVL(quantity, 0) AS quantity, NVL(unit_price, 0) AS unit_price, credit_status, link_id
			FROM
				(SELECT *
				FROM YA_ASSOCIATE_LINK_ORDERS
				WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) YA_ASSOCIATE_LINK_ORDERS
			WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
				(YA_ASSOCIATE_LINK_ORDERS.last_change_date <  TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (unit_price > 0) AND
				(link_id = iLinkId)
			) yalo
		LEFT OUTER  JOIN
			YA_PRODUCT ON yalo.sku = YA_PRODUCT.sku
		LEFT OUTER  JOIN
			YA_PROD_LANG ON yalo.sku = YA_PROD_LANG.sku
		LEFT OUTER  JOIN
			(SELECT * FROM YA_GROUP WHERE division_id=1) yg
			ON yg.account_id = YA_PRODUCT.account_id
		WHERE      (YA_PROD_LANG.lang_id = tiLangId)
		GROUP BY YA_PROD_LANG.prod_name_u,  yalo.sku, yg.group_id, link_id,
			TO_CHAR(order_date, 'mm/dd/yyyy'), TO_CHAR(last_change_date, 'mm/dd/yyyy')
		ORDER BY group_id, posting_date, prod_name;

		OPEN cur_out02 FOR
		SELECT DISTINCT yg.group_id
		FROM
			(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status
			FROM
				(SELECT *
				FROM YA_ASSOCIATE_LINK_ORDERS
				WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) YA_ASSOCIATE_LINK_ORDERS
			WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
				(YA_ASSOCIATE_LINK_ORDERS.last_change_date <  TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (link_id = iLinkId) AND (unit_price > 0)) yalo
		LEFT OUTER  JOIN
			YA_PRODUCT ON yalo.sku = YA_PRODUCT.sku
		LEFT OUTER  JOIN
			(SELECT * FROM YA_GROUP WHERE division_id=1) yg
			ON yg.account_id = YA_PRODUCT.account_id;
	END IF;

	IF (iCreditStatus <>2) THEN
		OPEN cur_temp03 FOR
		SELECT   TO_CHAR(yalo.order_date, 'mm/dd/yyyy') AS order_date,
			CASE
				WHEN (YA_PROD_LANG.prod_name_u IS NULL OR YA_PROD_LANG.prod_name_u = '')
				THEN (SELECT prod_name_u FROM YA_PROD_LANG WHERE sku=yalo.sku AND lang_id = 1)
				ELSE YA_PROD_LANG.prod_name_u
				END
			AS prod_name, yalo.sku,
			SUM(yalo.quantity) AS items,
			SUM(yalo.unit_price * yalo.quantity) AS price, link_id,
			yg.group_id
		FROM
			(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, YA_ASSOCIATE_LINK_ORDERS.link_id
			FROM
				(SELECT *
				FROM YA_ASSOCIATE_LINK_ORDERS
				WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) YA_ASSOCIATE_LINK_ORDERS
			WHERE (YA_ASSOCIATE_LINK_ORDERS.order_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
				(YA_ASSOCIATE_LINK_ORDERS.order_date < TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 1) AND (link_id = iLinkId) AND (unit_price > 0)
			) yalo
		LEFT OUTER  JOIN
			YA_PRODUCT ON yalo.sku = YA_PRODUCT.sku
		LEFT OUTER  JOIN
			YA_PROD_LANG ON yalo.sku = YA_PROD_LANG.sku
		LEFT OUTER  JOIN
			(SELECT * FROM YA_GROUP WHERE division_id=1) yg
		ON yg.account_id = YA_PRODUCT.account_id
		WHERE      (YA_PROD_LANG.lang_id = tiLangId OR YA_PROD_LANG.lang_id = 1)
		GROUP BY YA_PROD_LANG.prod_name_u,  yalo.sku, yg.group_id, order_date, link_id
		ORDER BY group_id, order_date, prod_name;

		IF (cur_out01 IS NULL) THEN
			cur_out01 := cur_temp03;
		ELSIF (cur_out02 IS NULL) THEN
			cur_out02 := cur_temp03;
		ELSIF (cur_out03 IS NULL) THEN
			cur_out03 := cur_temp03;
		ELSIF (cur_out04 IS NULL) THEN
			cur_out04 := cur_temp03;
		ELSIF (cur_out05 IS NULL) THEN
			cur_out05 := cur_temp03;
		ELSIF (cur_out06 IS NULL) THEN
			cur_out06 := cur_temp03;
		ELSIF (cur_out07 IS NULL) THEN
			cur_out07 := cur_temp03;
		ELSIF (cur_out08 IS NULL) THEN
			cur_out08 := cur_temp03;
		ELSIF (cur_out09 IS NULL) THEN
			cur_out09 := cur_temp03;
		ELSIF (cur_out10 IS NULL) THEN
			cur_out10 := cur_temp03;
		ELSE
			cur_out11 := cur_temp03;
		END IF;

		OPEN cur_temp04 FOR
		SELECT    DISTINCT  yg.group_id
		FROM
			(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status
			FROM
				(SELECT *
				FROM YA_ASSOCIATE_LINK_ORDERS
				WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) YA_ASSOCIATE_LINK_ORDERS
			WHERE (YA_ASSOCIATE_LINK_ORDERS.order_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
				(YA_ASSOCIATE_LINK_ORDERS.order_date <  TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 1) AND (link_id = iLinkId) AND (unit_price > 0)
			) yalo
		LEFT OUTER  JOIN
			YA_PRODUCT ON yalo.sku = YA_PRODUCT.sku
		LEFT OUTER  JOIN
			(SELECT * FROM YA_GROUP WHERE division_id=1) yg
		ON yg.account_id = YA_PRODUCT.account_id;

		IF (cur_out01 IS NULL) THEN
			cur_out01 := cur_temp04;
		ELSIF (cur_out02 IS NULL) THEN
			cur_out02 := cur_temp04;
		ELSIF (cur_out03 IS NULL) THEN
			cur_out03 := cur_temp04;
		ELSIF (cur_out04 IS NULL) THEN
			cur_out04 := cur_temp04;
		ELSIF (cur_out05 IS NULL) THEN
			cur_out05 := cur_temp04;
		ELSIF (cur_out06 IS NULL) THEN
			cur_out06 := cur_temp04;
		ELSIF (cur_out07 IS NULL) THEN
			cur_out07 := cur_temp04;
		ELSIF (cur_out08 IS NULL) THEN
			cur_out08 := cur_temp04;
		ELSIF (cur_out09 IS NULL) THEN
			cur_out09 := cur_temp04;
		ELSIF (cur_out10 IS NULL) THEN
			cur_out10 := cur_temp04;
		ELSIF (cur_out11 IS NULL) THEN
			cur_out11 := cur_temp04;
		ELSIF (cur_out12 IS NULL) THEN
			cur_out12 := cur_temp04;
		ELSIF (cur_out13 IS NULL) THEN
			cur_out13 := cur_temp04;
		ELSIF (cur_out14 IS NULL) THEN
			cur_out14 := cur_temp04;
		ELSE
			cur_out14 := cur_temp04;
		END IF;

		OPEN cur_temp05 FOR
		SELECT    SUM(yalo.quantity) AS items,
			SUM(yalo.unit_price * yalo.quantity) AS price
		FROM
			(SELECT order_date, last_change_date, sku, NVL(quantity, 0) AS quantity, NVL(unit_price, 0) AS unit_price, credit_status
			FROM
				(SELECT *
				FROM YA_ASSOCIATE_LINK_ORDERS
				WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) YA_ASSOCIATE_LINK_ORDERS
			WHERE (YA_ASSOCIATE_LINK_ORDERS.order_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
		                                  (YA_ASSOCIATE_LINK_ORDERS.order_date <  TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
		                 	               (credit_status =1) AND (link_id = iLinkId) AND (unit_price > 0)
			) yalo
		GROUP BY TO_NUMBER(TO_CHAR(order_date, 'fmmm'));

		IF (cur_out01 IS NULL) THEN
			cur_out01 := cur_temp05;
		ELSIF (cur_out02 IS NULL) THEN
			cur_out02 := cur_temp05;
		ELSIF (cur_out03 IS NULL) THEN
			cur_out03 := cur_temp05;
		ELSIF (cur_out04 IS NULL) THEN
			cur_out04 := cur_temp05;
		ELSIF (cur_out05 IS NULL) THEN
			cur_out05 := cur_temp05;
		ELSIF (cur_out06 IS NULL) THEN
			cur_out06 := cur_temp05;
		ELSIF (cur_out07 IS NULL) THEN
			cur_out07 := cur_temp05;
		ELSIF (cur_out08 IS NULL) THEN
			cur_out08 := cur_temp05;
		ELSIF (cur_out09 IS NULL) THEN
			cur_out09 := cur_temp05;
		ELSIF (cur_out10 IS NULL) THEN
			cur_out10 := cur_temp05;
		ELSIF (cur_out11 IS NULL) THEN
			cur_out11 := cur_temp05;
		ELSIF (cur_out12 IS NULL) THEN
			cur_out12 := cur_temp05;
		ELSIF (cur_out13 IS NULL) THEN
			cur_out13 := cur_temp05;
		ELSIF (cur_out14 IS NULL) THEN
			cur_out14 := cur_temp05;
		ELSE
			cur_out14 := cur_temp05;
		END IF;

	END IF;

	IF (TO_DATE(cStartDate, 'mm/dd/yyyy') < TO_DATE(cCutOffDate, 'mm/dd/yyyy')) THEN
		OPEN cur_temp06 FOR
		SELECT    SUM(yalo.quantity) AS items,
			SUM(yalo.unit_price * yalo.quantity) AS price,
			TO_NUMBER(TO_CHAR(order_date,'fmmm')) AS posting_month,
			TO_NUMBER(TO_CHAR(order_date,'yyyy')) AS posting_year,
			(SELECT link_percentage FROM YA_ASSOCIATE_LINK WHERE associate_id=iAssociateId AND ROWNUM=1) AS percentage,
			--sum(yalo.unit_price * yalo.quantity) * (SELECT link_percentage FROM ya_associate_link WHERE associate_id=iAssociateId AND rownum = 1)  AS commission
			SUM(NVL(yalo.credit_amount, yalo.unit_price * yalo.quantity* NVL(comm_rate, NVL(percentage, (SELECT comm_rate FROM YA_ASSOCIATE_COMMISSION_HIST WHERE associate_id = 8050 AND ROWNUM=1))))) AS commission
		FROM
			(SELECT order_date, last_change_date, sku,NVL(quantity, 0) AS quantity, NVL(unit_price, 0) AS unit_price, credit_status, credit_amount
			FROM
				(SELECT *
				FROM YA_ASSOCIATE_LINK_ORDERS
				WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) YA_ASSOCIATE_LINK_ORDERS
			WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
				(YA_ASSOCIATE_LINK_ORDERS.last_change_date < TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (link_id = iLinkId) AND (unit_price > 0)
			) yalo
			LEFT OUTER JOIN YA_ASSOCIATE_COMMISSION_HIST yach ON yach.associate_id = iAssociateId
				AND yach.valid_date = TO_DATE(TO_CHAR(order_date, 'mm') || '/01/' || TO_CHAR(order_date, 'yyyy'), 'mm/dd/yyyy'),
				(SELECT percentage
				FROM YA_ASSOCIATE_COMMISSION_DETAIL cd
				INNER JOIN
					(SELECT comm_type_id, nc_max
					FROM YA_ASSOCIATE_COMMISSION_TYPE ct
               WHERE ((nc_min <=iCustomer AND nc_max >=iCustomer) OR (nc_max < iCustomer))
               ORDER BY nc_min DESC
					) ct
				ON ct.comm_type_id =cd.comm_type_id
				INNER JOIN
					(SELECT commission_id, payment_option
					FROM YA_ASSOCIATE
					WHERE associate_id=iAssociateId
					) ya
				ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
            WHERE ROWNUM=1
				)t
		GROUP BY TO_NUMBER(TO_CHAR(order_date,'fmmm')), TO_NUMBER(TO_CHAR(order_date, 'yyyy')) , comm_rate, t.percentage;

		IF (cur_out01 IS NULL) THEN
			cur_out01 := cur_temp06;
		ELSIF (cur_out02 IS NULL) THEN
			cur_out02 := cur_temp06;
		ELSIF (cur_out03 IS NULL) THEN
			cur_out03 := cur_temp06;
		ELSIF (cur_out04 IS NULL) THEN
			cur_out04 := cur_temp06;
		ELSIF (cur_out05 IS NULL) THEN
			cur_out05 := cur_temp06;
		ELSIF (cur_out06 IS NULL) THEN
			cur_out06 := cur_temp06;
		ELSIF (cur_out07 IS NULL) THEN
			cur_out07 := cur_temp06;
		ELSIF (cur_out08 IS NULL) THEN
			cur_out08 := cur_temp06;
		ELSIF (cur_out09 IS NULL) THEN
			cur_out09 := cur_temp06;
		ELSIF (cur_out10 IS NULL) THEN
			cur_out10 := cur_temp06;
		ELSIF (cur_out11 IS NULL) THEN
			cur_out11 := cur_temp06;
		ELSIF (cur_out12 IS NULL) THEN
			cur_out12 := cur_temp06;
		ELSIF (cur_out13 IS NULL) THEN
			cur_out13 := cur_temp06;
		ELSIF (cur_out14 IS NULL) THEN
			cur_out14 := cur_temp06;
		ELSE
			cur_out14 := cur_temp06;
		END IF;
	ELSE
		OPEN cur_temp07 FOR
		SELECT    SUM(yalo.quantity) AS items,
			SUM(yalo.unit_price * yalo.quantity) AS price,
			TO_NUMBER(TO_CHAR(order_date, 'fmmm')) AS posting_month,
			TO_NUMBER(TO_CHAR(order_date, 'yyyy')) AS posting_year,
			NVL(comm_rate, NVL(percentage, (SELECT comm_rate FROM YA_ASSOCIATE_COMMISSION_HIST WHERE associate_id = iAssociateId AND ROWNUM=1))) AS percentage,
			--sum(yalo.unit_price * yalo.quantity) * nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = iAssociateId AND rownum=1)))  AS commission
			SUM(NVL(yalo.credit_amount, yalo.unit_price * yalo.quantity* NVL(comm_rate, NVL(percentage, (SELECT comm_rate FROM YA_ASSOCIATE_COMMISSION_HIST WHERE associate_id = 8050 AND ROWNUM=1))))) AS commission
		FROM
			(SELECT order_date, last_change_date, sku, NVL(quantity, 0) AS quantity, NVL(unit_price, 0) AS unit_price, credit_status, credit_amount
			FROM
				(SELECT *
				FROM YA_ASSOCIATE_LINK_ORDERS
				WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) YA_ASSOCIATE_LINK_ORDERS
			WHERE
				(YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
				(YA_ASSOCIATE_LINK_ORDERS.last_change_date < TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (link_id = iLinkId) AND (unit_price > 0)
			) yalo
		LEFT OUTER JOIN YA_ASSOCIATE_COMMISSION_HIST yach ON yach.associate_id = iAssociateId
			AND yach.valid_date = TO_DATE(TO_CHAR(order_date, 'mm') || '/01/' || TO_CHAR(order_date, 'yyyy'), 'mm/dd/yyyy'),
			(SELECT percentage
			FROM YA_ASSOCIATE_COMMISSION_DETAIL cd
			INNER JOIN
				(SELECT comm_type_id, 	nc_max
				FROM YA_ASSOCIATE_COMMISSION_TYPE ct
				WHERE ((nc_min <=iCustomer AND nc_max >=iCustomer) OR (nc_max < iCustomer))
            ORDER BY nc_min DESC
				) ct
			ON ct.comm_type_id =cd.comm_type_id
			INNER JOIN
				(SELECT commission_id, payment_option
				FROM YA_ASSOCIATE
				WHERE associate_id=iAssociateId
				) ya
			ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
         WHERE ROWNUM=1
			)t
		GROUP BY TO_NUMBER(TO_CHAR(order_date,'fmmm')), TO_NUMBER(TO_CHAR(order_date, 'yyyy')) , comm_rate, t.percentage;

		IF (cur_out01 IS NULL) THEN
			cur_out01 := cur_temp07;
		ELSIF (cur_out02 IS NULL) THEN
			cur_out02 := cur_temp07;
		ELSIF (cur_out03 IS NULL) THEN
			cur_out03 := cur_temp07;
		ELSIF (cur_out04 IS NULL) THEN
			cur_out04 := cur_temp07;
		ELSIF (cur_out05 IS NULL) THEN
			cur_out05 := cur_temp07;
		ELSIF (cur_out06 IS NULL) THEN
			cur_out06 := cur_temp07;
		ELSIF (cur_out07 IS NULL) THEN
			cur_out07 := cur_temp07;
		ELSIF (cur_out08 IS NULL) THEN
			cur_out08 := cur_temp07;
		ELSIF (cur_out09 IS NULL) THEN
			cur_out09 := cur_temp07;
		ELSIF (cur_out10 IS NULL) THEN
			cur_out10 := cur_temp07;
		ELSIF (cur_out11 IS NULL) THEN
			cur_out11 := cur_temp07;
		ELSIF (cur_out12 IS NULL) THEN
			cur_out12 := cur_temp07;
		ELSIF (cur_out13 IS NULL) THEN
			cur_out13 := cur_temp07;
		ELSIF (cur_out14 IS NULL) THEN
			cur_out14 := cur_temp07;
		ELSE
			cur_out14 := cur_temp07;
		END IF;
	END IF;

END IF;

IF (iNeedGroup = 0) THEN

	IF (iBestSeller = 1) THEN
		OPEN cur_temp08 FOR
      SELECT * FROM(
         SELECT
            CASE
               WHEN (YA_PROD_LANG.prod_name_u IS NULL OR YA_PROD_LANG.prod_name_u = '')
               THEN (SELECT prod_name_u FROM YA_PROD_LANG WHERE sku=yalo.sku AND lang_id = 1)
               ELSE
               YA_PROD_LANG.prod_name_u
               END
            AS prod_name,
            yalo.sku,
            SUM(yalo.quantity) AS items, link_id,
            SUM(yalo.unit_price * yalo.quantity) AS price
         FROM
            (SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, YA_ASSOCIATE_LINK_ORDERS.link_id
            FROM
               (SELECT *
               FROM YA_ASSOCIATE_LINK_ORDERS
               WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
               ) YA_ASSOCIATE_LINK_ORDERS
            WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
               (YA_ASSOCIATE_LINK_ORDERS.last_change_date <  TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
               (credit_status = 2 OR credit_status = 1) AND (link_id = iLinkId) AND (unit_price > 0)
            ) yalo
            LEFT OUTER  JOIN YA_PRODUCT ON yalo.sku = YA_PRODUCT.sku
            LEFT OUTER  JOIN YA_PROD_LANG ON yalo.sku = YA_PROD_LANG.sku
         WHERE      (YA_PROD_LANG.lang_id = tiLangId)
         GROUP BY YA_PROD_LANG.prod_name_u,  yalo.sku, link_id
         ORDER BY items DESC)
      WHERE (ROWNUM<=20);

		IF (cur_out01 IS NULL) THEN
			cur_out01 := cur_temp08;
		ELSIF (cur_out02 IS NULL) THEN
			cur_out02 := cur_temp08;
		ELSIF (cur_out03 IS NULL) THEN
			cur_out03 := cur_temp08;
		ELSIF (cur_out04 IS NULL) THEN
			cur_out04 := cur_temp08;
		ELSIF (cur_out05 IS NULL) THEN
			cur_out05 := cur_temp08;
		ELSIF (cur_out06 IS NULL) THEN
			cur_out06 := cur_temp08;
		ELSIF (cur_out07 IS NULL) THEN
			cur_out07 := cur_temp08;
		ELSIF (cur_out08 IS NULL) THEN
			cur_out08 := cur_temp08;
		ELSIF (cur_out09 IS NULL) THEN
			cur_out09 := cur_temp08;
		ELSIF (cur_out10 IS NULL) THEN
			cur_out10 := cur_temp08;
		ELSIF (cur_out11 IS NULL) THEN
			cur_out11 := cur_temp08;
		ELSIF (cur_out12 IS NULL) THEN
			cur_out12 := cur_temp08;
		ELSIF (cur_out13 IS NULL) THEN
			cur_out13 := cur_temp08;
		ELSIF (cur_out14 IS NULL) THEN
			cur_out14 := cur_temp08;
		ELSE
			cur_out14 := cur_temp08;
		END IF;
	ELSE
		IF (iCreditStatus <> 1)  THEN
			OPEN cur_temp09 FOR
			SELECT  TO_CHAR(order_date, 'mm/dd/yyyy') AS order_date,
				TO_CHAR(last_change_date, 'mm/dd/yyyy') AS posting_date,
				CASE
					WHEN (YA_PROD_LANG.prod_name_u IS NULL OR YA_PROD_LANG.prod_name_u = '')
					THEN (SELECT prod_name_u FROM YA_PROD_LANG WHERE sku=yalo.sku AND lang_id = 1)
					ELSE
					YA_PROD_LANG.prod_name_u
					END
				AS prod_name,
				yalo.sku,
				SUM(yalo.quantity) AS items, link_id,
				SUM(yalo.unit_price * yalo.quantity) AS price
			FROM
				(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, YA_ASSOCIATE_LINK_ORDERS.link_id
				FROM
					(SELECT *
					FROM YA_ASSOCIATE_LINK_ORDERS
					WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
					) YA_ASSOCIATE_LINK_ORDERS
				WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
			                                  (YA_ASSOCIATE_LINK_ORDERS.last_change_date <  TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
			                 	               (credit_status = 2) AND (link_id = iLinkId) AND (unit_price > 0)) yalo
				LEFT OUTER  JOIN YA_PRODUCT ON yalo.sku = YA_PRODUCT.sku
				LEFT OUTER  JOIN YA_PROD_LANG ON yalo.sku = YA_PROD_LANG.sku
			WHERE      (YA_PROD_LANG.lang_id = tiLangId)
			GROUP BY YA_PROD_LANG.prod_name_u,  yalo.sku, link_id,
				TO_CHAR(order_date, 'mm/dd/yyyy'), TO_CHAR(last_change_date, 'mm/dd/yyyy')
			ORDER BY posting_date, prod_name;

			IF (cur_out01 IS NULL) THEN
				cur_out01 := cur_temp09;
			ELSIF (cur_out02 IS NULL) THEN
				cur_out02 := cur_temp09;
			ELSIF (cur_out03 IS NULL) THEN
				cur_out03 := cur_temp09;
			ELSIF (cur_out04 IS NULL) THEN
				cur_out04 := cur_temp09;
			ELSIF (cur_out05 IS NULL) THEN
				cur_out05 := cur_temp09;
			ELSIF (cur_out06 IS NULL) THEN
				cur_out06 := cur_temp09;
			ELSIF (cur_out07 IS NULL) THEN
				cur_out07 := cur_temp09;
			ELSIF (cur_out08 IS NULL) THEN
				cur_out08 := cur_temp09;
			ELSIF (cur_out09 IS NULL) THEN
				cur_out09 := cur_temp09;
			ELSIF (cur_out10 IS NULL) THEN
				cur_out10 := cur_temp09;
			ELSIF (cur_out11 IS NULL) THEN
				cur_out11 := cur_temp09;
			ELSIF (cur_out12 IS NULL) THEN
				cur_out12 := cur_temp09;
			ELSIF (cur_out13 IS NULL) THEN
				cur_out13 := cur_temp09;
			ELSIF (cur_out14 IS NULL) THEN
				cur_out14 := cur_temp09;
			ELSE
				cur_out14 := cur_temp09;
			END IF;
		END IF;

		IF (iCreditStatus <>2) THEN
			OPEN cur_temp10 FOR
			SELECT  TO_CHAR(order_date, 'mm/dd/yyyy') AS order_date, TO_CHAR(last_change_date, 'mm/dd/yyyy') AS posting_date,
			                CASE
					WHEN (YA_PROD_LANG.prod_name_u IS NULL OR YA_PROD_LANG.prod_name_u = '')
					THEN (SELECT prod_name_u FROM YA_PROD_LANG WHERE sku=yalo.sku AND lang_id = 1)
					ELSE YA_PROD_LANG.prod_name_u
					END
				AS prod_name,
				yalo.sku, SUM(yalo.quantity) AS items,
				SUM(yalo.unit_price * yalo.quantity) AS price, yalo.link_id,
			                      yg.group_id
			FROM
				(SELECT order_date, last_change_date, sku, NVL(quantity, 0) AS quantity, NVL(unit_price, 0) AS unit_price, credit_status, link_id
				FROM
					(SELECT *
					FROM YA_ASSOCIATE_LINK_ORDERS
					WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
					) YA_ASSOCIATE_LINK_ORDERS
				WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
			                                  (YA_ASSOCIATE_LINK_ORDERS.last_change_date <  TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
			                 	               (credit_status = 1) AND (link_id = iLinkId) AND (unit_price > 0)
				) yalo
				LEFT OUTER  JOIN YA_PRODUCT ON yalo.sku = YA_PRODUCT.sku
				LEFT OUTER  JOIN YA_PROD_LANG ON yalo.sku = YA_PROD_LANG.sku
				LEFT OUTER  JOIN
					(SELECT *
					FROM YA_GROUP
					WHERE division_id=1
					) yg
				ON yg.account_id = YA_PRODUCT.account_id
			WHERE      (YA_PROD_LANG.lang_id = tiLangId)
			GROUP BY YA_PROD_LANG.prod_name_u,  yalo.sku, yg.group_id, link_id,
				TO_CHAR(order_date, 'mm/dd/yyyy'), TO_CHAR(last_change_date, 'mm/dd/yyyy')
			ORDER BY group_id, posting_date, prod_name;

			IF (cur_out01 IS NULL) THEN
				cur_out01 := cur_temp10;
			ELSIF (cur_out02 IS NULL) THEN
				cur_out02 := cur_temp10;
			ELSIF (cur_out03 IS NULL) THEN
				cur_out03 := cur_temp10;
			ELSIF (cur_out04 IS NULL) THEN
				cur_out04 := cur_temp10;
			ELSIF (cur_out05 IS NULL) THEN
				cur_out05 := cur_temp10;
			ELSIF (cur_out06 IS NULL) THEN
				cur_out06 := cur_temp10;
			ELSIF (cur_out07 IS NULL) THEN
				cur_out07 := cur_temp10;
			ELSIF (cur_out08 IS NULL) THEN
				cur_out08 := cur_temp10;
			ELSIF (cur_out09 IS NULL) THEN
				cur_out09 := cur_temp10;
			ELSIF (cur_out10 IS NULL) THEN
				cur_out10 := cur_temp10;
			ELSIF (cur_out11 IS NULL) THEN
				cur_out11 := cur_temp10;
			ELSIF (cur_out12 IS NULL) THEN
				cur_out12 := cur_temp10;
			ELSIF (cur_out13 IS NULL) THEN
				cur_out13 := cur_temp10;
			ELSIF (cur_out14 IS NULL) THEN
				cur_out14 := cur_temp10;
			ELSE
				cur_out14 := cur_temp10;
			END IF;

			OPEN cur_temp11 FOR
			SELECT    SUM(yalo.quantity) AS items,
				SUM(yalo.unit_price * yalo.quantity) AS price
			FROM
				(SELECT order_date, last_change_date, sku, NVL(quantity, 0) AS quantity, NVL(unit_price, 0) AS unit_price, credit_status
				 FROM
					(SELECT *
					FROM YA_ASSOCIATE_LINK_ORDERS
					WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
					) YA_ASSOCIATE_LINK_ORDERS
				WHERE (YA_ASSOCIATE_LINK_ORDERS.order_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
			                                  (YA_ASSOCIATE_LINK_ORDERS.order_date <  TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
			                 	               (credit_status =1) AND (link_id = iLinkId) AND (unit_price > 0)
				) yalo
			GROUP BY TO_NUMBER(TO_CHAR(order_date, 'fmmm'));

			IF (cur_out01 IS NULL) THEN
				cur_out01 := cur_temp11;
			ELSIF (cur_out02 IS NULL) THEN
				cur_out02 := cur_temp11;
			ELSIF (cur_out03 IS NULL) THEN
				cur_out03 := cur_temp11;
			ELSIF (cur_out04 IS NULL) THEN
				cur_out04 := cur_temp11;
			ELSIF (cur_out05 IS NULL) THEN
				cur_out05 := cur_temp11;
			ELSIF (cur_out06 IS NULL) THEN
				cur_out06 := cur_temp11;
			ELSIF (cur_out07 IS NULL) THEN
				cur_out07 := cur_temp11;
			ELSIF (cur_out08 IS NULL) THEN
				cur_out08 := cur_temp11;
			ELSIF (cur_out09 IS NULL) THEN
				cur_out09 := cur_temp11;
			ELSIF (cur_out10 IS NULL) THEN
				cur_out10 := cur_temp11;
			ELSIF (cur_out11 IS NULL) THEN
				cur_out11 := cur_temp11;
			ELSIF (cur_out12 IS NULL) THEN
				cur_out12 := cur_temp11;
			ELSIF (cur_out13 IS NULL) THEN
				cur_out13 := cur_temp11;
			ELSIF (cur_out14 IS NULL) THEN
				cur_out14 := cur_temp11;
			ELSE
				cur_out14 := cur_temp11;
			END IF;
		END IF;
	END IF;

	IF (cStartDate < cCutOffDate) THEN
		OPEN cur_temp12 FOR
		SELECT    SUM(yalo.quantity) AS items,
			SUM(yalo.unit_price * yalo.quantity) AS price,
			TO_NUMBER(TO_CHAR(order_date, 'fmmm')) AS posting_month,
			TO_NUMBER(TO_CHAR(order_date, 'yyyy')) AS posting_year,
			(SELECT link_percentage FROM YA_ASSOCIATE_LINK WHERE associate_id=iAssociateId AND ROWNUM=1 ) AS percentage,
			--sum(yalo.unit_price * yalo.quantity) * (SELECT link_percentage FROM ya_associate_link WHERE associate_id=iAssociateId AND rownum=1) AS commission
			SUM(NVL(yalo.credit_amount, yalo.unit_price * yalo.quantity* NVL(comm_rate, NVL(percentage, (SELECT comm_rate FROM YA_ASSOCIATE_COMMISSION_HIST WHERE associate_id = 8050 AND ROWNUM=1))))) AS commission
		FROM
			(SELECT order_date, last_change_date, sku, NVL(quantity, 0) AS quantity, NVL(unit_price, 0) AS unit_price, credit_status, credit_amount
			FROM
				(SELECT *
				FROM YA_ASSOCIATE_LINK_ORDERS
				WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) YA_ASSOCIATE_LINK_ORDERS
			WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
				(YA_ASSOCIATE_LINK_ORDERS.last_change_date < TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (link_id = iLinkId) AND (unit_price > 0)
			) yalo
		LEFT OUTER JOIN YA_ASSOCIATE_COMMISSION_HIST yach ON yach.associate_id = iAssociateId
			AND yach.valid_date = TO_DATE(TO_CHAR(order_date, 'mm') || '/01/' || TO_CHAR(order_date, 'yyyy'), 'mm/dd/yyyy'),
			(SELECT percentage  FROM YA_ASSOCIATE_COMMISSION_DETAIL cd INNER JOIN
			(SELECT comm_type_id, nc_max FROM YA_ASSOCIATE_COMMISSION_TYPE ct WHERE ((nc_min <= iCustomer AND nc_max >= iCustomer) OR nc_max < iCustomer)) ct
			ON ct.comm_type_id =cd.comm_type_id
			INNER JOIN
				(SELECT commission_id, payment_option
				FROM YA_ASSOCIATE
				WHERE associate_id=iAssociateId
				) ya
			ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
         WHERE ROWNUM=1
			)t
		GROUP BY TO_NUMBER(TO_CHAR(order_date, 'fmmm')), TO_NUMBER(TO_CHAR(order_date, 'yyyy')) , comm_rate, t.percentage;

		IF (cur_out01 IS NULL) THEN
			cur_out01 := cur_temp12;
		ELSIF (cur_out02 IS NULL) THEN
			cur_out02 := cur_temp12;
		ELSIF (cur_out03 IS NULL) THEN
			cur_out03 := cur_temp12;
		ELSIF (cur_out04 IS NULL) THEN
			cur_out04 := cur_temp12;
		ELSIF (cur_out05 IS NULL) THEN
			cur_out05 := cur_temp12;
		ELSIF (cur_out06 IS NULL) THEN
			cur_out06 := cur_temp12;
		ELSIF (cur_out07 IS NULL) THEN
			cur_out07 := cur_temp12;
		ELSIF (cur_out08 IS NULL) THEN
			cur_out08 := cur_temp12;
		ELSIF (cur_out09 IS NULL) THEN
			cur_out09 := cur_temp12;
		ELSIF (cur_out10 IS NULL) THEN
			cur_out10 := cur_temp12;
		ELSIF (cur_out11 IS NULL) THEN
			cur_out11 := cur_temp12;
		ELSIF (cur_out12 IS NULL) THEN
			cur_out12 := cur_temp12;
		ELSIF (cur_out13 IS NULL) THEN
			cur_out13 := cur_temp12;
		ELSIF (cur_out14 IS NULL) THEN
			cur_out14 := cur_temp12;
		ELSE
			cur_out14 := cur_temp12;
		END IF;
	ELSE
		OPEN cur_temp13 FOR
		SELECT    SUM(yalo.quantity) AS items,
			SUM(yalo.unit_price * yalo.quantity) AS price,
			TO_NUMBER(TO_CHAR(order_date, 'fmmm')) AS posting_month,
			TO_NUMBER(TO_CHAR(order_date, 'yyyy')) AS posting_year,
			NVL(comm_rate, NVL(percentage, (SELECT comm_rate FROM YA_ASSOCIATE_COMMISSION_HIST WHERE associate_id = iAssociateId AND ROWNUM=1))) AS percentage,
			SUM(yalo.unit_price * yalo.quantity) * NVL(comm_rate, NVL(percentage, (SELECT comm_rate FROM YA_ASSOCIATE_COMMISSION_HIST WHERE associate_id = iAssociateId AND ROWNUM=1 )))  AS commission
		FROM
			(SELECT order_date, last_change_date, sku, NVL(quantity, 0) AS quantity, NVL(unit_price, 0) AS unit_price, credit_status, credit_amount
			FROM
				(SELECT *
				FROM YA_ASSOCIATE_LINK_ORDERS
				WHERE sku NOT IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) YA_ASSOCIATE_LINK_ORDERS
			WHERE (YA_ASSOCIATE_LINK_ORDERS.last_change_date >= TO_DATE(cStartDate, 'mm/dd/yyyy')) AND
				(YA_ASSOCIATE_LINK_ORDERS.last_change_date < TO_DATE(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (link_id = iLinkId) AND (unit_price > 0)
			) yalo
			LEFT OUTER JOIN YA_ASSOCIATE_COMMISSION_HIST yach ON yach.associate_id = iAssociateId
				AND yach.valid_date = TO_DATE(TO_CHAR(order_date, 'mm') || '/01/' || TO_CHAR(order_date, 'yyyy'), 'mm/dd/yyyy'),
				(SELECT percentage  FROM YA_ASSOCIATE_COMMISSION_DETAIL cd INNER JOIN
				(SELECT comm_type_id, nc_max FROM YA_ASSOCIATE_COMMISSION_TYPE ct WHERE ((nc_min <= iCustomer AND nc_max >= iCustomer) OR nc_max < iCustomer)) ct
				ON ct.comm_type_id =cd.comm_type_id
				INNER JOIN
					(SELECT commission_id, payment_option
					FROM YA_ASSOCIATE
					WHERE associate_id=iAssociateId
					) ya
			ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
			)t
		GROUP BY TO_NUMBER(TO_CHAR(order_date, 'fmmm')), TO_NUMBER(TO_CHAR(order_date, 'yyyy')), comm_rate, t.percentage;

		IF (cur_out01 IS NULL) THEN
			cur_out01 := cur_temp13;
		ELSIF (cur_out02 IS NULL) THEN
			cur_out02 := cur_temp13;
		ELSIF (cur_out03 IS NULL) THEN
			cur_out03 := cur_temp13;
		ELSIF (cur_out04 IS NULL) THEN
			cur_out04 := cur_temp13;
		ELSIF (cur_out05 IS NULL) THEN
			cur_out05 := cur_temp13;
		ELSIF (cur_out06 IS NULL) THEN
			cur_out06 := cur_temp13;
		ELSIF (cur_out07 IS NULL) THEN
			cur_out07 := cur_temp13;
		ELSIF (cur_out08 IS NULL) THEN
			cur_out08 := cur_temp13;
		ELSIF (cur_out09 IS NULL) THEN
			cur_out09 := cur_temp13;
		ELSIF (cur_out10 IS NULL) THEN
			cur_out10 := cur_temp13;
		ELSIF (cur_out11 IS NULL) THEN
			cur_out11 := cur_temp13;
		ELSIF (cur_out12 IS NULL) THEN
			cur_out12 := cur_temp13;
		ELSIF (cur_out13 IS NULL) THEN
			cur_out13 := cur_temp13;
		ELSIF (cur_out14 IS NULL) THEN
			cur_out14 := cur_temp13;
		ELSE
			cur_out14 := cur_temp13;
		END IF;
	END IF;
END IF;

OPEN cur_temp14 FOR
SELECT link_id, '<B>' || site_name || '</B> (' || link_code || ')' AS site_name FROM YA_ASSOCIATE_LINK WHERE associate_id = iAssociateId;
IF (cur_out01 IS NULL) THEN
	cur_out01 := cur_temp14;
ELSIF (cur_out02 IS NULL) THEN
	cur_out02 := cur_temp14;
ELSIF (cur_out03 IS NULL) THEN
	cur_out03 := cur_temp14;
ELSIF (cur_out04 IS NULL) THEN
	cur_out04 := cur_temp14;
ELSIF (cur_out05 IS NULL) THEN
	cur_out05 := cur_temp14;
ELSIF (cur_out06 IS NULL) THEN
	cur_out06 := cur_temp14;
ELSIF (cur_out07 IS NULL) THEN
	cur_out07 := cur_temp14;
ELSIF (cur_out08 IS NULL) THEN
	cur_out08 := cur_temp14;
ELSIF (cur_out09 IS NULL) THEN
	cur_out09 := cur_temp14;
ELSIF (cur_out10 IS NULL) THEN
	cur_out10 := cur_temp14;
ELSIF (cur_out11 IS NULL) THEN
	cur_out11 := cur_temp14;
ELSIF (cur_out12 IS NULL) THEN
	cur_out12 := cur_temp14;
ELSIF (cur_out13 IS NULL) THEN
	cur_out13 := cur_temp14;
ELSIF (cur_out14 IS NULL) THEN
	cur_out14 := cur_temp14;
ELSE
	cur_out14 := cur_temp14;
END IF;
SELECT NVL(lang_id, 1) INTO iLangId FROM YA_ASSOCIATE_LINK WHERE associate_id = iAssociateId AND ROWNUM=1;


IF (cur_out01 IS NULL) THEN
	OPEN cur_out01 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out02 IS NULL) THEN
	OPEN cur_out02 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out03 IS NULL) THEN
	OPEN cur_out03 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out04 IS NULL) THEN
	OPEN cur_out04 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out05 IS NULL) THEN
	OPEN cur_out05 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out06 IS NULL) THEN
	OPEN cur_out06 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out07 IS NULL) THEN
	OPEN cur_out07 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out08 IS NULL) THEN
	OPEN cur_out08 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out09 IS NULL) THEN
	OPEN cur_out09 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out10 IS NULL) THEN
	OPEN cur_out10 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out11 IS NULL) THEN
	OPEN cur_out11 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out12 IS NULL) THEN
	OPEN cur_out12 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out13 IS NULL) THEN
	OPEN cur_out13 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out14 IS NULL) THEN
	OPEN cur_out14 FOR
	SELECT 'null_cursor' FROM dual;
END IF;
END sp_fe_asso_selOrderByLid;

PROCEDURE sp_fe_asso_getContentPageInfo
(
  iPpageId IN INT,
  iPsiteId IN INT,
  curPout_1 OUT cur_return, --creative text(banner)
  curPout_2 OUT cur_return,  --creative button(button, promotion corner)
  curPout_3 OUT cur_return  --product lot
)
AS
BEGIN
  OPEN curPout_1 FOR
  SELECT
    l.creative_id AS creative_id,
    l.location AS location,
    l.priority AS priority
  FROM
    YA_CM_CREATIVE c,
    YA_CM_CREATIVE_LOCATION l
  WHERE
    l.file_id = iPpageId
    AND l.site_id = iPsiteId
    AND c.TYPE = 1
    AND c.status <> 3
    AND c.ENABLE = 'Y'
    AND c.creative_id = l.creative_id
  ORDER BY location,priority;

  OPEN curPout_2 FOR
  SELECT
    l.creative_id AS creative_id,
    l.location AS location,
    l.priority AS priority
  FROM
    YA_CM_CREATIVE c,
    YA_CM_CREATIVE_LOCATION l
  WHERE
    l.file_id = iPpageId
    AND l.site_id = iPsiteId
    AND c.TYPE IN (2, 3)
    AND c.status <> 3
    AND c.ENABLE = 'Y'
    AND c.creative_id = l.creative_id
  ORDER BY location,priority;
  IF (curPout_1 IS NULL) THEN
    curPout_1 := curPout_2;
  END IF;

  OPEN curPout_3 FOR
  SELECT
    l.prod_lot_id AS prod_lot_id,
    l.lot_location AS location,
    l.priority AS priority
  FROM
    YA_PRODUCT_LOT l
  WHERE
    l.file_id = iPpageId
  ORDER BY l.lot_location, l.priority;
  IF (curPout_1 IS NULL) THEN
    BEGIN
      curPout_1 := curPout_3;
    END;
  ELSIF (curPout_2 IS NULL) THEN
    BEGIN
      curPout_2 := curPout_3;
    END;
  END IF;

  IF (curPout_1 IS NULL) THEN
  	OPEN curPout_1 FOR
	  SELECT 'null_cursor' FROM dual;
  END IF;
  IF (curPout_2 IS NULL) THEN
    OPEN curPout_2 FOR
    SELECT 'null_cursor' FROM dual;
  END IF;
  IF (curPout_3 IS NULL) THEN
    OPEN curPout_3 FOR
    SELECT 'null_cursor' FROM dual;
  END IF;
END sp_fe_asso_getContentPageInfo;

PROCEDURE sp_fe_asso_getCreativeText
(
  iPcreativeId IN INT,
  iPlangId IN INT,
  curPout_1 OUT cur_return
)
AS
BEGIN
  OPEN curPout_1 FOR
  SELECT
    ctl.content,
    c.creative_group_id,
    c.TYPE
  FROM
    YA_CM_CREATIVE c,
    YA_CM_CREATIVE_TEXT_LANG ctl
  WHERE
    ctl.lang_id = iPlangId
    AND c.creative_id = iPcreativeId
    AND c.creative_id = ctl.creative_id
    AND c.ENABLE='Y'
    AND TYPE = 1
    AND c.status<> 3;
  IF (curPout_1 IS NULL) THEN
    OPEN curPout_1 FOR
    SELECT 'null_cursor' FROM dual;
  END IF;
END sp_fe_asso_getCreativeText;

PROCEDURE sp_fe_asso_getCreativeButton
(
  iPcreativeId IN INT,
  iPlangId IN INT,
  curPout_1 OUT cur_return
)
AS
BEGIN
  OPEN curPout_1 FOR
  SELECT
    cbl.image_loc AS image_loc,
    cbl.image_width AS image_width,
    cbl.image_height AS image_height,
    cbl.alt AS alt,
    cbl.link_url AS link_url,
    c.creative_group_id AS creative_group_id,
    c.TYPE AS TYPE
  FROM
    YA_CM_CREATIVE c,
    YA_CM_CREATIVE_BUTTON_LANG cbl
  WHERE
    cbl.lang_id = iPlangId
    AND c.creative_id = iPcreativeId
    AND c.creative_id = cbl.creative_id
    AND c.ENABLE='Y'
    AND c.TYPE IN (2,3)
    AND c.status<> 3;
  IF (curPout_1 IS NULL) THEN
    OPEN curPout_1 FOR
    SELECT 'null_cursor' FROM dual;
  END IF;
END sp_fe_asso_getCreativeButton;

PROCEDURE sp_fe_asso_getProductLot
(
  iPproductLotId IN INT,
  iPlangId IN INT,
  curPout_1 OUT cur_return
)
AS
BEGIN
  OPEN curPout_1 FOR
  SELECT
    pl.sku AS sku,
    pl.dept_id AS deptId
  FROM YA_PRODUCT_LOT pl
  WHERE
    pl.prod_lot_id = iPproductLotId;
  IF (curPout_1 IS NULL) THEN
    OPEN curPout_1 FOR
    SELECT 'null_cursor' FROM dual;
  END IF;
END sp_fe_asso_getProductLot;

END Pkg_fe_asso;
/
