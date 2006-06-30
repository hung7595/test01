CREATE OR REPLACE package Pkg_fe_asso AS

type cur_return IS ref cursor;
type cur_asso IS ref cursor return ya_associate%rowtype;
type cur_assoCommDetail IS ref cursor return ya_associate_commission_detail%rowtype;

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
	iSiteId out INT,
	cPassword out VARCHAR2,
	iAssociateId out INT,
	cShopperId out VARCHAR2,
	cName out VARCHAR2,
	iLangId out INT
);
PROCEDURE sp_fe_asso_selAssoId
(
	cSsn IN VARCHAR2,
	cPayeeName IN VARCHAR2,
	cPayeeEmailAddress IN VARCHAR2,
	cur_out1 out cur_return
);
PROCEDURE sp_fe_asso_anonymousShopper
(
	cShopperId IN VARCHAR2,
	nIsAnonymous out number
);
PROCEDURE sp_fe_asso_readAsso
(
	cShopperId IN VARCHAR2,
	iSiteId IN INT,
	cur_out1 out cur_return
);
PROCEDURE sp_fe_asso_isAsso
(
	iSiteId IN INT,
	cShopperId IN VARCHAR2,
	iAssociateId out INT
);
PROCEDURE sp_fe_asso_getComm
(
	iAssociateId IN INT,
	cur_out1 out cur_return
);
PROCEDURE sp_fe_asso_getLinkName
(
	iLinkId IN INT,
	cLinkName out VARCHAR2,
	iLangId out INT
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
	iRowAffected out INT
);
PROCEDURE sp_fe_asso_insAssoHitsRaw
(
	cCode IN VARCHAR2,
	iRowAffected out INT
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
	iRowAffected out INT
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
	iAssociateId out INT,
	iRowAffected out INT
);
PROCEDURE sp_fe_asso_updComm
(
	deci11 IN float,
	deci12 IN float,
	deci13 IN float,
	deci21 IN float,
	deci22 IN float,
	deci23 IN float,
	deci31 IN float,
	deci32 IN float,
	deci33 IN float,
	deci41 IN float,
	deci42 IN float,
	deci43 IN float,
	deci51 IN float,
	deci52 IN float,
	deci53 IN float,
	iCommId IN INT,
	iRowAffected out INT
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
	iRowAffected out INT
);
PROCEDURE sp_fe_asso_link
(
	cShopperId IN VARCHAR2,
	iSiteId IN INT,
	iLangId out INT,
	cur_out1 out cur_return,
	cur_out2 out cur_return
);
PROCEDURE sp_fe_asso_linkDetail
(
	iLinkId IN INT,
	cur_out1 out cur_return
);
PROCEDURE sp_fe_asso_linkPageview
(
	iLinkId IN INT,
	cur_out1 out cur_return
);
PROCEDURE sp_fe_asso_pageview
(
	cShopperId IN VARCHAR2,
	iSiteId IN INT,
	cur_out1 out cur_return
);
PROCEDURE sp_fe_asso_password
(
	cEmail IN VARCHAR2,
	cur_out1 out cur_return
);
PROCEDURE sp_fe_asso_payHistory
(
	cShopperId IN VARCHAR2,
	iSiteId IN INT,
	deciTotalCommision out float,
	cur_out1 out cur_return
);
PROCEDURE sp_fe_asso_login
(
	iSiteId IN INT,
	cEmail IN VARCHAR2,
	cPassword out VARCHAR2,
	iAssociateId out INT,
	cShopperId out VARCHAR2,
	cName out VARCHAR2,
	iLangId out INT,
	iRowAffected out INT
);
PROCEDURE sp_fe_asso_getCreditSummary
(
	iAssociateId IN INT,
	cur_out1 out cur_return
);
PROCEDURE sp_fe_asso_createComm
(
	deci11 IN float,
	deci12 IN float,
	deci13 IN float,
	deci21 IN float,
	deci22 IN float,
	deci23 IN float,
	deci31 IN float,
	deci32 IN float,
	deci33 IN float,
	deci41 IN float,
	deci42 IN float,
	deci43 IN float,
	deci51 IN float,
	deci52 IN float,
	deci53 IN float,
	iAssocaiteId IN INT,
	iCommId out INT,
	iRowAffected out INT
);
PROCEDURE sp_fe_asso_selImgLotLang
(
	iLotId IN INT,
	iLangId IN INT,
	cur_out1 out cur_return
);
PROCEDURE sp_fe_asso_exportSales
(
	cMonth VARCHAR2,
	cYear VARCHAR2,
	iAssociateId INT,
	iLangId INT,
	iCreditStatus INT,
	cur_out1 out cur_return,
	cur_out2 out cur_return
);
PROCEDURE sp_fe_asso_monthlyCredit
(
	iAssociateId IN INT,
	deciPercentage out float,
	deciOldPercentage out float,
	deciLastApproved out float,
	cur_out1 out cur_return,
	cur_out2 out cur_return
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
	iCustomer out INT,
	deciPercentage out float,
	iNextLevel out INT,
	iLangId out INT,
	deciThisPeriodComm out float,
	deciTotalComm out float,
	cur_out01 out cur_return,
	cur_out02 out cur_return,
	cur_out03 out cur_return,
	cur_out04 out cur_return,
	cur_out05 out cur_return,
	cur_out06 out cur_return,
	cur_out07 out cur_return,
	cur_out08 out cur_return,
	cur_out09 out cur_return,
	cur_out10 out cur_return,
	cur_out11 out cur_return,
	cur_out12 out cur_return,
	cur_out13 out cur_return,
	cur_out14 out cur_return
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
	iCustomer out INT,
	deciPercentage out float,
	iNextLevel out INT,
	iLangId out INT,
	deciThisPeriodComm out float,
	deciTotalComm out float,
	cur_out01 out cur_return,
	cur_out02 out cur_return,
	cur_out03 out cur_return,
	cur_out04 out cur_return,
	cur_out05 out cur_return,
	cur_out06 out cur_return,
	cur_out07 out cur_return,
	cur_out08 out cur_return,
	cur_out09 out cur_return,
	cur_out10 out cur_return,
	cur_out11 out cur_return,
	cur_out12 out cur_return,
	cur_out13 out cur_return,
	cur_out14 out cur_return
);

END Pkg_fe_asso;
/

CREATE OR REPLACE package body Pkg_fe_asso AS


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

SELECT link_code INTO cOldLinkCode FROM ya_associate_link WHERE link_id = iLinkId;
IF (cOldLinkCode IS null) OR (length(cOldLinkCode)<1) THEN
	while (iCheck>0) loop
		while (iCount<iLength) loop
			while (not(((iCharCode>=ascii('0'))AND(iCharCode<=ascii('9')))OR((iCharCode>=ascii('A'))AND(iCharCode<=ascii('Z'))))) loop
				SELECT (1+ABS(MOD(dbms_random.random,ascii('Z')))) INTO iCharCode FROM dual;
			END loop;
			cLinkCode := cLinkCode || chr(iCharCode);
			iCharCode := 0;
			iCount := iCount+1;
		END loop;
		SELECT count(*) INTO iCheck FROM ya_associate_link WHERE link_code=cLinkCode;
	END loop;
END IF;

UPDATE
	ya_associate_link
SET
	link_code = cLinkCode
WHERE
	link_id = iLinkId;

IF (sqlcode=0) THEN
	commit;
ELSE
	rollback;
END IF;

END sp_fe_asso_genLinkCode;


PROCEDURE sp_fe_asso_myLogin
(
	cEmail IN VARCHAR2,
	iSiteId out INT,
	cPassword out VARCHAR2,
	iAssociateId out INT,
	cShopperId out VARCHAR2,
	cName out VARCHAR2,
	iLangId out INT
) IS
BEGIN

SELECT
	site_id,
	associate_id,
	shopper_id,
	contact_name,
	password,
	nvl(lang_id, 1)
	INTO
	iSiteId,
	iAssociateId,
	cShopperId,
	cName,
	cPassword,
	iLangId
FROM (
   SELECT
      ya_associate.site_id,
      ya_associate.associate_id,
      ya_shopper.shopper_id,
      ya_associate.contact_name,
      ya_shopper.PASSWORD,
      ya_associate.lang_id
   FROM
      ya_shopper LEFT OUTER JOIN ya_associate
   ON
      ya_shopper.shopper_id = ya_associate.shopper_id
   WHERE
      LOWER(ya_shopper.email) = LOWER(cEmail)
	)
WHERE
	ROWNUM = 1;

END sp_fe_asso_myLogin;


PROCEDURE sp_fe_asso_selAssoId(cSsn IN VARCHAR2, cPayeeName IN varchar2, cPayeeEmailAddress IN varchar2, cur_out1 out cur_return) IS
BEGIN

IF (length(cSsn)>0) THEN
	OPEN cur_out1 for
	SELECT * FROM ya_associate WHERE taxid_ssn=cSsn;
elsif (length(cPayeeName)>0) THEN
	OPEN cur_out1 for
	SELECT * FROM ya_associate WHERE payee_name like '%'+cPayeeName+'%';
elsif (length(cPayeeEmailAddress)>0) THEN
	OPEN cur_out1 for
	SELECT * FROM ya_associate WHERE payee_email like '%'+cPayeeEmailAddress+'%';
END IF;

END sp_fe_asso_selAssoId;


PROCEDURE sp_fe_asso_anonymousShopper(cShopperId IN VARCHAR2, nIsAnonymous out number) IS
	cAnonymous char(1);
	iCount INT;
BEGIN

SELECT 'Y' INTO cAnonymous FROM dual;
SELECT count(1) INTO iCount FROM ya_shopper WHERE shopper_id = cShopperId;
IF (iCount>0) THEN
   SELECT anonymous INTO cAnonymous FROM ya_shopper WHERE shopper_id = cShopperId;
END IF;

IF (cAnonymous='Y') THEN
	nIsAnonymous := 1;
ELSE
	nIsAnonymous := 0;
END IF;

END sp_fe_asso_anonymousShopper;


PROCEDURE sp_fe_asso_readAsso(cShopperId IN VARCHAR2, ISiteId IN INT, cur_out1 out cur_return) IS
BEGIN

OPEN cur_out1 for
SELECT
	*
FROM
	ya_associate
WHERE
	shopper_id = cShopperId
	AND
	site_id = ISiteId;

END sp_fe_asso_readAsso;


PROCEDURE sp_fe_asso_isAsso(iSiteId IN INT, cShopperId IN VARCHAR2, iAssociateId out int) IS
BEGIN

SELECT
nvl(associate_id, -1) INTO iAssociateid
FROM
ya_associate
WHERE
associate_approved='Y'
AND site_id=iSiteId
AND shopper_id=cShopperId;

exception
WHEN NO_DATA_FOUND THEN
	iAssociateId := -1;
WHEN OTHERS THEN
	iAssociateId := -1;

END sp_fe_asso_isAsso;


PROCEDURE sp_fe_asso_getComm(iAssociateId IN INT, cur_out1 out cur_return) IS
BEGIN

OPEN cur_out1 for
SELECT
*
FROM
ya_associate_commission_detail
WHERE
commission_id = (SELECT commission_id FROM ya_associate WHERE associate_id = iAssociateId);

END sp_fe_asso_getComm;


PROCEDURE sp_fe_asso_getLinkName(iLinkId IN INT, cLinkName out VARCHAR2, iLangId out int) IS
	type typeLinkDetails IS record(c_link_name VARCHAR2(100), i_lang_id INT);
	ret_link_details typeLinkDetails;
BEGIN

SELECT
	site_name,
	nvl(lang_id, -1)
	INTO
	ret_link_details
FROM
	ya_associate_link
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
	iRowAffected out INT
) IS
	iCount INT;
	oriPaymentOption INT;
	cSsnApproved char(1);
BEGIN

SELECT count(*) INTO iCount FROM ya_associate WHERE shopper_id=cShopperId;
IF (iCount<1) THEN
/*
	IF (iPaymentOption=1) THEN
		cSsnApproved := 'Y';
	ELSE
		cSsnApproved := 'N';
	END IF;
*/
	cSsnApproved := 'N';

	INSERT INTO ya_associate
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

	IF (iPaymentOption=1) THEN
		cSsnApproved := 'Y';
	ELSE
		cSsnApproved := 'Y';
	END IF;
	SELECT payment_option INTO oriPaymentOption
	FROM ya_associate WHERE shopper_id = cShopperId;
	IF (oriPaymentOption=iPaymentOption) THEN
		SELECT ssn_approved INTO cSsnApproved FROM ya_associate WHERE shopper_id=cShopperId;
	END IF;
	UPDATE ya_associate
	SET taxid_ssn = cPSSN,
		company_name = cComp,
		site_id = ISiteId,
		join_date = (SYSDATE),
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
		ssn_approved = cSsnApproved,
		lang_id = iLangId
		WHERE  shopper_id  = cShopperId;

END IF;
iRowAffected := SQL%ROWCOUNT;

IF (iRowAffected>0) AND (SQLCODE=0) THEN
	commit;
ELSE
	rollback;
END IF;

END sp_fe_asso_insAsso;


PROCEDURE sp_fe_asso_insAssoHitsRaw(cCode IN VARCHAR2, iRowAffected out INT) IS
	iLinkId INT;
BEGIN

SELECT link_id INTO iLinkId FROM ya_associate_link WHERE link_code = cCode;

INSERT INTO ya_associate_hits_raw (link_id, hit_datetime) VALUES(iLinkId, sysdate);
iRowAffected := SQL%ROWCOUNT;

IF (iRowAffected>0) THEN
	commit;
ELSE
	rollback;
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
	iRowAffected out INT
) IS
BEGIN

INSERT INTO ya_associate_link
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
	commit;
ELSE
	rollback;
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
	iAssociateId out INT,
	iRowAffected out INT
) IS
	oriPaymentOption INT;
	cSsnApproved char(1);
BEGIN
/*
IF (iPaymentOption=1) THEN
	cSsnApproved := 'Y';
ELSE
	cSsnApproved := 'N';
END IF;
SELECT payment_option INTO oriPaymentOption
FROM ya_associate WHERE shopper_id = cShopperId AND site_id = ISiteID;
IF (oriPaymentOption=iPaymentOption) THEN
	SELECT ssn_approved INTO cSsnApproved FROM ya_associate WHERE shopper_id=cShopperId AND site_id = ISiteID AND rownum=1;
END IF;
*/

UPDATE ya_associate
SET taxid_ssn = cPSSN,
	--site_id = ISiteId,
	join_date = (SYSDATE),
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
--	ssn_approved = cSsnApproved,
	lang_id = iLangId
	WHERE  shopper_id  = cShopperId AND site_id = ISiteID;

SELECT associate_id INTO iAssociateId FROM ya_associate WHERE ((shopper_id = cShopperId)  AND (site_id=iSiteId));
iRowAffected := SQL%ROWCOUNT;

IF (iRowAffected>0) THEN
	commit;
ELSE
	rollback;
END IF;

END sp_fe_asso_updAsso;


PROCEDURE sp_fe_asso_updComm
(
	deci11 IN float,
	deci12 IN float,
	deci13 IN float,
	deci21 IN float,
	deci22 IN float,
	deci23 IN float,
	deci31 IN float,
	deci32 IN float,
	deci33 IN float,
	deci41 IN float,
	deci42 IN float,
	deci43 IN float,
	deci51 IN float,
	deci52 IN float,
	deci53 IN float,
	iCommId IN INT,
	iRowAffected out INT
) IS
BEGIN

UPDATE ya_associate_commission_detail SET percentage=deci11 WHERE commission_id = iCommId AND comm_type_id = 1 AND payment_option = 1;
UPDATE ya_associate_commission_detail SET percentage=deci12 WHERE commission_id = iCommId AND comm_type_id = 1 AND payment_option = 2;
UPDATE ya_associate_commission_detail SET percentage=deci13 WHERE commission_id = iCommId AND comm_type_id = 1 AND payment_option = 3;
UPDATE ya_associate_commission_detail SET percentage=deci21 WHERE commission_id = iCommId AND comm_type_id = 2 AND payment_option = 1;
UPDATE ya_associate_commission_detail SET percentage=deci22 WHERE commission_id = iCommId AND comm_type_id = 2 AND payment_option = 2;
UPDATE ya_associate_commission_detail SET percentage=deci23 WHERE commission_id = iCommId AND comm_type_id = 2 AND payment_option = 3;
UPDATE ya_associate_commission_detail SET percentage=deci31 WHERE commission_id = iCommId AND comm_type_id = 3 AND payment_option = 1;
UPDATE ya_associate_commission_detail SET percentage=deci32 WHERE commission_id = iCommId AND comm_type_id = 3 AND payment_option = 2;
UPDATE ya_associate_commission_detail SET percentage=deci33 WHERE commission_id = iCommId AND comm_type_id = 3 AND payment_option = 3;
UPDATE ya_associate_commission_detail SET percentage=deci41 WHERE commission_id = iCommId AND comm_type_id = 4 AND payment_option = 1;
UPDATE ya_associate_commission_detail SET percentage=deci42 WHERE commission_id = iCommId AND comm_type_id = 4 AND payment_option = 2;
UPDATE ya_associate_commission_detail SET percentage=deci43 WHERE commission_id = iCommId AND comm_type_id = 4 AND payment_option = 3;
UPDATE ya_associate_commission_detail SET percentage=deci51 WHERE commission_id = iCommId AND comm_type_id = 5 AND payment_option = 1;
UPDATE ya_associate_commission_detail SET percentage=deci52 WHERE commission_id = iCommId AND comm_type_id = 5 AND payment_option = 2;
UPDATE ya_associate_commission_detail SET percentage=deci53 WHERE commission_id = iCommId AND comm_type_id = 5 AND payment_option = 3;

IF (SQLCODE!=0) THEN
	iRowAffected := 0;
	rollback;
ELSE
	iRowAffected := SQL%ROWCOUNT;
	commit;
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
	iRowAffected out INT
) IS
BEGIN

UPDATE ya_associate_link SET
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
	rollback;
ELSE
	iRowAffected := SQL%ROWCOUNT;
	commit;
END IF;

END sp_fe_asso_updLink;


PROCEDURE sp_fe_asso_link
(
	cShopperId IN VARCHAR2,
	iSiteId IN INT,
	iLangId out INT,
	cur_out1 out cur_return,
	cur_out2 out cur_return
) IS
BEGIN

OPEN cur_out1 for
SELECT nvl(sum(hits), 0)  AS total, al.link_id
FROM ya_associate_hits_summary ah
	RIGHT OUTER JOIN
	   (SELECT al.link_id  FROM ya_associate_link al
		    INNER JOIN (SELECT * FROM ya_associate WHERE shopper_id = cShopperId) a ON al.associate_id = a.associate_id AND a.site_id = ISiteId
		    AND (al.link_status = 2 OR al.link_status = 4)) al
	ON al.link_id = ah.link_id
GROUP BY al.link_id;

OPEN cur_out2 for
SELECT a.associate_id, al.site_name, al.link_id, ar.credit_status, nvl(sum(ar.credit_amount),0) AS credit, al.link_code,
nvl(ah.total_credit,0) AS total
 FROM (SELECT * FROM ya_associate WHERE shopper_id = cShopperId AND site_id = ISiteId)  a
	INNER JOIN ya_associate_link al ON a.associate_id = al.associate_id AND al.link_status > 1
	LEFT OUTER JOIN ya_associate_legacy_history ah on ah.link_id = al.link_id
	 LEFT OUTER JOIN ya_associate_link_orders ar on ar.link_id = al.link_id AND ar.credit_status IS not null
GROUP BY a.associate_id, al.link_id, ar.credit_status, al.site_name, al.link_code, ah.total_credit
ORDER BY al.link_id DESC;

SELECT        nvl(ya_associate.lang_id, 1) INTO iLangId
FROM             ya_shopper INNER JOIN
                          ya_associate ON ya_shopper.shopper_id = ya_associate.shopper_id
WHERE ((ya_associate.shopper_id=cShopperId) AND (rownum=1));

END sp_fe_asso_link;


PROCEDURE sp_fe_asso_linkDetail
(
	iLinkId IN INT,
	cur_out1 out cur_return
) IS
BEGIN

OPEN cur_out1 for
SELECT link_status, link_code, link_id, associate_id, site_name, link_type, link_url, link_desc, IS_english, IS_chinese,
	is_japanese, IS_korean, IS_other, hits_type, IS_music, IS_karaoke, IS_movies, IS_anime, IS_comics,
	 IS_books, IS_video_games, IS_electronics, lang_id, created_date
FROM ya_associate_link
WHERE link_id=iLinkId;

END sp_fe_asso_linkDetail;


PROCEDURE sp_fe_asso_linkPageview
(
	iLinkId IN INT,
	cur_out1 out cur_return
) IS
BEGIN

OPEN cur_out1 for
SELECT ah.hit_day, ah.hits, al.link_id, al.site_name, to_char(ah.hit_day, 'mm/dd/yy') AS hitDay
FROM (SELECT * FROM ya_associate_link WHERE link_id=iLinkId AND (link_status = 2 OR link_status = 4)) al
INNER JOIN
(SELECT * FROM ya_associate_hits_summary WHERE link_id=iLinkId AND (hit_day >= (SYSDATE)-31)) ah
 ON al.link_id = ah.link_id
 ORDER BY hit_day DESC;

END sp_fe_asso_linkPageview;


PROCEDURE sp_fe_asso_pageview
(
	cShopperId IN VARCHAR2,
	iSiteId IN INT,
	cur_out1 out cur_return
) IS
BEGIN

OPEN cur_out1 for
SELECT sum(ah.hits) AS month_hit,
	to_char(ah.hit_day, 'fmmm') || '/' || to_char(ah.hit_day, 'yyyy') AS hit_date,
	to_number(to_char(ah.hit_day, 'mm')) AS month, to_number(to_char(ah.hit_day, 'yyyy')) AS year
 FROM ya_associate_link al
	INNER JOIN ya_associate_hits_summary ah ON al.link_id = ah.link_id
WHERE al.associate_id =
	(SELECT associate_id
	FROM ya_associate
	WHERE shopper_id = cShopperId AND associate_approved = 'Y' AND site_id = ISiteId)
		AND ah.hit_day >= add_months((SYSDATE), -11)
 GROUP BY to_char(ah.hit_day, 'fmmm') || '/' || to_char(ah.hit_day, 'yyyy'), to_number(to_char(ah.hit_day, 'yyyy')), to_number(to_char(ah.hit_day, 'mm'))
ORDER BY year ASC , month ASC;

END sp_fe_asso_pageview;


PROCEDURE sp_fe_asso_password
(
	cEmail IN VARCHAR2,
	cur_out1 out cur_return
) IS
BEGIN

OPEN cur_out1 for
SELECT password, firstname, lastname, comm_lang, nvl(lang_id, 1) AS lang_id
FROM ya_shopper INNER JOIN ya_associate on ya_shopper.shopper_id = ya_associate.shopper_id
WHERE email=cEmail;

END sp_fe_asso_password;


PROCEDURE sp_fe_asso_payHistory
(
	cShopperId IN VARCHAR2,
	iSiteId IN INT,
	deciTotalCommision out float,
	cur_out1 out cur_return
) IS
BEGIN

OPEN cur_out1 for
SELECT to_char( pay_date, 'mm/dd/yy') AS payDate, amount_paid, cheque_num, pay_date
FROM ya_associate_pay_history yaph, ya_associate ya
WHERE ya.associate_approved='Y' AND ya.shopper_id=cShopperId
AND ya.site_id = ISiteId
AND ya.associate_id = yaph.associate_id ORDER BY pay_date DESC;

SELECT sum(amount_paid) INTO deciTotalCommision
FROM ya_associate_pay_history yaph, ya_associate ya
WHERE ya.associate_approved='Y' AND ya.shopper_id=cShopperId
AND ya.site_id = ISiteId
AND ya.associate_id = yaph.associate_id;

END sp_fe_asso_payHistory;


PROCEDURE sp_fe_asso_login
(
	iSiteId IN INT,
	cEmail IN VARCHAR2,
	cPassword out VARCHAR2,
	iAssociateId out INT,
	cShopperId out VARCHAR2,
	cName out VARCHAR2,
	iLangId out INT,
	iRowAffected out INT
) IS
	type typeAssoDetails IS record(c_password VARCHAR2(255), i_associate_id INT, c_shopper_id varchar2(32), c_name varchar2(255), i_lang_id int);
	ret_asso_details typeAssoDetails;
BEGIN

SELECT      ya_shopper.password, ya_associate.associate_id, ya_shopper.shopper_id, ya_associate.contact_name, nvl(ya_associate.lang_id, 1) AS lang_id INTO ret_asso_details
FROM        ya_shopper LEFT OUTER JOIN
                      ya_associate ON ya_associate.shopper_id = ya_shopper.shopper_id
WHERE LOWER(ya_shopper.email) = LOWER(cEmail) AND ya_associate.site_id=iSiteId AND ya_associate.associate_approved='Y' AND rownum=1;

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
	cur_out1 out cur_return
) IS
	type typeLegacyCreditDetails IS record(deci_tot_legacy_credit float, deci_tot_legacy_credit_paid float);
	ret_legacy_credit_details typeLegacyCreditDetails;

	deciTotLegacyCredit float;
  	deciTotLegacyCreditPaid float;
	deciTotApprovedCredit float;
	deciTotApprovedCreditNew float;
	deciTotCreditPaid float;
	cCutOffDate VARCHAR2(10);
	deciTotNormalComm float;
	deciTotOverrideComm float;
BEGIN

cCutOffDate := '07/01/2005';

SELECT sum(t1.total_credit),
         sum(t1.total_credit_paid) INTO ret_legacy_credit_details
FROM ya_associate_legacy_history t1,
         ya_associate_link t2
WHERE t1.link_id = t2.link_id
     AND t2.associate_id = iAssociateId;

deciTotLegacyCredit := ret_legacy_credit_details.deci_tot_legacy_credit;
deciTotLegacyCreditPaid := ret_legacy_credit_details.deci_tot_legacy_credit_paid;

SELECT sum(t1.credit_amount) INTO deciTotApprovedCredit
FROM ya_associate_link_orders t1
WHERE t1.credit_status = 2 /* Approved */
	AND t1.last_change_date < to_date(cCutOffDate, 'mm/dd/yyyy')
	AND t1.link_id IN (SELECT t2.link_id
			FROM ya_associate_link t2
			WHERE t2.associate_id = iAssociateId);

SELECT sum(t1.amount_paid) INTO deciTotCreditPaid
FROM ya_associate_pay_history t1
WHERE t1.associate_id = iAssociateId;

SELECT
	sum((quantity * unit_price * comm_rate)) INTO deciTotApprovedCreditNew
FROM
	ya_associate_link_orders lo, ya_associate_link l, ya_associate_commission_hist ch
WHERE
	lo.link_id = l.link_id
	AND
	ch.associate_id = l.associate_id
	AND
	ch.valid_date = to_date(to_char(lo.order_date, 'mm') || '/01/' || to_char(lo.order_date,'yyyy'), 'mm/dd/yyyy')
	AND
	(lo.last_change_date >= to_date(cCutOffDate, 'mm/dd/yyyy'))
	AND
	l.associate_id = iAssociateId
	AND
	credit_status = 2;

SELECT sum((credit_amount)) INTO deciTotOverrideComm
FROM
	ya_associate_link_orders yalo
INNER JOIN
	ya_associate_link yal
ON
	yalo.link_id = yal.link_id
INNER JOIN
	ya_associate_commission_hist yach
on
	yach.associate_id = yal.associate_id AND
	yach.valid_date = to_date(to_char(yalo.order_date, 'mm') || '/01/' || to_char(yalo.order_date,'yyyy'), 'mm/dd/yyyy')
WHERE
	(yalo.last_change_date >= to_date(cCutOffDate, 'mm/dd/yyyy')) AND
	yal.associate_id = iAssociateId AND
	credit_status = 2 AND
	credit_amount IS not null;

SELECT  sum((quantity * unit_price * comm_rate)) INTO deciTotNormalComm
FROM
	ya_associate_link_orders yalo
INNER JOIN
	ya_associate_link yal
ON
	yalo.link_id = yal.link_id
INNER JOIN
	ya_associate_commission_hist yach
on
	yach.associate_id = yal.associate_id AND
	yach.valid_date = to_date(to_char(yalo.order_date, 'mm') || '/01/' || to_char(yalo.order_date,'yyyy'), 'mm/dd/yyyy')
WHERE
	(yalo.last_change_date >= to_date(cCutOffDate, 'mm/dd/yyyy')) AND
	yal.associate_id = iAssociateId AND
	credit_status = 2 AND
	credit_amount IS null;

deciTotApprovedCreditNew := nvl(deciTotOverrideComm,0) + nvl(deciTotNormalComm,0);

OPEN cur_out1 for
SELECT nvl(deciTotLegacyCredit ,0.0) -
	nvl(deciTotLegacyCreditPaid,0.0) +
	nvl(deciTotApprovedCredit,0.0) +
	nvl(deciTotApprovedCreditNew,0.0) -
	nvl(deciTotCreditPaid,0.0) AS outstanding_credit,
	nvl(deciTotLegacyCredit ,0.0) +
	nvl(deciTotApprovedCreditNew,0.0) +
	nvl(deciTotApprovedCredit,0.0) AS total_credits
FROM ya_associate
WHERE rownum=1;

END sp_fe_asso_getCreditSummary;


PROCEDURE sp_fe_asso_createComm
(
	deci11 IN float,
	deci12 IN float,
	deci13 IN float,
	deci21 IN float,
	deci22 IN float,
	deci23 IN float,
	deci31 IN float,
	deci32 IN float,
	deci33 IN float,
	deci41 IN float,
	deci42 IN float,
	deci43 IN float,
	deci51 IN float,
	deci52 IN float,
	deci53 IN float,
	iAssocaiteId IN INT,
	iCommId out INT,
	iRowAffected out INT
) IS
	iId INT;
BEGIN

SELECT max(commission_id)+1 INTO iId FROM ya_associate_commission;

INSERT INTO ya_associate_commission (commission_id, commission_desc, created_date, updated_date,created_by, updated_by)
VALUES (iId, 'custom commission tier', (SYSDATE), (SYSDATE), 'system', 'system');

INSERT INTO ya_associate_commission_detail (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 1, 1, deci11);

INSERT INTO ya_associate_commission_detail (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 1, 2, deci12);

INSERT INTO ya_associate_commission_detail (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 1, 3, deci13);

INSERT INTO ya_associate_commission_detail (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 2, 1, deci21);

INSERT INTO ya_associate_commission_detail (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 2, 2, deci22);

INSERT INTO ya_associate_commission_detail (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 2, 3, deci23);

INSERT INTO ya_associate_commission_detail (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 3, 1, deci31);

INSERT INTO ya_associate_commission_detail (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 3, 2, deci32);

INSERT INTO ya_associate_commission_detail (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 3, 3, deci33);

INSERT INTO ya_associate_commission_detail (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 4, 1, deci41);

INSERT INTO ya_associate_commission_detail (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 4, 2, deci42);

INSERT INTO ya_associate_commission_detail (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 4, 3, deci43);

INSERT INTO ya_associate_commission_detail (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 5, 1, deci51);

INSERT INTO ya_associate_commission_detail (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 5, 2, deci52);

INSERT INTO ya_associate_commission_detail (commission_id, comm_type_id, payment_option, percentage)
VALUES (iId, 5, 3, deci53);

UPDATE ya_associate SET commission_id=iId WHERE associate_id = iAssocaiteId;

IF (SQLCODE!=0) THEN
	iRowAffected := 0;
	rollback;
ELSE
	iRowAffected := SQL%ROWCOUNT;
	iCommId := iId;
	commit;
END IF;

END sp_fe_asso_createComm;


PROCEDURE sp_fe_asso_selImgLotLang
(
	iLotId IN INT,
	iLangId IN INT,
	cur_out1 out cur_return
) IS
	iTemp INT;
BEGIN

SELECT count(*) INTO iTemp FROM ya_img_lot_lang WHERE image_lot_id=iLotId AND lang_id=iLangId AND not image_loc='';
IF (iTemp>0) THEN
	OPEN cur_out1 for
	SELECT * FROM ya_img_lot_lang WHERE image_lot_id=iLotId AND lang_id=iLangId AND not image_loc='';
ELSE
	OPEN cur_out1 for
	SELECT * FROM ya_img_lot_lang WHERE image_lot_id=iLotId AND preferred_flag='Y';
END IF;

END sp_fe_asso_selImgLotLang;


PROCEDURE sp_fe_asso_exportSales
(
	cMonth VARCHAR2,
	cYear VARCHAR2,
	iAssociateId INT,
	iLangId INT,
	iCreditStatus INT,
	cur_out1 out cur_return,
	cur_out2 out cur_return
) IS
	dtStartDate date;
	dtEndDate date;
BEGIN

dtStartDate := to_date(cMonth || '/01/' || cYear, 'mm/dd/yyyy');
dtEndDate := add_months(dtStartDate, 1);

IF (iCreditStatus<>1) THEN
	OPEN cur_out1 for
	SELECT  to_char(order_date, 'mm/dd/yyyy') AS order_date, to_char(last_change_date, 'mm/dd/yyyy') AS posting_date, ya_prod_lang.prod_name_u AS prod_name, yalo.sku, sum(yalo.quantity) AS items,
		sum(yalo.unit_price * yalo.quantity) AS price, link_id,
	                      nvl(yg.group_id, 18) AS group_id
	FROM       (SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, yal.link_id, credit_amount
		 FROM ya_associate_link_orders
		    INNER JOIN
		      (SELECT * FROM ya_associate_link WHERE associate_id=iAssociateId) yal
		    ON ya_associate_link_orders.link_id = yal.link_id
		WHERE (ya_associate_link_orders.last_change_date >= dtStartDate) AND
	                                  (ya_associate_link_orders.last_change_date <  dtEndDate) AND
	                 	               (credit_status = 2) AND (unit_price > 0)) yalo
		LEFT OUTER  JOIN
	                      ya_product ON yalo.sku = ya_product.sku LEFT OUTER  JOIN
	                      ya_prod_lang ON yalo.sku = ya_prod_lang.sku  LEFT OUTER  JOIN
		   (SELECT * FROM ya_group WHERE division_id=1) yg
	                       ON yg.account_id = ya_product.account_id
	WHERE      (ya_prod_lang.lang_id = iLangId)
	GROUP BY ya_prod_lang.prod_name_u,  yalo.sku, yg.group_id, link_id,
	to_char(order_date, 'mm/dd/yyyy'), to_char(last_change_date, 'mm/dd/yyyy')
	ORDER BY group_id, posting_date, prod_name;
END IF;

IF (iCreditStatus<>2) THEN
	IF (cur_out1 IS not null) THEN
		OPEN cur_out2 for
		SELECT  to_char(order_date, 'mm/dd/yyyy') AS order_date,
			to_char(last_change_date, 'mm/dd/yyyy') AS posting_date,
			ya_prod_lang.prod_name_u AS prod_name,
			yalo.sku,
			sum(yalo.quantity) AS items,
			sum(yalo.unit_price * yalo.quantity) AS price,
			link_id,
			nvl(yg.group_id, 18) AS group_id
		FROM
			(
			SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, yal.link_id
			FROM ya_associate_link_orders
			INNER JOIN
				(
				SELECT * FROM ya_associate_link WHERE associate_id=iAssociateId
				) yal
			ON ya_associate_link_orders.link_id = yal.link_id
			WHERE (ya_associate_link_orders.last_change_date >= dtStartDate) AND
				(ya_associate_link_orders.last_change_date <  dtEndDate) AND
				(credit_status = 1) AND (unit_price > 0)
			) yalo
		LEFT OUTER  JOIN
			ya_product
			ON yalo.sku = ya_product.sku
		LEFT OUTER  JOIN
			ya_prod_lang
			ON yalo.sku = ya_prod_lang.sku
		LEFT OUTER  JOIN
			(
			SELECT * FROM ya_group WHERE division_id=1
			) yg
			ON yg.account_id = ya_product.account_id
		WHERE      (ya_prod_lang.lang_id = iLangId)
		GROUP BY ya_prod_lang.prod_name_u,  yalo.sku, yg.group_id, link_id,
		to_char(order_date, 'mm/dd/yyyy'), to_char(last_change_date, 'mm/dd/yyyy')
		ORDER BY group_id, posting_date, prod_name;
	ELSE
		OPEN cur_out1 for
		SELECT  to_char(order_date, 'mm/dd/yyyy') AS order_date, to_char(last_change_date, 'mm/dd/yyyy') AS posting_date, ya_prod_lang.prod_name_u AS prod_name, yalo.sku, sum(yalo.quantity) AS items,
			sum(yalo.unit_price * yalo.quantity) AS price, link_id,
		                      nvl(yg.group_id, 18) AS group_id
		FROM       (SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, yal.link_id
			 FROM ya_associate_link_orders
			    INNER JOIN
			      (SELECT * FROM ya_associate_link WHERE associate_id=iAssociateId) yal
			    ON ya_associate_link_orders.link_id = yal.link_id
			WHERE (ya_associate_link_orders.last_change_date >= dtStartDate) AND
		                                  (ya_associate_link_orders.last_change_date <  dtEndDate) AND
		                 	               (credit_status = 1) AND (unit_price > 0)) yalo
			LEFT OUTER  JOIN
		                      ya_product ON yalo.sku = ya_product.sku LEFT OUTER  JOIN
		                      ya_prod_lang ON yalo.sku = ya_prod_lang.sku  LEFT OUTER  JOIN
			   (SELECT * FROM ya_group WHERE division_id=1) yg
		                       ON yg.account_id = ya_product.account_id
		WHERE      (ya_prod_lang.lang_id = iLangId)
		GROUP BY ya_prod_lang.prod_name_u,  yalo.sku, yg.group_id, link_id,
		to_char(order_date, 'mm/dd/yyyy'), to_char(last_change_date, 'mm/dd/yyyy')
		ORDER BY group_id, posting_date, prod_name;
	END IF;
END IF;
END sp_fe_asso_exportSales;


PROCEDURE sp_fe_asso_monthlyCredit
(
	iAssociateId IN INT,
	deciPercentage out float,
	deciOldPercentage out float,
	deciLastApproved out float,
	cur_out1 out cur_return,
	cur_out2 out cur_return
) IS
	iCustomer INT;
	cStartDate VARCHAR2(10);
	cEndDate VARCHAR2(10);
	dtDate date;
   iCount INT;
BEGIN

OPEN cur_out1 for
SELECT
	associate_id,
	sum(commission) AS credit_amount,
	order_month AS month,
	order_year AS year,
	to_char(order_month) || '/' || to_char(order_year) AS order_date, credit_status
FROM
	(SELECT
		yalo.associate_id, credit_status,
		to_number(to_char(last_change_date,'fmmm')) AS order_month,
		to_number(to_char(last_change_date, 'yyyy')) AS order_year,
		sum(nvl(yalo.unit_price, 0) * nvl(yalo.quantity, 0)) * nvl(comm_rate, (SELECT link_percentage  FROM ya_associate_link WHERE (associate_id=iAssociateId) AND (rownum=1)))  AS commission
	FROM
		(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, associate_id
		 FROM ya_associate_link_orders INNER JOIN
			(SELECT * FROM ya_associate_link WHERE associate_id=iAssociateId) yal
			ON ya_associate_link_orders.link_id = yal.link_id
		WHERE (ya_associate_link_orders.last_change_date >= add_months(SYSDATE, -11) AND ya_associate_link_orders.Credit_status = 2)) yalo
			LEFT OUTER JOIN ya_associate_commission_hist yach on yach.associate_id=iAssociateId
			AND yach.valid_date = to_date(to_char(order_date, 'mm') || '/01/' || to_char(order_date, 'yyyy'), 'mm/dd/yyyy')
	GROUP BY yalo.associate_id, last_change_date, comm_rate, credit_status
	) yar
GROUP BY yar.credit_status,
	to_char(order_month) || '/' || to_char(order_year),
	order_month,
	order_year,
	yar.associate_id
ORDER BY order_year, order_month;

OPEN cur_out2 for
SELECT
	associate_id,
	sum(nvl(commission, 0)) AS credit_amount,
	order_month AS month,
	order_year AS year,
	to_char(order_month) || '/' || to_char(order_year) AS order_date, credit_status
FROM
	(SELECT
		yalo.associate_id, credit_status,
		to_number(to_char(order_date, 'fmmm')) AS order_month,
		to_number(to_char(order_date, 'yyyy')) AS order_year,
		sum(nvl(yalo.unit_price, 0) * nvl(yalo.quantity, 0)) * nvl(comm_rate, (SELECT link_percentage  FROM ya_associate_link WHERE (associate_id=iAssociateId) AND (rownum=1)))  AS commission
	FROM
		(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, associate_id
		 FROM ya_associate_link_orders INNER JOIN
			      (SELECT * FROM ya_associate_link WHERE associate_id=iAssociateId) yal
			    ON ya_associate_link_orders.link_id = yal.link_id
		WHERE (ya_associate_link_orders.order_date >= add_months(SYSDATE, -11) AND ya_associate_link_orders.Credit_status <>2)) yalo
		LEFT OUTER JOIN ya_associate_commission_hist yach on yach.associate_id =iAssociateId
                  AND yach.valid_date = to_date(to_char(order_date, 'mm') || '/01/' || to_char(order_date, 'yyyy'), 'mm/dd/yyyy')
	GROUP BY yalo.associate_id,order_date, comm_rate, credit_status
	) yar
GROUP BY yar.credit_status,
	to_char(order_month) || '/' || to_char(order_year),
	order_month,
	order_year,
	yar.associate_id
ORDER BY order_year, order_month;

dtDate := (SYSDATE);

cStartDate := to_char(dtDate, 'mm') || '/01/' || to_char(dtDate, 'yyyy');
dtDate := add_months(dtDate, 1);
cEndDate := to_char(dtDate, 'mm') || '/01/' || to_char(dtDate, 'yyyy');

SELECT count(customerId) INTO iCustomer
FROM dm_new_shopper
WHERE dm_new_shopper.validorder='Y'
AND dm_new_shopper.feorderid IN
	(SELECT distinct to_char(order_num) AS orderId
	FROM ya_associate_link_orders INNER JOIN
		(SELECT link_id FROM ya_associate_link WHERE associate_id=iAssociateId) yal
		ON ya_associate_link_orders.link_id = yal.link_id
	WHERE order_date >= to_date(cStartDate, 'mm/dd/yyyy') AND order_date < to_date(cEndDate, 'mm/dd/yyyy') AND credit_status <> 4);

dbms_output.put_line(iCustomer);

SELECT count(1) INTO iCount
FROM ya_associate_commission_detail cd INNER JOIN
	(SELECT comm_type_id, nc_max FROM ya_associate_commission_type ct WHERE ((nc_min <= iCustomer AND nc_max >= iCustomer) OR nc_max < iCustomer)) ct
	ON ct.comm_type_id =cd.comm_type_id
	 INNER JOIN (SELECT commission_id, payment_option FROM ya_associate WHERE associate_id=iAssociateId) ya
	ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option;
IF (iCount>0) THEN
   SELECT percentage INTO deciPercentage
   FROM ya_associate_commission_detail cd INNER JOIN
      (SELECT comm_type_id, nc_max FROM ya_associate_commission_type ct WHERE ((nc_min <= iCustomer AND nc_max >= iCustomer) OR nc_max < iCustomer)) ct
      ON ct.comm_type_id =cd.comm_type_id
       INNER JOIN (SELECT commission_id, payment_option FROM ya_associate WHERE associate_id=iAssociateId) ya
      ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
   WHERE rownum=1;
   dbms_output.put_line(deciPercentage);
   dbms_output.put_line(to_char(deciPercentage));
   dbms_output.put_line(SYSDATE);
ELSE
	SELECT percentage INTO deciPercentage
	FROM ya_associate_commission_detail cd INNER JOIN
		(SELECT comm_type_id, nc_max FROM ya_associate_commission_type ct WHERE nc_min <= iCustomer) ct
		ON ct.comm_type_id =cd.comm_type_id
		 INNER JOIN (SELECT commission_id, payment_option FROM ya_associate WHERE associate_id=iAssociateId) ya
		ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
   WHERE rownum=1;
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
SELECT link_percentage INTO deciOldPercentage FROM ya_associate_link WHERE (associate_id=iAssociateId) AND (rownum=1);


SELECT sum(commission) INTO deciLastApproved
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
      sum(nvl(credit_amount, yalo.unit_price*yalo.quantity*nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = iAssociateId AND rownum=1)))))
   )
		  AS commission
	FROM (
		SELECT order_date, last_change_date, sku, nvl(quantity, 0) AS quantity, nvl(unit_price, 0) AS unit_price, credit_status, credit_amount
		FROM ya_associate_link_orders
			INNER JOIN
			(
			SELECT * FROM ya_associate_link WHERE associate_id=iAssociateId
			) yal
			  ON ya_associate_link_orders.link_id = yal.link_id
		WHERE (ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
	                                  (ya_associate_link_orders.last_change_date < to_date(cEndDate, 'mm/dd/yyyy')) AND
	                 	               (credit_status = 2)
	            ) yalo
		LEFT OUTER JOIN ya_associate_commission_hist yach on yach.associate_id = iAssociateId
		AND yach.valid_date = to_date(to_char(order_date, 'mm') || '/01/' ||to_char(order_date, 'yyyy'),'mm/dd/yyyy'),
		(SELECT percentage  FROM ya_associate_commission_detail cd INNER JOIN
		(SELECT comm_type_id, nc_max FROM ya_associate_commission_type ct WHERE ((nc_min <= iCustomer AND nc_max >= iCustomer) OR nc_max < iCustomer) ORDER BY nc_min DESC) ct
	ON ct.comm_type_id =cd.comm_type_id
	 INNER JOIN (SELECT commission_id, payment_option FROM ya_associate WHERE associate_id=iAssociateId) ya
	ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option WHERE rownum=1)t
GROUP BY to_number(to_char(order_date, 'mm')), to_number(to_char(order_date, 'yyyy')) , comm_rate, t.percentage) a;


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
	iCustomer out INT,
	deciPercentage out float,
	iNextLevel out INT,
	iLangId out INT,
	deciThisPeriodComm out float,
	deciTotalComm out float,
	cur_out01 out cur_return,
	cur_out02 out cur_return,
	cur_out03 out cur_return,
	cur_out04 out cur_return,
	cur_out05 out cur_return,
	cur_out06 out cur_return,
	cur_out07 out cur_return,
	cur_out08 out cur_return,
	cur_out09 out cur_return,
	cur_out10 out cur_return,
	cur_out11 out cur_return,
	cur_out12 out cur_return,
	cur_out13 out cur_return,
	cur_out14 out cur_return
) IS

	cStartDate varchar(10);
	cEndDate varchar(10);
	cCutOffDate varchar(10);

	type typePercentageNextLevel IS record(percentage float, next_level INT);
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
cEndDate := to_char(add_months(to_date(cStartDate, 'mm/dd/yyyy'), 1), 'mm/dd/yyyy');
cCutOffDate := '07/01/2005';


SELECT count(customerId) INTO iCustomer
FROM dm_new_shopper
WHERE dm_new_shopper.validOrder = 'Y'
	AND dm_new_shopper.feOrderId IN
	(SELECT  distinct to_char(order_num) AS orderId
	FROM
		(SELECT *
		FROM ya_associate_link_orders
		WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)) ya_associate_link_orders
	INNER JOIN
		(SELECT link_id
		FROM ya_associate_link
		WHERE associate_id=iAssociateId) yal
	ON ya_associate_link_orders.link_id = yal.link_id
	WHERE order_date >= to_date(cStartDate, 'mm/dd/yyyy') AND order_date < to_date(cEndDate, 'mm/dd/yyyy') AND credit_status <> 4);


IF (to_date(cStartDate, 'mm/dd/yyyy') < to_date(cCutOffDate, 'mm/dd/yyyy')) THEN
	SELECT link_percentage INTO deciPercentage FROM ya_associate_link WHERE associate_id=iAssociateId AND rownum=1 ORDER BY link_id ASC;
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
*/
   SELECT comm_rate, 0 INTO ret_percentage_next_level FROM ya_associate_commission_hist ach WHERE valid_date = to_date(cStartDate, 'mm/dd/yyyy') AND associate_id = iAssociateId AND rownum = 1;
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
		ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option AND rownum = 1;

   ELSE
		SELECT deciPercentage, nc_max + 1 - iCustomer INTO ret_percentage_next_level
		FROM ya_associate_commission_detail cd INNER JOIN
				(SELECT comm_type_id, nc_max
				FROM ya_associate_commission_type ct
				WHERE nc_min <= iCustomer ) ct
			ON ct.comm_type_id =cd.comm_type_id
			 INNER JOIN (SELECT commission_id, payment_option
				FROM ya_associate
				WHERE associate_id=iAssociateId) ya
		ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option AND rownum = 1;
	END IF;
	deciPercentage := ret_percentage_next_level.percentage;
	iNextLevel := ret_percentage_next_level.next_level;
END IF;

/*use new comm %*/
SELECT sum(nvl(credit_amount,unit_price * quantity * deciPercentage)) INTO deciTotalComm
FROM ya_associate_link_orders
WHERE
	(last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
	(last_change_date < to_date(cEndDate, 'mm/dd/yyyy')) AND
	link_id IN (SELECT link_id FROM ya_associate_link WHERE associate_id=iAssociateId) AND
	credit_status = 2;

SELECT sum(nvl(credit_amount,unit_price * quantity * nvl(deciPercentage,0))) INTO deciThisPeriodComm
FROM ya_associate_link_orders
WHERE
	(last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
	(last_change_date < to_date(cEndDate, 'mm/dd/yyyy')) AND
	order_date >= to_date(cStartDate, 'mm/dd/yyyy') AND order_date < to_date(cEndDate, 'mm/dd/yyyy') AND
	link_id IN (SELECT link_id FROM ya_associate_link WHERE associate_id=iAssociateId) AND
	credit_status = 2;


IF (iNeedGroup = 1) THEN
	IF (iCreditStatus <> 1) THEN

		OPEN cur_out01 for
		SELECT  to_char(order_date, 'mm/dd/yyyy') AS order_date, to_char(last_change_date, 'mm/dd/yyyy') AS posting_date,
			CASE
				WHEN (ya_prod_lang.prod_name_u IS null OR ya_prod_lang.prod_name_u = '')
				THEN (SELECT prod_name_u FROM ya_prod_lang WHERE sku=yalo.sku AND lang_id = 1)
				ELSE ya_prod_lang.prod_name_u
				END
			AS prod_name,
			yalo.sku, sum(yalo.quantity) AS items,
			sum(yalo.unit_price * yalo.quantity) AS price, yalo.link_id,
			yg.group_id
		FROM
			(SELECT order_date, last_change_date, sku, nvl(quantity, 0) AS quantity, nvl(unit_price, 0) AS unit_price, credit_status, yal.link_id
			FROM
				(SELECT *
				FROM ya_associate_link_orders
				WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) ya_associate_link_orders
			INNER JOIN
				(SELECT *
				FROM ya_associate_link
				WHERE associate_id=iAssociateId
				) yal
			ON ya_associate_link_orders.link_id = yal.link_id
			WHERE (ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
				(ya_associate_link_orders.last_change_date <  to_date(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (unit_price > 0)) yalo
		LEFT OUTER  JOIN
			ya_product ON yalo.sku = ya_product.sku
		LEFT OUTER  JOIN
			ya_prod_lang ON yalo.sku = ya_prod_lang.sku
		LEFT OUTER  JOIN
			(SELECT * FROM ya_group WHERE division_id=1) yg
			ON yg.account_id = ya_product.account_id
		WHERE      (ya_prod_lang.lang_id = tiLangId)
		GROUP BY ya_prod_lang.prod_name_u,  yalo.sku, yg.group_id, link_id,
			to_char(order_date, 'mm/dd/yyyy'), to_char(last_change_date, 'mm/dd/yyyy')
		ORDER BY group_id, posting_date, prod_name;

		OPEN cur_out02 for
		SELECT distinct yg.group_id
		FROM
			(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status
			FROM
				(SELECT *
				FROM ya_associate_link_orders
				WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) ya_associate_link_orders
			INNER JOIN
				(SELECT *
				FROM ya_associate_link
				WHERE associate_id=iAssociateId
				) yal
			ON ya_associate_link_orders.link_id = yal.link_id
			WHERE (ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
				(ya_associate_link_orders.last_change_date <  to_date(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (unit_price > 0)) yalo
		LEFT OUTER  JOIN
			ya_product ON yalo.sku = ya_product.sku
		LEFT OUTER  JOIN
			(SELECT * FROM ya_group WHERE division_id=1) yg
			ON yg.account_id = ya_product.account_id;
	END IF;

	IF (iCreditStatus <>2) THEN
		OPEN cur_temp03 for
		SELECT   to_char(yalo.order_date, 'mm/dd/yyyy') AS order_date,
			CASE
				WHEN (ya_prod_lang.prod_name_u IS null OR ya_prod_lang.prod_name_u = '')
				THEN (SELECT prod_name_u FROM ya_prod_lang WHERE sku=yalo.sku AND lang_id = 1)
				ELSE ya_prod_lang.prod_name_u
				END
			AS prod_name, yalo.sku,
			sum(yalo.quantity) AS items,
			sum(yalo.unit_price * yalo.quantity) AS price, link_id,
			yg.group_id
		FROM
			(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, ya_associate_link_orders.link_id
			FROM
				(SELECT *
				FROM ya_associate_link_orders
				WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) ya_associate_link_orders
			INNER JOIN
				(SELECT *
				FROM ya_associate_link
				WHERE associate_id=iAssociateId
				) yal
			ON ya_associate_link_orders.link_id = yal.link_id
			WHERE (ya_associate_link_orders.order_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
				(ya_associate_link_orders.order_date < to_date(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 1) AND (unit_price > 0)
			) yalo
		LEFT OUTER  JOIN
			ya_product ON yalo.sku = ya_product.sku
		LEFT OUTER  JOIN
			ya_prod_lang ON yalo.sku = ya_prod_lang.sku
		LEFT OUTER  JOIN
			(SELECT * FROM ya_group WHERE division_id=1) yg
		ON yg.account_id = ya_product.account_id
		WHERE      (ya_prod_lang.lang_id = tiLangId OR ya_prod_lang.lang_id = 1)
		GROUP BY ya_prod_lang.prod_name_u,  yalo.sku, yg.group_id, order_date, link_id
		ORDER BY group_id, order_date, prod_name;

		IF (cur_out01 IS null) THEN
			cur_out01 := cur_temp03;
		elsif (cur_out02 IS null) THEN
			cur_out02 := cur_temp03;
		elsif (cur_out03 IS null) THEN
			cur_out03 := cur_temp03;
		elsif (cur_out04 IS null) THEN
			cur_out04 := cur_temp03;
		elsif (cur_out05 IS null) THEN
			cur_out05 := cur_temp03;
		elsif (cur_out06 IS null) THEN
			cur_out06 := cur_temp03;
		elsif (cur_out07 IS null) THEN
			cur_out07 := cur_temp03;
		elsif (cur_out08 IS null) THEN
			cur_out08 := cur_temp03;
		elsif (cur_out09 IS null) THEN
			cur_out09 := cur_temp03;
		elsif (cur_out10 IS null) THEN
			cur_out10 := cur_temp03;
		ELSE
			cur_out11 := cur_temp03;
		END IF;

		OPEN cur_temp04 for
		SELECT    DISTINCT  yg.group_id
		FROM
			(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status
			FROM
				(SELECT *
				FROM ya_associate_link_orders
				WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) ya_associate_link_orders
			INNER JOIN
				(SELECT *
				FROM ya_associate_link
				WHERE associate_id=iAssociateId
				) yal
			ON ya_associate_link_orders.link_id = yal.link_id
			WHERE (ya_associate_link_orders.order_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
				(ya_associate_link_orders.order_date <  to_date(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 1) AND (unit_price > 0)
			) yalo
		LEFT OUTER  JOIN
			ya_product ON yalo.sku = ya_product.sku
		LEFT OUTER  JOIN
			(SELECT * FROM ya_group WHERE division_id=1) yg
		ON yg.account_id = ya_product.account_id;

		IF (cur_out01 IS null) THEN
			cur_out01 := cur_temp04;
		elsif (cur_out02 IS null) THEN
			cur_out02 := cur_temp04;
		elsif (cur_out03 IS null) THEN
			cur_out03 := cur_temp04;
		elsif (cur_out04 IS null) THEN
			cur_out04 := cur_temp04;
		elsif (cur_out05 IS null) THEN
			cur_out05 := cur_temp04;
		elsif (cur_out06 IS null) THEN
			cur_out06 := cur_temp04;
		elsif (cur_out07 IS null) THEN
			cur_out07 := cur_temp04;
		elsif (cur_out08 IS null) THEN
			cur_out08 := cur_temp04;
		elsif (cur_out09 IS null) THEN
			cur_out09 := cur_temp04;
		elsif (cur_out10 IS null) THEN
			cur_out10 := cur_temp04;
		elsif (cur_out11 IS null) THEN
			cur_out11 := cur_temp04;
		elsif (cur_out12 IS null) THEN
			cur_out12 := cur_temp04;
		elsif (cur_out13 IS null) THEN
			cur_out13 := cur_temp04;
		elsif (cur_out14 IS null) THEN
			cur_out14 := cur_temp04;
		ELSE
			cur_out14 := cur_temp04;
		END IF;

		OPEN cur_temp05 for
		SELECT    sum(yalo.quantity) AS items,
			sum(yalo.unit_price * yalo.quantity) AS price
		FROM
			(SELECT order_date, last_change_date, sku, nvl(quantity, 0) AS quantity, nvl(unit_price, 0) AS unit_price, credit_status
			FROM
				(SELECT *
				FROM ya_associate_link_orders
				WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) ya_associate_link_orders
			INNER JOIN
				(SELECT *
				FROM ya_associate_link
				WHERE associate_id=iAssociateId
				) yal
			ON ya_associate_link_orders.link_id = yal.link_id
			WHERE (ya_associate_link_orders.order_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
		                                  (ya_associate_link_orders.order_date <  to_date(cEndDate, 'mm/dd/yyyy')) AND
		                 	               (credit_status =1) AND (unit_price > 0)
			) yalo
		GROUP BY to_number(to_char(order_date, 'fmmm'));

		IF (cur_out01 IS null) THEN
			cur_out01 := cur_temp05;
		elsif (cur_out02 IS null) THEN
			cur_out02 := cur_temp05;
		elsif (cur_out03 IS null) THEN
			cur_out03 := cur_temp05;
		elsif (cur_out04 IS null) THEN
			cur_out04 := cur_temp05;
		elsif (cur_out05 IS null) THEN
			cur_out05 := cur_temp05;
		elsif (cur_out06 IS null) THEN
			cur_out06 := cur_temp05;
		elsif (cur_out07 IS null) THEN
			cur_out07 := cur_temp05;
		elsif (cur_out08 IS null) THEN
			cur_out08 := cur_temp05;
		elsif (cur_out09 IS null) THEN
			cur_out09 := cur_temp05;
		elsif (cur_out10 IS null) THEN
			cur_out10 := cur_temp05;
		elsif (cur_out11 IS null) THEN
			cur_out11 := cur_temp05;
		elsif (cur_out12 IS null) THEN
			cur_out12 := cur_temp05;
		elsif (cur_out13 IS null) THEN
			cur_out13 := cur_temp05;
		elsif (cur_out14 IS null) THEN
			cur_out14 := cur_temp05;
		ELSE
			cur_out14 := cur_temp05;
		END IF;

	END IF;

	IF (to_date(cStartDate, 'mm/dd/yyyy') < to_date(cCutOffDate, 'mm/dd/yyyy')) THEN
		OPEN cur_temp06 for
		SELECT    sum(yalo.quantity) AS items,
			sum(yalo.unit_price * yalo.quantity) AS price,
			to_number(to_char(order_date,'fmmm')) AS posting_month,
			to_number(to_char(order_date,'yyyy')) AS posting_year,
			(SELECT link_percentage FROM ya_associate_link WHERE associate_id=iAssociateId AND rownum=1) AS percentage,
			--sum(yalo.unit_price * yalo.quantity) * (SELECT link_percentage FROM ya_associate_link WHERE associate_id=iAssociateId AND rownum = 1)  AS commission
			sum(nvl(yalo.credit_amount, yalo.unit_price * yalo.quantity* nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = 8050 AND rownum=1))))) AS commission
		FROM
			(SELECT order_date, last_change_date, sku,nvl(quantity, 0) AS quantity, nvl(unit_price, 0) AS unit_price, credit_status, credit_amount
			FROM
				(SELECT *
				FROM ya_associate_link_orders
				WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) ya_associate_link_orders
			INNER JOIN
				(SELECT *
				FROM ya_associate_link
				WHERE associate_id=iAssociateId
				) yal
			ON ya_associate_link_orders.link_id = yal.link_id
			WHERE (ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
				(ya_associate_link_orders.last_change_date < to_date(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (unit_price > 0)
			) yalo
			LEFT OUTER JOIN ya_associate_commission_hist yach on yach.associate_id = iAssociateId
				AND yach.valid_date = to_date(to_char(order_date, 'mm') || '/01/' || to_char(order_date, 'yyyy'), 'mm/dd/yyyy'),
				(SELECT percentage
				FROM ya_associate_commission_detail cd
				INNER JOIN
					(SELECT comm_type_id, nc_max
					FROM ya_associate_commission_type ct
               WHERE ((nc_min <=iCustomer AND nc_max >=iCustomer) OR (nc_max < iCustomer))
               ORDER BY nc_min DESC
					) ct
				ON ct.comm_type_id =cd.comm_type_id
				INNER JOIN
					(SELECT commission_id, payment_option
					FROM ya_associate
					WHERE associate_id=iAssociateId
					) ya
				ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
            WHERE rownum=1
				)t
		GROUP BY to_number(to_char(order_date,'fmmm')), to_number(to_char(order_date, 'yyyy')) , comm_rate, t.percentage;

		IF (cur_out01 IS null) THEN
			cur_out01 := cur_temp06;
		elsif (cur_out02 IS null) THEN
			cur_out02 := cur_temp06;
		elsif (cur_out03 IS null) THEN
			cur_out03 := cur_temp06;
		elsif (cur_out04 IS null) THEN
			cur_out04 := cur_temp06;
		elsif (cur_out05 IS null) THEN
			cur_out05 := cur_temp06;
		elsif (cur_out06 IS null) THEN
			cur_out06 := cur_temp06;
		elsif (cur_out07 IS null) THEN
			cur_out07 := cur_temp06;
		elsif (cur_out08 IS null) THEN
			cur_out08 := cur_temp06;
		elsif (cur_out09 IS null) THEN
			cur_out09 := cur_temp06;
		elsif (cur_out10 IS null) THEN
			cur_out10 := cur_temp06;
		elsif (cur_out11 IS null) THEN
			cur_out11 := cur_temp06;
		elsif (cur_out12 IS null) THEN
			cur_out12 := cur_temp06;
		elsif (cur_out13 IS null) THEN
			cur_out13 := cur_temp06;
		elsif (cur_out14 IS null) THEN
			cur_out14 := cur_temp06;
		ELSE
			cur_out14 := cur_temp06;
		END IF;
	ELSE
		OPEN cur_temp07 for
		SELECT    sum(yalo.quantity) AS items,
			sum(yalo.unit_price * yalo.quantity) AS price,
			to_number(to_char(order_date, 'fmmm')) AS posting_month,
			to_number(to_char(order_date, 'yyyy')) AS posting_year,
			nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = iAssociateId AND rownum=1))) AS percentage,
			--sum(yalo.unit_price * yalo.quantity) * nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = iAssociateId AND rownum=1)))  AS commission
			sum(nvl(yalo.credit_amount, yalo.unit_price * yalo.quantity* nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = 8050 AND rownum=1))))) AS commission
		FROM
			(SELECT order_date, last_change_date, sku, nvl(quantity, 0) AS quantity, nvl(unit_price, 0) AS unit_price, credit_status, credit_amount
			FROM
				(SELECT *
				FROM ya_associate_link_orders
				WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) ya_associate_link_orders
			INNER JOIN
				(SELECT *
				FROM ya_associate_link
				WHERE associate_id=iAssociateId
				) yal
			ON ya_associate_link_orders.link_id = yal.link_id
			WHERE
				(ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
				(ya_associate_link_orders.last_change_date < to_date(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (unit_price > 0)
			) yalo
		LEFT OUTER JOIN ya_associate_commission_hist yach on yach.associate_id = iAssociateId
			AND yach.valid_date = to_date(to_char(order_date, 'mm') || '/01/' || to_char(order_date, 'yyyy'), 'mm/dd/yyyy'),
			(SELECT percentage
			FROM ya_associate_commission_detail cd
			INNER JOIN
				(SELECT comm_type_id, 	nc_max
				FROM ya_associate_commission_type ct
				WHERE ((nc_min <=iCustomer AND nc_max >=iCustomer) OR (nc_max < iCustomer))
            ORDER BY nc_min DESC
				) ct
			ON ct.comm_type_id =cd.comm_type_id
			INNER JOIN
				(SELECT commission_id, payment_option
				FROM ya_associate
				WHERE associate_id=iAssociateId
				) ya
			ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
         WHERE rownum=1
			)t
		GROUP BY to_number(to_char(order_date,'fmmm')), to_number(to_char(order_date, 'yyyy')) , comm_rate, t.percentage;

		IF (cur_out01 IS null) THEN
			cur_out01 := cur_temp07;
		elsif (cur_out02 IS null) THEN
			cur_out02 := cur_temp07;
		elsif (cur_out03 IS null) THEN
			cur_out03 := cur_temp07;
		elsif (cur_out04 IS null) THEN
			cur_out04 := cur_temp07;
		elsif (cur_out05 IS null) THEN
			cur_out05 := cur_temp07;
		elsif (cur_out06 IS null) THEN
			cur_out06 := cur_temp07;
		elsif (cur_out07 IS null) THEN
			cur_out07 := cur_temp07;
		elsif (cur_out08 IS null) THEN
			cur_out08 := cur_temp07;
		elsif (cur_out09 IS null) THEN
			cur_out09 := cur_temp07;
		elsif (cur_out10 IS null) THEN
			cur_out10 := cur_temp07;
		elsif (cur_out11 IS null) THEN
			cur_out11 := cur_temp07;
		elsif (cur_out12 IS null) THEN
			cur_out12 := cur_temp07;
		elsif (cur_out13 IS null) THEN
			cur_out13 := cur_temp07;
		elsif (cur_out14 IS null) THEN
			cur_out14 := cur_temp07;
		ELSE
			cur_out14 := cur_temp07;
		END IF;
	END IF;

END IF;

IF (iNeedGroup = 0) THEN

	IF (iBestSeller = 1) THEN
		OPEN cur_temp08 for
      SELECT * FROM (
         SELECT
            CASE
               WHEN (ya_prod_lang.prod_name_u IS null OR ya_prod_lang.prod_name_u = '')
               THEN (SELECT prod_name_u FROM ya_prod_lang WHERE sku=yalo.sku AND lang_id = 1)
               ELSE
               ya_prod_lang.prod_name_u
               END
            AS prod_name,
            yalo.sku,
            sum(yalo.quantity) AS items, link_id,
            sum(yalo.unit_price * yalo.quantity) AS price
         FROM
            (SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, ya_associate_link_orders.link_id
            FROM
               (SELECT *
               FROM ya_associate_link_orders
               WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
               ) ya_associate_link_orders
            INNER JOIN
               (SELECT *
               FROM ya_associate_link
               WHERE associate_id=iAssociateId
               ) yal
            ON ya_associate_link_orders.link_id = yal.link_id
            WHERE (ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
               (ya_associate_link_orders.last_change_date <  to_date(cEndDate, 'mm/dd/yyyy')) AND
               (credit_status = 2 OR credit_status = 1) AND (unit_price > 0)
            ) yalo
            LEFT OUTER  JOIN ya_product ON yalo.sku = ya_product.sku
            LEFT OUTER  JOIN ya_prod_lang ON yalo.sku = ya_prod_lang.sku
         WHERE      (ya_prod_lang.lang_id = tiLangId)
         GROUP BY ya_prod_lang.prod_name_u,  yalo.sku, link_id
         ORDER BY items DESC)
      WHERE (rownum<=20);

		IF (cur_out01 IS null) THEN
			cur_out01 := cur_temp08;
		elsif (cur_out02 IS null) THEN
			cur_out02 := cur_temp08;
		elsif (cur_out03 IS null) THEN
			cur_out03 := cur_temp08;
		elsif (cur_out04 IS null) THEN
			cur_out04 := cur_temp08;
		elsif (cur_out05 IS null) THEN
			cur_out05 := cur_temp08;
		elsif (cur_out06 IS null) THEN
			cur_out06 := cur_temp08;
		elsif (cur_out07 IS null) THEN
			cur_out07 := cur_temp08;
		elsif (cur_out08 IS null) THEN
			cur_out08 := cur_temp08;
		elsif (cur_out09 IS null) THEN
			cur_out09 := cur_temp08;
		elsif (cur_out10 IS null) THEN
			cur_out10 := cur_temp08;
		elsif (cur_out11 IS null) THEN
			cur_out11 := cur_temp08;
		elsif (cur_out12 IS null) THEN
			cur_out12 := cur_temp08;
		elsif (cur_out13 IS null) THEN
			cur_out13 := cur_temp08;
		elsif (cur_out14 IS null) THEN
			cur_out14 := cur_temp08;
		ELSE
			cur_out14 := cur_temp08;
		END IF;
	ELSE
		IF (iCreditStatus <> 1)  THEN
			OPEN cur_temp09 for
			SELECT  to_char(order_date, 'mm/dd/yyyy') AS order_date,
				to_char(last_change_date, 'mm/dd/yyyy') AS posting_date,
				CASE
					WHEN (ya_prod_lang.prod_name_u IS null OR ya_prod_lang.prod_name_u = '')
					THEN (SELECT prod_name_u FROM ya_prod_lang WHERE sku=yalo.sku AND lang_id = 1)
					ELSE
					ya_prod_lang.prod_name_u
					END
				AS prod_name,
				yalo.sku,
				sum(yalo.quantity) AS items, link_id,
				sum(yalo.unit_price * yalo.quantity) AS price
			FROM
				(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, ya_associate_link_orders.link_id
				FROM
					(SELECT *
					FROM ya_associate_link_orders
					WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
					) ya_associate_link_orders
				INNER JOIN
					(SELECT *
					FROM ya_associate_link
					WHERE associate_id=iAssociateId
					) yal
				ON ya_associate_link_orders.link_id = yal.link_id
				WHERE (ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
			                                  (ya_associate_link_orders.last_change_date <  to_date(cEndDate, 'mm/dd/yyyy')) AND
			                 	               (credit_status = 2) AND (unit_price > 0)) yalo
				LEFT OUTER  JOIN ya_product ON yalo.sku = ya_product.sku
				LEFT OUTER  JOIN ya_prod_lang ON yalo.sku = ya_prod_lang.sku
			WHERE      (ya_prod_lang.lang_id = tiLangId)
			GROUP BY ya_prod_lang.prod_name_u,  yalo.sku, link_id,
				to_char(order_date, 'mm/dd/yyyy'), to_char(last_change_date, 'mm/dd/yyyy')
			ORDER BY posting_date, prod_name;

			IF (cur_out01 IS null) THEN
				cur_out01 := cur_temp09;
			elsif (cur_out02 IS null) THEN
				cur_out02 := cur_temp09;
			elsif (cur_out03 IS null) THEN
				cur_out03 := cur_temp09;
			elsif (cur_out04 IS null) THEN
				cur_out04 := cur_temp09;
			elsif (cur_out05 IS null) THEN
				cur_out05 := cur_temp09;
			elsif (cur_out06 IS null) THEN
				cur_out06 := cur_temp09;
			elsif (cur_out07 IS null) THEN
				cur_out07 := cur_temp09;
			elsif (cur_out08 IS null) THEN
				cur_out08 := cur_temp09;
			elsif (cur_out09 IS null) THEN
				cur_out09 := cur_temp09;
			elsif (cur_out10 IS null) THEN
				cur_out10 := cur_temp09;
			elsif (cur_out11 IS null) THEN
				cur_out11 := cur_temp09;
			elsif (cur_out12 IS null) THEN
				cur_out12 := cur_temp09;
			elsif (cur_out13 IS null) THEN
				cur_out13 := cur_temp09;
			elsif (cur_out14 IS null) THEN
				cur_out14 := cur_temp09;
			ELSE
				cur_out14 := cur_temp09;
			END IF;
		END IF;

		IF (iCreditStatus <>2) THEN
			OPEN cur_temp10 for
			SELECT  to_char(order_date, 'mm/dd/yyyy') AS order_date, to_char(last_change_date, 'mm/dd/yyyy') AS posting_date,
			                CASE
					WHEN (ya_prod_lang.prod_name_u IS null OR ya_prod_lang.prod_name_u = '')
					THEN (SELECT prod_name_u FROM ya_prod_lang WHERE sku=yalo.sku AND lang_id = 1)
					ELSE ya_prod_lang.prod_name_u
					END
				AS prod_name,
				yalo.sku, sum(yalo.quantity) AS items,
				sum(yalo.unit_price * yalo.quantity) AS price, yalo.link_id,
			                      yg.group_id
			FROM
				(SELECT order_date, last_change_date, sku, nvl(quantity, 0) AS quantity, nvl(unit_price, 0) AS unit_price, credit_status, yal.link_id
				FROM
					(SELECT *
					FROM ya_associate_link_orders
					WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
					) ya_associate_link_orders
				INNER JOIN
					(SELECT *
					FROM ya_associate_link
					WHERE associate_id=iAssociateId
					) yal
				ON ya_associate_link_orders.link_id = yal.link_id
				WHERE (ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
			                                  (ya_associate_link_orders.last_change_date <  to_date(cEndDate, 'mm/dd/yyyy')) AND
			                 	               (credit_status = 1) AND (unit_price > 0)
				) yalo
				LEFT OUTER  JOIN ya_product ON yalo.sku = ya_product.sku
				LEFT OUTER  JOIN ya_prod_lang ON yalo.sku = ya_prod_lang.sku
				LEFT OUTER  JOIN
					(SELECT *
					FROM ya_group
					WHERE division_id=1
					) yg
				ON yg.account_id = ya_product.account_id
			WHERE      (ya_prod_lang.lang_id = tiLangId)
			GROUP BY ya_prod_lang.prod_name_u,  yalo.sku, yg.group_id, link_id,
				to_char(order_date, 'mm/dd/yyyy'), to_char(last_change_date, 'mm/dd/yyyy')
			ORDER BY group_id, posting_date, prod_name;

			IF (cur_out01 IS null) THEN
				cur_out01 := cur_temp10;
			elsif (cur_out02 IS null) THEN
				cur_out02 := cur_temp10;
			elsif (cur_out03 IS null) THEN
				cur_out03 := cur_temp10;
			elsif (cur_out04 IS null) THEN
				cur_out04 := cur_temp10;
			elsif (cur_out05 IS null) THEN
				cur_out05 := cur_temp10;
			elsif (cur_out06 IS null) THEN
				cur_out06 := cur_temp10;
			elsif (cur_out07 IS null) THEN
				cur_out07 := cur_temp10;
			elsif (cur_out08 IS null) THEN
				cur_out08 := cur_temp10;
			elsif (cur_out09 IS null) THEN
				cur_out09 := cur_temp10;
			elsif (cur_out10 IS null) THEN
				cur_out10 := cur_temp10;
			elsif (cur_out11 IS null) THEN
				cur_out11 := cur_temp10;
			elsif (cur_out12 IS null) THEN
				cur_out12 := cur_temp10;
			elsif (cur_out13 IS null) THEN
				cur_out13 := cur_temp10;
			elsif (cur_out14 IS null) THEN
				cur_out14 := cur_temp10;
			ELSE
				cur_out14 := cur_temp10;
			END IF;

			OPEN cur_temp11 for
			SELECT    sum(yalo.quantity) AS items,
				sum(yalo.unit_price * yalo.quantity) AS price
			FROM
				(SELECT order_date, last_change_date, sku, nvl(quantity, 0) AS quantity, nvl(unit_price, 0) AS unit_price, credit_status
				 FROM
					(SELECT *
					FROM ya_associate_link_orders
					WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
					) ya_associate_link_orders
				INNER JOIN
					(SELECT *
					FROM ya_associate_link
					WHERE associate_id=iAssociateId
					) yal
				ON ya_associate_link_orders.link_id = yal.link_id
				WHERE (ya_associate_link_orders.order_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
			                                  (ya_associate_link_orders.order_date <  to_date(cEndDate, 'mm/dd/yyyy')) AND
			                 	               (credit_status =1) AND (unit_price > 0)
				) yalo
			GROUP BY to_number(to_char(order_date, 'fmmm'));

			IF (cur_out01 IS null) THEN
				cur_out01 := cur_temp11;
			elsif (cur_out02 IS null) THEN
				cur_out02 := cur_temp11;
			elsif (cur_out03 IS null) THEN
				cur_out03 := cur_temp11;
			elsif (cur_out04 IS null) THEN
				cur_out04 := cur_temp11;
			elsif (cur_out05 IS null) THEN
				cur_out05 := cur_temp11;
			elsif (cur_out06 IS null) THEN
				cur_out06 := cur_temp11;
			elsif (cur_out07 IS null) THEN
				cur_out07 := cur_temp11;
			elsif (cur_out08 IS null) THEN
				cur_out08 := cur_temp11;
			elsif (cur_out09 IS null) THEN
				cur_out09 := cur_temp11;
			elsif (cur_out10 IS null) THEN
				cur_out10 := cur_temp11;
			elsif (cur_out11 IS null) THEN
				cur_out11 := cur_temp11;
			elsif (cur_out12 IS null) THEN
				cur_out12 := cur_temp11;
			elsif (cur_out13 IS null) THEN
				cur_out13 := cur_temp11;
			elsif (cur_out14 IS null) THEN
				cur_out14 := cur_temp11;
			ELSE
				cur_out14 := cur_temp11;
			END IF;
		END IF;
	END IF;

	IF (cStartDate < cCutOffDate) THEN
		OPEN cur_temp12 for
		SELECT    sum(yalo.quantity) AS items,
			sum(yalo.unit_price * yalo.quantity) AS price,
			to_number(to_char(order_date, 'fmmm')) AS posting_month,
			to_number(to_char(order_date, 'yyyy')) AS posting_year,
			(SELECT link_percentage FROM ya_associate_link WHERE associate_id=iAssociateId AND rownum=1 ) AS percentage,
			--sum(yalo.unit_price * yalo.quantity) * (SELECT link_percentage FROM ya_associate_link WHERE associate_id=iAssociateId AND rownum=1) AS commission
			sum(nvl(yalo.credit_amount, yalo.unit_price * yalo.quantity* nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = 8050 AND rownum=1))))) AS commission
		FROM
			(SELECT order_date, last_change_date, sku, nvl(quantity, 0) AS quantity, nvl(unit_price, 0) AS unit_price, credit_status, credit_amount
			FROM
				(SELECT *
				FROM ya_associate_link_orders
				WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) ya_associate_link_orders
			INNER JOIN
				(SELECT *
				FROM ya_associate_link
				WHERE associate_id=iAssociateId
				) yal
			ON ya_associate_link_orders.link_id = yal.link_id
			WHERE (ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
				(ya_associate_link_orders.last_change_date < to_date(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (unit_price > 0)
			) yalo
		LEFT OUTER JOIN ya_associate_commission_hist yach on yach.associate_id = iAssociateId
			AND yach.valid_date = to_date(to_char(order_date, 'mm') || '/01/' || to_char(order_date, 'yyyy'), 'mm/dd/yyyy'),
			(SELECT percentage  FROM ya_associate_commission_detail cd INNER JOIN
			(SELECT comm_type_id, nc_max FROM ya_associate_commission_type ct WHERE ((nc_min <= iCustomer AND nc_max >= iCustomer) OR nc_max < iCustomer)) ct
			ON ct.comm_type_id =cd.comm_type_id
			INNER JOIN
				(SELECT commission_id, payment_option
				FROM ya_associate
				WHERE associate_id=iAssociateId
				) ya
			ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
         WHERE rownum=1
			)t
		GROUP BY to_number(to_char(order_date, 'fmmm')), to_number(to_char(order_date, 'yyyy')) , comm_rate, t.percentage;

		IF (cur_out01 IS null) THEN
			cur_out01 := cur_temp12;
		elsif (cur_out02 IS null) THEN
			cur_out02 := cur_temp12;
		elsif (cur_out03 IS null) THEN
			cur_out03 := cur_temp12;
		elsif (cur_out04 IS null) THEN
			cur_out04 := cur_temp12;
		elsif (cur_out05 IS null) THEN
			cur_out05 := cur_temp12;
		elsif (cur_out06 IS null) THEN
			cur_out06 := cur_temp12;
		elsif (cur_out07 IS null) THEN
			cur_out07 := cur_temp12;
		elsif (cur_out08 IS null) THEN
			cur_out08 := cur_temp12;
		elsif (cur_out09 IS null) THEN
			cur_out09 := cur_temp12;
		elsif (cur_out10 IS null) THEN
			cur_out10 := cur_temp12;
		elsif (cur_out11 IS null) THEN
			cur_out11 := cur_temp12;
		elsif (cur_out12 IS null) THEN
			cur_out12 := cur_temp12;
		elsif (cur_out13 IS null) THEN
			cur_out13 := cur_temp12;
		elsif (cur_out14 IS null) THEN
			cur_out14 := cur_temp12;
		ELSE
			cur_out14 := cur_temp12;
		END IF;
	ELSE
		OPEN cur_temp13 for
		SELECT    sum(yalo.quantity) AS items,
			sum(yalo.unit_price * yalo.quantity) AS price,
			to_number(to_char(order_date, 'fmmm')) AS posting_month,
			to_number(to_char(order_date, 'yyyy')) AS posting_year,
			nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = iAssociateId AND rownum=1))) AS percentage,
			--sum(yalo.unit_price * yalo.quantity) * nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = iAssociateId AND rownum=1 )))  AS commission
			sum(nvl(yalo.credit_amount, yalo.unit_price * yalo.quantity* nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = 8050 AND rownum=1))))) AS commission
		FROM
			(SELECT order_date, last_change_date, sku, nvl(quantity, 0) AS quantity, nvl(unit_price, 0) AS unit_price, credit_status, credit_amount
			FROM
				(SELECT *
				FROM ya_associate_link_orders
				WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) ya_associate_link_orders
			INNER JOIN
				(SELECT *
				FROM ya_associate_link
				WHERE associate_id=iAssociateId
				) yal
			ON ya_associate_link_orders.link_id = yal.link_id
			WHERE (ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
				(ya_associate_link_orders.last_change_date < to_date(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (unit_price > 0)
			) yalo
			LEFT OUTER JOIN ya_associate_commission_hist yach on yach.associate_id = iAssociateId
				AND yach.valid_date = to_date(to_char(order_date, 'mm') || '/01/' || to_char(order_date, 'yyyy'), 'mm/dd/yyyy'),
				(SELECT percentage  FROM ya_associate_commission_detail cd INNER JOIN
				(SELECT comm_type_id, nc_max FROM ya_associate_commission_type ct WHERE ((nc_min <= iCustomer AND nc_max >= iCustomer) OR nc_max < iCustomer)) ct
				ON ct.comm_type_id =cd.comm_type_id
				INNER JOIN
					(SELECT commission_id, payment_option
					FROM ya_associate
					WHERE associate_id=iAssociateId
					) ya
			ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
         WHERE rownum=1
			)t
		GROUP BY to_number(to_char(order_date, 'fmmm')), to_number(to_char(order_date, 'yyyy')), comm_rate, t.percentage;

		IF (cur_out01 IS null) THEN
			cur_out01 := cur_temp13;
		elsif (cur_out02 IS null) THEN
			cur_out02 := cur_temp13;
		elsif (cur_out03 IS null) THEN
			cur_out03 := cur_temp13;
		elsif (cur_out04 IS null) THEN
			cur_out04 := cur_temp13;
		elsif (cur_out05 IS null) THEN
			cur_out05 := cur_temp13;
		elsif (cur_out06 IS null) THEN
			cur_out06 := cur_temp13;
		elsif (cur_out07 IS null) THEN
			cur_out07 := cur_temp13;
		elsif (cur_out08 IS null) THEN
			cur_out08 := cur_temp13;
		elsif (cur_out09 IS null) THEN
			cur_out09 := cur_temp13;
		elsif (cur_out10 IS null) THEN
			cur_out10 := cur_temp13;
		elsif (cur_out11 IS null) THEN
			cur_out11 := cur_temp13;
		elsif (cur_out12 IS null) THEN
			cur_out12 := cur_temp13;
		elsif (cur_out13 IS null) THEN
			cur_out13 := cur_temp13;
		elsif (cur_out14 IS null) THEN
			cur_out14 := cur_temp13;
		ELSE
			cur_out14 := cur_temp13;
		END IF;
	END IF;
END IF;

IF (iNeedLinkInfo = 1) THEN
	OPEN cur_temp14 for
	SELECT link_id, '<B>' || site_name || '</B> (' || link_code || ')' AS site_name FROM ya_associate_link WHERE associate_id = iAssociateId;
	IF (cur_out01 IS null) THEN
		cur_out01 := cur_temp14;
	elsif (cur_out02 IS null) THEN
		cur_out02 := cur_temp14;
	elsif (cur_out03 IS null) THEN
		cur_out03 := cur_temp14;
	elsif (cur_out04 IS null) THEN
		cur_out04 := cur_temp14;
	elsif (cur_out05 IS null) THEN
		cur_out05 := cur_temp14;
	elsif (cur_out06 IS null) THEN
		cur_out06 := cur_temp14;
	elsif (cur_out07 IS null) THEN
		cur_out07 := cur_temp14;
	elsif (cur_out08 IS null) THEN
		cur_out08 := cur_temp14;
	elsif (cur_out09 IS null) THEN
		cur_out09 := cur_temp14;
	elsif (cur_out10 IS null) THEN
		cur_out10 := cur_temp14;
	elsif (cur_out11 IS null) THEN
		cur_out11 := cur_temp14;
	elsif (cur_out12 IS null) THEN
		cur_out12 := cur_temp14;
	elsif (cur_out13 IS null) THEN
		cur_out13 := cur_temp14;
	elsif (cur_out14 IS null) THEN
		cur_out14 := cur_temp14;
	ELSE
		cur_out14 := cur_temp14;
	END IF;
	SELECT nvl(lang_id, 1) INTO iLangId FROM ya_associate_link WHERE associate_id = iAssociateId AND rownum=1;
END IF;


IF (cur_out01 IS null) THEN
	OPEN cur_out01 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out02 IS null) THEN
	OPEN cur_out02 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out03 IS null) THEN
	OPEN cur_out03 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out04 IS null) THEN
	OPEN cur_out04 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out05 IS null) THEN
	OPEN cur_out05 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out06 IS null) THEN
	OPEN cur_out06 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out07 IS null) THEN
	OPEN cur_out07 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out08 IS null) THEN
	OPEN cur_out08 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out09 IS null) THEN
	OPEN cur_out09 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out10 IS null) THEN
	OPEN cur_out10 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out11 IS null) THEN
	OPEN cur_out11 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out12 IS null) THEN
	OPEN cur_out12 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out13 IS null) THEN
	OPEN cur_out13 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out14 IS null) THEN
	OPEN cur_out14 for
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
	iCustomer out INT,
	deciPercentage out float,
	iNextLevel out INT,
	iLangId out INT,
	deciThisPeriodComm out float,
	deciTotalComm out float,
	cur_out01 out cur_return,
	cur_out02 out cur_return,
	cur_out03 out cur_return,
	cur_out04 out cur_return,
	cur_out05 out cur_return,
	cur_out06 out cur_return,
	cur_out07 out cur_return,
	cur_out08 out cur_return,
	cur_out09 out cur_return,
	cur_out10 out cur_return,
	cur_out11 out cur_return,
	cur_out12 out cur_return,
	cur_out13 out cur_return,
	cur_out14 out cur_return
) IS

	cStartDate varchar(10);
	cEndDate varchar(10);
	cCutOffDate varchar(10);

	type typePercentageNextLevel IS record(percentage float, next_level INT);
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
cEndDate := to_char(add_months(to_date(cStartDate, 'mm/dd/yyyy'), 1), 'mm/dd/yyyy');
cCutOffDate := '07/01/2005';

SELECT count(customerId) INTO iCustomer
FROM dm_new_shopper
WHERE dm_new_shopper.validOrder = 'Y'
	AND dm_new_shopper.feOrderId IN
	(SELECT  distinct to_char(order_num) AS orderId
	FROM
		(SELECT *
		FROM ya_associate_link_orders
		WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)) ya_associate_link_orders
	INNER JOIN
		(SELECT link_id
		FROM ya_associate_link
		WHERE associate_id=iAssociateId) yal
	ON ya_associate_link_orders.link_id = yal.link_id
	WHERE order_date >= to_date(cStartDate, 'mm/dd/yyyy') AND order_date < to_date(cEndDate, 'mm/dd/yyyy') AND credit_status <> 4);


IF (to_date(cStartDate, 'mm/dd/yyyy') < to_date(cCutOffDate, 'mm/dd/yyyy')) THEN
	SELECT link_percentage INTO deciPercentage FROM ya_associate_link WHERE associate_id=iAssociateId AND rownum=1 ORDER BY link_id ASC;
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
   SELECT comm_rate, 0 INTO ret_percentage_next_level FROM ya_associate_commission_hist ach WHERE valid_date = to_date(cStartDate, 'mm/dd/yyyy') AND associate_id = iAssociateId AND rownum = 1;
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
		ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option AND rownum = 1;

   ELSE
		SELECT deciPercentage, nc_max + 1 - iCustomer INTO ret_percentage_next_level
		FROM ya_associate_commission_detail cd INNER JOIN
				(SELECT comm_type_id, nc_max
				FROM ya_associate_commission_type ct
				WHERE nc_min <= iCustomer ) ct
			ON ct.comm_type_id =cd.comm_type_id
			 INNER JOIN (SELECT commission_id, payment_option
				FROM ya_associate
				WHERE associate_id=iAssociateId) ya
		ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option AND rownum = 1;
	END IF;
	deciPercentage := ret_percentage_next_level.percentage;
	iNextLevel := ret_percentage_next_level.next_level;
END IF;

/*use new comm %*/
SELECT sum(nvl(credit_amount,unit_price * quantity * deciPercentage)) INTO deciTotalComm
FROM ya_associate_link_orders
WHERE
	(last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
	(last_change_date < to_date(cEndDate, 'mm/dd/yyyy')) AND
	link_id IN (SELECT link_id FROM ya_associate_link WHERE associate_id=iAssociateId) AND
	credit_status = 2;

SELECT sum(nvl(credit_amount,unit_price * quantity * nvl(deciPercentage,0))) INTO deciThisPeriodComm
FROM ya_associate_link_orders
WHERE
	(last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
	(last_change_date < to_date(cEndDate, 'mm/dd/yyyy')) AND
	order_date >= to_date(cStartDate, 'mm/dd/yyyy') AND order_date < to_date(cEndDate, 'mm/dd/yyyy') AND
	link_id IN (SELECT link_id FROM ya_associate_link WHERE associate_id=iAssociateId) AND
	credit_status = 2;


IF (iNeedGroup = 1) THEN
	IF (iCreditStatus <> 1) THEN

		OPEN cur_out01 for
		SELECT  to_char(order_date, 'mm/dd/yyyy') AS order_date, to_char(last_change_date, 'mm/dd/yyyy') AS posting_date,
			CASE
				WHEN (ya_prod_lang.prod_name_u IS null OR ya_prod_lang.prod_name_u = '')
				THEN (SELECT prod_name_u FROM ya_prod_lang WHERE sku=yalo.sku AND lang_id = 1)
				ELSE ya_prod_lang.prod_name_u
				END
			AS prod_name,
			yalo.sku, sum(yalo.quantity) AS items,
			sum(yalo.unit_price * yalo.quantity) AS price, yalo.link_id,
			yg.group_id
		FROM
			(SELECT order_date, last_change_date, sku, nvl(quantity, 0) AS quantity, nvl(unit_price, 0) AS unit_price, credit_status, link_id
			FROM
				(SELECT *
				FROM ya_associate_link_orders
				WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) ya_associate_link_orders
			WHERE (ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
				(ya_associate_link_orders.last_change_date <  to_date(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (unit_price > 0) AND
				(link_id = iLinkId)
			) yalo
		LEFT OUTER  JOIN
			ya_product ON yalo.sku = ya_product.sku
		LEFT OUTER  JOIN
			ya_prod_lang ON yalo.sku = ya_prod_lang.sku
		LEFT OUTER  JOIN
			(SELECT * FROM ya_group WHERE division_id=1) yg
			ON yg.account_id = ya_product.account_id
		WHERE      (ya_prod_lang.lang_id = tiLangId)
		GROUP BY ya_prod_lang.prod_name_u,  yalo.sku, yg.group_id, link_id,
			to_char(order_date, 'mm/dd/yyyy'), to_char(last_change_date, 'mm/dd/yyyy')
		ORDER BY group_id, posting_date, prod_name;

		OPEN cur_out02 for
		SELECT distinct yg.group_id
		FROM
			(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status
			FROM
				(SELECT *
				FROM ya_associate_link_orders
				WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) ya_associate_link_orders
			WHERE (ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
				(ya_associate_link_orders.last_change_date <  to_date(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (link_id = iLinkId) AND (unit_price > 0)) yalo
		LEFT OUTER  JOIN
			ya_product ON yalo.sku = ya_product.sku
		LEFT OUTER  JOIN
			(SELECT * FROM ya_group WHERE division_id=1) yg
			ON yg.account_id = ya_product.account_id;
	END IF;

	IF (iCreditStatus <>2) THEN
		OPEN cur_temp03 for
		SELECT   to_char(yalo.order_date, 'mm/dd/yyyy') AS order_date,
			CASE
				WHEN (ya_prod_lang.prod_name_u IS null OR ya_prod_lang.prod_name_u = '')
				THEN (SELECT prod_name_u FROM ya_prod_lang WHERE sku=yalo.sku AND lang_id = 1)
				ELSE ya_prod_lang.prod_name_u
				END
			AS prod_name, yalo.sku,
			sum(yalo.quantity) AS items,
			sum(yalo.unit_price * yalo.quantity) AS price, link_id,
			yg.group_id
		FROM
			(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, ya_associate_link_orders.link_id
			FROM
				(SELECT *
				FROM ya_associate_link_orders
				WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) ya_associate_link_orders
			WHERE (ya_associate_link_orders.order_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
				(ya_associate_link_orders.order_date < to_date(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 1) AND (link_id = iLinkId) AND (unit_price > 0)
			) yalo
		LEFT OUTER  JOIN
			ya_product ON yalo.sku = ya_product.sku
		LEFT OUTER  JOIN
			ya_prod_lang ON yalo.sku = ya_prod_lang.sku
		LEFT OUTER  JOIN
			(SELECT * FROM ya_group WHERE division_id=1) yg
		ON yg.account_id = ya_product.account_id
		WHERE      (ya_prod_lang.lang_id = tiLangId OR ya_prod_lang.lang_id = 1)
		GROUP BY ya_prod_lang.prod_name_u,  yalo.sku, yg.group_id, order_date, link_id
		ORDER BY group_id, order_date, prod_name;

		IF (cur_out01 IS null) THEN
			cur_out01 := cur_temp03;
		elsif (cur_out02 IS null) THEN
			cur_out02 := cur_temp03;
		elsif (cur_out03 IS null) THEN
			cur_out03 := cur_temp03;
		elsif (cur_out04 IS null) THEN
			cur_out04 := cur_temp03;
		elsif (cur_out05 IS null) THEN
			cur_out05 := cur_temp03;
		elsif (cur_out06 IS null) THEN
			cur_out06 := cur_temp03;
		elsif (cur_out07 IS null) THEN
			cur_out07 := cur_temp03;
		elsif (cur_out08 IS null) THEN
			cur_out08 := cur_temp03;
		elsif (cur_out09 IS null) THEN
			cur_out09 := cur_temp03;
		elsif (cur_out10 IS null) THEN
			cur_out10 := cur_temp03;
		ELSE
			cur_out11 := cur_temp03;
		END IF;

		OPEN cur_temp04 for
		SELECT    DISTINCT  yg.group_id
		FROM
			(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status
			FROM
				(SELECT *
				FROM ya_associate_link_orders
				WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) ya_associate_link_orders
			WHERE (ya_associate_link_orders.order_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
				(ya_associate_link_orders.order_date <  to_date(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 1) AND (link_id = iLinkId) AND (unit_price > 0)
			) yalo
		LEFT OUTER  JOIN
			ya_product ON yalo.sku = ya_product.sku
		LEFT OUTER  JOIN
			(SELECT * FROM ya_group WHERE division_id=1) yg
		ON yg.account_id = ya_product.account_id;

		IF (cur_out01 IS null) THEN
			cur_out01 := cur_temp04;
		elsif (cur_out02 IS null) THEN
			cur_out02 := cur_temp04;
		elsif (cur_out03 IS null) THEN
			cur_out03 := cur_temp04;
		elsif (cur_out04 IS null) THEN
			cur_out04 := cur_temp04;
		elsif (cur_out05 IS null) THEN
			cur_out05 := cur_temp04;
		elsif (cur_out06 IS null) THEN
			cur_out06 := cur_temp04;
		elsif (cur_out07 IS null) THEN
			cur_out07 := cur_temp04;
		elsif (cur_out08 IS null) THEN
			cur_out08 := cur_temp04;
		elsif (cur_out09 IS null) THEN
			cur_out09 := cur_temp04;
		elsif (cur_out10 IS null) THEN
			cur_out10 := cur_temp04;
		elsif (cur_out11 IS null) THEN
			cur_out11 := cur_temp04;
		elsif (cur_out12 IS null) THEN
			cur_out12 := cur_temp04;
		elsif (cur_out13 IS null) THEN
			cur_out13 := cur_temp04;
		elsif (cur_out14 IS null) THEN
			cur_out14 := cur_temp04;
		ELSE
			cur_out14 := cur_temp04;
		END IF;

		OPEN cur_temp05 for
		SELECT    sum(yalo.quantity) AS items,
			sum(yalo.unit_price * yalo.quantity) AS price
		FROM
			(SELECT order_date, last_change_date, sku, nvl(quantity, 0) AS quantity, nvl(unit_price, 0) AS unit_price, credit_status
			FROM
				(SELECT *
				FROM ya_associate_link_orders
				WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) ya_associate_link_orders
			WHERE (ya_associate_link_orders.order_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
		                                  (ya_associate_link_orders.order_date <  to_date(cEndDate, 'mm/dd/yyyy')) AND
		                 	               (credit_status =1) AND (link_id = iLinkId) AND (unit_price > 0)
			) yalo
		GROUP BY to_number(to_char(order_date, 'fmmm'));

		IF (cur_out01 IS null) THEN
			cur_out01 := cur_temp05;
		elsif (cur_out02 IS null) THEN
			cur_out02 := cur_temp05;
		elsif (cur_out03 IS null) THEN
			cur_out03 := cur_temp05;
		elsif (cur_out04 IS null) THEN
			cur_out04 := cur_temp05;
		elsif (cur_out05 IS null) THEN
			cur_out05 := cur_temp05;
		elsif (cur_out06 IS null) THEN
			cur_out06 := cur_temp05;
		elsif (cur_out07 IS null) THEN
			cur_out07 := cur_temp05;
		elsif (cur_out08 IS null) THEN
			cur_out08 := cur_temp05;
		elsif (cur_out09 IS null) THEN
			cur_out09 := cur_temp05;
		elsif (cur_out10 IS null) THEN
			cur_out10 := cur_temp05;
		elsif (cur_out11 IS null) THEN
			cur_out11 := cur_temp05;
		elsif (cur_out12 IS null) THEN
			cur_out12 := cur_temp05;
		elsif (cur_out13 IS null) THEN
			cur_out13 := cur_temp05;
		elsif (cur_out14 IS null) THEN
			cur_out14 := cur_temp05;
		ELSE
			cur_out14 := cur_temp05;
		END IF;

	END IF;

	IF (to_date(cStartDate, 'mm/dd/yyyy') < to_date(cCutOffDate, 'mm/dd/yyyy')) THEN
		OPEN cur_temp06 for
		SELECT    sum(yalo.quantity) AS items,
			sum(yalo.unit_price * yalo.quantity) AS price,
			to_number(to_char(order_date,'fmmm')) AS posting_month,
			to_number(to_char(order_date,'yyyy')) AS posting_year,
			(SELECT link_percentage FROM ya_associate_link WHERE associate_id=iAssociateId AND rownum=1) AS percentage,
			--sum(yalo.unit_price * yalo.quantity) * (SELECT link_percentage FROM ya_associate_link WHERE associate_id=iAssociateId AND rownum = 1)  AS commission
			sum(nvl(yalo.credit_amount, yalo.unit_price * yalo.quantity* nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = 8050 AND rownum=1))))) AS commission
		FROM
			(SELECT order_date, last_change_date, sku,nvl(quantity, 0) AS quantity, nvl(unit_price, 0) AS unit_price, credit_status, credit_amount
			FROM
				(SELECT *
				FROM ya_associate_link_orders
				WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) ya_associate_link_orders
			WHERE (ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
				(ya_associate_link_orders.last_change_date < to_date(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (link_id = iLinkId) AND (unit_price > 0)
			) yalo
			LEFT OUTER JOIN ya_associate_commission_hist yach on yach.associate_id = iAssociateId
				AND yach.valid_date = to_date(to_char(order_date, 'mm') || '/01/' || to_char(order_date, 'yyyy'), 'mm/dd/yyyy'),
				(SELECT percentage
				FROM ya_associate_commission_detail cd
				INNER JOIN
					(SELECT comm_type_id, nc_max
					FROM ya_associate_commission_type ct
               WHERE ((nc_min <=iCustomer AND nc_max >=iCustomer) OR (nc_max < iCustomer))
               ORDER BY nc_min DESC
					) ct
				ON ct.comm_type_id =cd.comm_type_id
				INNER JOIN
					(SELECT commission_id, payment_option
					FROM ya_associate
					WHERE associate_id=iAssociateId
					) ya
				ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
            WHERE rownum=1
				)t
		GROUP BY to_number(to_char(order_date,'fmmm')), to_number(to_char(order_date, 'yyyy')) , comm_rate, t.percentage;

		IF (cur_out01 IS null) THEN
			cur_out01 := cur_temp06;
		elsif (cur_out02 IS null) THEN
			cur_out02 := cur_temp06;
		elsif (cur_out03 IS null) THEN
			cur_out03 := cur_temp06;
		elsif (cur_out04 IS null) THEN
			cur_out04 := cur_temp06;
		elsif (cur_out05 IS null) THEN
			cur_out05 := cur_temp06;
		elsif (cur_out06 IS null) THEN
			cur_out06 := cur_temp06;
		elsif (cur_out07 IS null) THEN
			cur_out07 := cur_temp06;
		elsif (cur_out08 IS null) THEN
			cur_out08 := cur_temp06;
		elsif (cur_out09 IS null) THEN
			cur_out09 := cur_temp06;
		elsif (cur_out10 IS null) THEN
			cur_out10 := cur_temp06;
		elsif (cur_out11 IS null) THEN
			cur_out11 := cur_temp06;
		elsif (cur_out12 IS null) THEN
			cur_out12 := cur_temp06;
		elsif (cur_out13 IS null) THEN
			cur_out13 := cur_temp06;
		elsif (cur_out14 IS null) THEN
			cur_out14 := cur_temp06;
		ELSE
			cur_out14 := cur_temp06;
		END IF;
	ELSE
		OPEN cur_temp07 for
		SELECT    sum(yalo.quantity) AS items,
			sum(yalo.unit_price * yalo.quantity) AS price,
			to_number(to_char(order_date, 'fmmm')) AS posting_month,
			to_number(to_char(order_date, 'yyyy')) AS posting_year,
			nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = iAssociateId AND rownum=1))) AS percentage,
			--sum(yalo.unit_price * yalo.quantity) * nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = iAssociateId AND rownum=1)))  AS commission
			sum(nvl(yalo.credit_amount, yalo.unit_price * yalo.quantity* nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = 8050 AND rownum=1))))) AS commission
		FROM
			(SELECT order_date, last_change_date, sku, nvl(quantity, 0) AS quantity, nvl(unit_price, 0) AS unit_price, credit_status, credit_amount
			FROM
				(SELECT *
				FROM ya_associate_link_orders
				WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) ya_associate_link_orders
			WHERE
				(ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
				(ya_associate_link_orders.last_change_date < to_date(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (link_id = iLinkId) AND (unit_price > 0)
			) yalo
		LEFT OUTER JOIN ya_associate_commission_hist yach on yach.associate_id = iAssociateId
			AND yach.valid_date = to_date(to_char(order_date, 'mm') || '/01/' || to_char(order_date, 'yyyy'), 'mm/dd/yyyy'),
			(SELECT percentage
			FROM ya_associate_commission_detail cd
			INNER JOIN
				(SELECT comm_type_id, 	nc_max
				FROM ya_associate_commission_type ct
				WHERE ((nc_min <=iCustomer AND nc_max >=iCustomer) OR (nc_max < iCustomer))
            ORDER BY nc_min DESC
				) ct
			ON ct.comm_type_id =cd.comm_type_id
			INNER JOIN
				(SELECT commission_id, payment_option
				FROM ya_associate
				WHERE associate_id=iAssociateId
				) ya
			ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
         WHERE rownum=1
			)t
		GROUP BY to_number(to_char(order_date,'fmmm')), to_number(to_char(order_date, 'yyyy')) , comm_rate, t.percentage;

		IF (cur_out01 IS null) THEN
			cur_out01 := cur_temp07;
		elsif (cur_out02 IS null) THEN
			cur_out02 := cur_temp07;
		elsif (cur_out03 IS null) THEN
			cur_out03 := cur_temp07;
		elsif (cur_out04 IS null) THEN
			cur_out04 := cur_temp07;
		elsif (cur_out05 IS null) THEN
			cur_out05 := cur_temp07;
		elsif (cur_out06 IS null) THEN
			cur_out06 := cur_temp07;
		elsif (cur_out07 IS null) THEN
			cur_out07 := cur_temp07;
		elsif (cur_out08 IS null) THEN
			cur_out08 := cur_temp07;
		elsif (cur_out09 IS null) THEN
			cur_out09 := cur_temp07;
		elsif (cur_out10 IS null) THEN
			cur_out10 := cur_temp07;
		elsif (cur_out11 IS null) THEN
			cur_out11 := cur_temp07;
		elsif (cur_out12 IS null) THEN
			cur_out12 := cur_temp07;
		elsif (cur_out13 IS null) THEN
			cur_out13 := cur_temp07;
		elsif (cur_out14 IS null) THEN
			cur_out14 := cur_temp07;
		ELSE
			cur_out14 := cur_temp07;
		END IF;
	END IF;

END IF;

IF (iNeedGroup = 0) THEN

	IF (iBestSeller = 1) THEN
		OPEN cur_temp08 for
      SELECT * FROM(
         SELECT
            CASE
               WHEN (ya_prod_lang.prod_name_u IS null OR ya_prod_lang.prod_name_u = '')
               THEN (SELECT prod_name_u FROM ya_prod_lang WHERE sku=yalo.sku AND lang_id = 1)
               ELSE
               ya_prod_lang.prod_name_u
               END
            AS prod_name,
            yalo.sku,
            sum(yalo.quantity) AS items, link_id,
            sum(yalo.unit_price * yalo.quantity) AS price
         FROM
            (SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, ya_associate_link_orders.link_id
            FROM
               (SELECT *
               FROM ya_associate_link_orders
               WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
               ) ya_associate_link_orders
            WHERE (ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
               (ya_associate_link_orders.last_change_date <  to_date(cEndDate, 'mm/dd/yyyy')) AND
               (credit_status = 2 OR credit_status = 1) AND (link_id = iLinkId) AND (unit_price > 0)
            ) yalo
            LEFT OUTER  JOIN ya_product ON yalo.sku = ya_product.sku
            LEFT OUTER  JOIN ya_prod_lang ON yalo.sku = ya_prod_lang.sku
         WHERE      (ya_prod_lang.lang_id = tiLangId)
         GROUP BY ya_prod_lang.prod_name_u,  yalo.sku, link_id
         ORDER BY items DESC)
      WHERE (rownum<=20);

		IF (cur_out01 IS null) THEN
			cur_out01 := cur_temp08;
		elsif (cur_out02 IS null) THEN
			cur_out02 := cur_temp08;
		elsif (cur_out03 IS null) THEN
			cur_out03 := cur_temp08;
		elsif (cur_out04 IS null) THEN
			cur_out04 := cur_temp08;
		elsif (cur_out05 IS null) THEN
			cur_out05 := cur_temp08;
		elsif (cur_out06 IS null) THEN
			cur_out06 := cur_temp08;
		elsif (cur_out07 IS null) THEN
			cur_out07 := cur_temp08;
		elsif (cur_out08 IS null) THEN
			cur_out08 := cur_temp08;
		elsif (cur_out09 IS null) THEN
			cur_out09 := cur_temp08;
		elsif (cur_out10 IS null) THEN
			cur_out10 := cur_temp08;
		elsif (cur_out11 IS null) THEN
			cur_out11 := cur_temp08;
		elsif (cur_out12 IS null) THEN
			cur_out12 := cur_temp08;
		elsif (cur_out13 IS null) THEN
			cur_out13 := cur_temp08;
		elsif (cur_out14 IS null) THEN
			cur_out14 := cur_temp08;
		ELSE
			cur_out14 := cur_temp08;
		END IF;
	ELSE
		IF (iCreditStatus <> 1)  THEN
			OPEN cur_temp09 for
			SELECT  to_char(order_date, 'mm/dd/yyyy') AS order_date,
				to_char(last_change_date, 'mm/dd/yyyy') AS posting_date,
				CASE
					WHEN (ya_prod_lang.prod_name_u IS null OR ya_prod_lang.prod_name_u = '')
					THEN (SELECT prod_name_u FROM ya_prod_lang WHERE sku=yalo.sku AND lang_id = 1)
					ELSE
					ya_prod_lang.prod_name_u
					END
				AS prod_name,
				yalo.sku,
				sum(yalo.quantity) AS items, link_id,
				sum(yalo.unit_price * yalo.quantity) AS price
			FROM
				(SELECT order_date, last_change_date, sku, quantity, unit_price, credit_status, ya_associate_link_orders.link_id
				FROM
					(SELECT *
					FROM ya_associate_link_orders
					WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
					) ya_associate_link_orders
				WHERE (ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
			                                  (ya_associate_link_orders.last_change_date <  to_date(cEndDate, 'mm/dd/yyyy')) AND
			                 	               (credit_status = 2) AND (link_id = iLinkId) AND (unit_price > 0)) yalo
				LEFT OUTER  JOIN ya_product ON yalo.sku = ya_product.sku
				LEFT OUTER  JOIN ya_prod_lang ON yalo.sku = ya_prod_lang.sku
			WHERE      (ya_prod_lang.lang_id = tiLangId)
			GROUP BY ya_prod_lang.prod_name_u,  yalo.sku, link_id,
				to_char(order_date, 'mm/dd/yyyy'), to_char(last_change_date, 'mm/dd/yyyy')
			ORDER BY posting_date, prod_name;

			IF (cur_out01 IS null) THEN
				cur_out01 := cur_temp09;
			elsif (cur_out02 IS null) THEN
				cur_out02 := cur_temp09;
			elsif (cur_out03 IS null) THEN
				cur_out03 := cur_temp09;
			elsif (cur_out04 IS null) THEN
				cur_out04 := cur_temp09;
			elsif (cur_out05 IS null) THEN
				cur_out05 := cur_temp09;
			elsif (cur_out06 IS null) THEN
				cur_out06 := cur_temp09;
			elsif (cur_out07 IS null) THEN
				cur_out07 := cur_temp09;
			elsif (cur_out08 IS null) THEN
				cur_out08 := cur_temp09;
			elsif (cur_out09 IS null) THEN
				cur_out09 := cur_temp09;
			elsif (cur_out10 IS null) THEN
				cur_out10 := cur_temp09;
			elsif (cur_out11 IS null) THEN
				cur_out11 := cur_temp09;
			elsif (cur_out12 IS null) THEN
				cur_out12 := cur_temp09;
			elsif (cur_out13 IS null) THEN
				cur_out13 := cur_temp09;
			elsif (cur_out14 IS null) THEN
				cur_out14 := cur_temp09;
			ELSE
				cur_out14 := cur_temp09;
			END IF;
		END IF;

		IF (iCreditStatus <>2) THEN
			OPEN cur_temp10 for
			SELECT  to_char(order_date, 'mm/dd/yyyy') AS order_date, to_char(last_change_date, 'mm/dd/yyyy') AS posting_date,
			                CASE
					WHEN (ya_prod_lang.prod_name_u IS null OR ya_prod_lang.prod_name_u = '')
					THEN (SELECT prod_name_u FROM ya_prod_lang WHERE sku=yalo.sku AND lang_id = 1)
					ELSE ya_prod_lang.prod_name_u
					END
				AS prod_name,
				yalo.sku, sum(yalo.quantity) AS items,
				sum(yalo.unit_price * yalo.quantity) AS price, yalo.link_id,
			                      yg.group_id
			FROM
				(SELECT order_date, last_change_date, sku, nvl(quantity, 0) AS quantity, nvl(unit_price, 0) AS unit_price, credit_status, link_id
				FROM
					(SELECT *
					FROM ya_associate_link_orders
					WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
					) ya_associate_link_orders
				WHERE (ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
			                                  (ya_associate_link_orders.last_change_date <  to_date(cEndDate, 'mm/dd/yyyy')) AND
			                 	               (credit_status = 1) AND (link_id = iLinkId) AND (unit_price > 0)
				) yalo
				LEFT OUTER  JOIN ya_product ON yalo.sku = ya_product.sku
				LEFT OUTER  JOIN ya_prod_lang ON yalo.sku = ya_prod_lang.sku
				LEFT OUTER  JOIN
					(SELECT *
					FROM ya_group
					WHERE division_id=1
					) yg
				ON yg.account_id = ya_product.account_id
			WHERE      (ya_prod_lang.lang_id = tiLangId)
			GROUP BY ya_prod_lang.prod_name_u,  yalo.sku, yg.group_id, link_id,
				to_char(order_date, 'mm/dd/yyyy'), to_char(last_change_date, 'mm/dd/yyyy')
			ORDER BY group_id, posting_date, prod_name;

			IF (cur_out01 IS null) THEN
				cur_out01 := cur_temp10;
			elsif (cur_out02 IS null) THEN
				cur_out02 := cur_temp10;
			elsif (cur_out03 IS null) THEN
				cur_out03 := cur_temp10;
			elsif (cur_out04 IS null) THEN
				cur_out04 := cur_temp10;
			elsif (cur_out05 IS null) THEN
				cur_out05 := cur_temp10;
			elsif (cur_out06 IS null) THEN
				cur_out06 := cur_temp10;
			elsif (cur_out07 IS null) THEN
				cur_out07 := cur_temp10;
			elsif (cur_out08 IS null) THEN
				cur_out08 := cur_temp10;
			elsif (cur_out09 IS null) THEN
				cur_out09 := cur_temp10;
			elsif (cur_out10 IS null) THEN
				cur_out10 := cur_temp10;
			elsif (cur_out11 IS null) THEN
				cur_out11 := cur_temp10;
			elsif (cur_out12 IS null) THEN
				cur_out12 := cur_temp10;
			elsif (cur_out13 IS null) THEN
				cur_out13 := cur_temp10;
			elsif (cur_out14 IS null) THEN
				cur_out14 := cur_temp10;
			ELSE
				cur_out14 := cur_temp10;
			END IF;

			OPEN cur_temp11 for
			SELECT    sum(yalo.quantity) AS items,
				sum(yalo.unit_price * yalo.quantity) AS price
			FROM
				(SELECT order_date, last_change_date, sku, nvl(quantity, 0) AS quantity, nvl(unit_price, 0) AS unit_price, credit_status
				 FROM
					(SELECT *
					FROM ya_associate_link_orders
					WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
					) ya_associate_link_orders
				WHERE (ya_associate_link_orders.order_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
			                                  (ya_associate_link_orders.order_date <  to_date(cEndDate, 'mm/dd/yyyy')) AND
			                 	               (credit_status =1) AND (link_id = iLinkId) AND (unit_price > 0)
				) yalo
			GROUP BY to_number(to_char(order_date, 'fmmm'));

			IF (cur_out01 IS null) THEN
				cur_out01 := cur_temp11;
			elsif (cur_out02 IS null) THEN
				cur_out02 := cur_temp11;
			elsif (cur_out03 IS null) THEN
				cur_out03 := cur_temp11;
			elsif (cur_out04 IS null) THEN
				cur_out04 := cur_temp11;
			elsif (cur_out05 IS null) THEN
				cur_out05 := cur_temp11;
			elsif (cur_out06 IS null) THEN
				cur_out06 := cur_temp11;
			elsif (cur_out07 IS null) THEN
				cur_out07 := cur_temp11;
			elsif (cur_out08 IS null) THEN
				cur_out08 := cur_temp11;
			elsif (cur_out09 IS null) THEN
				cur_out09 := cur_temp11;
			elsif (cur_out10 IS null) THEN
				cur_out10 := cur_temp11;
			elsif (cur_out11 IS null) THEN
				cur_out11 := cur_temp11;
			elsif (cur_out12 IS null) THEN
				cur_out12 := cur_temp11;
			elsif (cur_out13 IS null) THEN
				cur_out13 := cur_temp11;
			elsif (cur_out14 IS null) THEN
				cur_out14 := cur_temp11;
			ELSE
				cur_out14 := cur_temp11;
			END IF;
		END IF;
	END IF;

	IF (cStartDate < cCutOffDate) THEN
		OPEN cur_temp12 for
		SELECT    sum(yalo.quantity) AS items,
			sum(yalo.unit_price * yalo.quantity) AS price,
			to_number(to_char(order_date, 'fmmm')) AS posting_month,
			to_number(to_char(order_date, 'yyyy')) AS posting_year,
			(SELECT link_percentage FROM ya_associate_link WHERE associate_id=iAssociateId AND rownum=1 ) AS percentage,
			--sum(yalo.unit_price * yalo.quantity) * (SELECT link_percentage FROM ya_associate_link WHERE associate_id=iAssociateId AND rownum=1) AS commission
			sum(nvl(yalo.credit_amount, yalo.unit_price * yalo.quantity* nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = 8050 AND rownum=1))))) AS commission
		FROM
			(SELECT order_date, last_change_date, sku, nvl(quantity, 0) AS quantity, nvl(unit_price, 0) AS unit_price, credit_status, credit_amount
			FROM
				(SELECT *
				FROM ya_associate_link_orders
				WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) ya_associate_link_orders
			WHERE (ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
				(ya_associate_link_orders.last_change_date < to_date(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (link_id = iLinkId) AND (unit_price > 0)
			) yalo
		LEFT OUTER JOIN ya_associate_commission_hist yach on yach.associate_id = iAssociateId
			AND yach.valid_date = to_date(to_char(order_date, 'mm') || '/01/' || to_char(order_date, 'yyyy'), 'mm/dd/yyyy'),
			(SELECT percentage  FROM ya_associate_commission_detail cd INNER JOIN
			(SELECT comm_type_id, nc_max FROM ya_associate_commission_type ct WHERE ((nc_min <= iCustomer AND nc_max >= iCustomer) OR nc_max < iCustomer)) ct
			ON ct.comm_type_id =cd.comm_type_id
			INNER JOIN
				(SELECT commission_id, payment_option
				FROM ya_associate
				WHERE associate_id=iAssociateId
				) ya
			ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
         WHERE rownum=1
			)t
		GROUP BY to_number(to_char(order_date, 'fmmm')), to_number(to_char(order_date, 'yyyy')) , comm_rate, t.percentage;

		IF (cur_out01 IS null) THEN
			cur_out01 := cur_temp12;
		elsif (cur_out02 IS null) THEN
			cur_out02 := cur_temp12;
		elsif (cur_out03 IS null) THEN
			cur_out03 := cur_temp12;
		elsif (cur_out04 IS null) THEN
			cur_out04 := cur_temp12;
		elsif (cur_out05 IS null) THEN
			cur_out05 := cur_temp12;
		elsif (cur_out06 IS null) THEN
			cur_out06 := cur_temp12;
		elsif (cur_out07 IS null) THEN
			cur_out07 := cur_temp12;
		elsif (cur_out08 IS null) THEN
			cur_out08 := cur_temp12;
		elsif (cur_out09 IS null) THEN
			cur_out09 := cur_temp12;
		elsif (cur_out10 IS null) THEN
			cur_out10 := cur_temp12;
		elsif (cur_out11 IS null) THEN
			cur_out11 := cur_temp12;
		elsif (cur_out12 IS null) THEN
			cur_out12 := cur_temp12;
		elsif (cur_out13 IS null) THEN
			cur_out13 := cur_temp12;
		elsif (cur_out14 IS null) THEN
			cur_out14 := cur_temp12;
		ELSE
			cur_out14 := cur_temp12;
		END IF;
	ELSE
		OPEN cur_temp13 for
		SELECT    sum(yalo.quantity) AS items,
			sum(yalo.unit_price * yalo.quantity) AS price,
			to_number(to_char(order_date, 'fmmm')) AS posting_month,
			to_number(to_char(order_date, 'yyyy')) AS posting_year,
			nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = iAssociateId AND rownum=1))) AS percentage,
			sum(yalo.unit_price * yalo.quantity) * nvl(comm_rate, nvl(percentage, (SELECT comm_rate FROM ya_associate_commission_hist WHERE associate_id = iAssociateId AND rownum=1 )))  AS commission
		FROM
			(SELECT order_date, last_change_date, sku, nvl(quantity, 0) AS quantity, nvl(unit_price, 0) AS unit_price, credit_status, credit_amount
			FROM
				(SELECT *
				FROM ya_associate_link_orders
				WHERE sku not IN (1001819827,1001819829,1001819831,1001819833,1001819834,1001819836)
				) ya_associate_link_orders
			WHERE (ya_associate_link_orders.last_change_date >= to_date(cStartDate, 'mm/dd/yyyy')) AND
				(ya_associate_link_orders.last_change_date < to_date(cEndDate, 'mm/dd/yyyy')) AND
				(credit_status = 2) AND (link_id = iLinkId) AND (unit_price > 0)
			) yalo
			LEFT OUTER JOIN ya_associate_commission_hist yach on yach.associate_id = iAssociateId
				AND yach.valid_date = to_date(to_char(order_date, 'mm') || '/01/' || to_char(order_date, 'yyyy'), 'mm/dd/yyyy'),
				(SELECT percentage  FROM ya_associate_commission_detail cd INNER JOIN
				(SELECT comm_type_id, nc_max FROM ya_associate_commission_type ct WHERE ((nc_min <= iCustomer AND nc_max >= iCustomer) OR nc_max < iCustomer)) ct
				ON ct.comm_type_id =cd.comm_type_id
				INNER JOIN
					(SELECT commission_id, payment_option
					FROM ya_associate
					WHERE associate_id=iAssociateId
					) ya
			ON cd.commission_id = ya.commission_id AND cd.payment_option = ya.payment_option
			)t
		GROUP BY to_number(to_char(order_date, 'fmmm')), to_number(to_char(order_date, 'yyyy')), comm_rate, t.percentage;

		IF (cur_out01 IS null) THEN
			cur_out01 := cur_temp13;
		elsif (cur_out02 IS null) THEN
			cur_out02 := cur_temp13;
		elsif (cur_out03 IS null) THEN
			cur_out03 := cur_temp13;
		elsif (cur_out04 IS null) THEN
			cur_out04 := cur_temp13;
		elsif (cur_out05 IS null) THEN
			cur_out05 := cur_temp13;
		elsif (cur_out06 IS null) THEN
			cur_out06 := cur_temp13;
		elsif (cur_out07 IS null) THEN
			cur_out07 := cur_temp13;
		elsif (cur_out08 IS null) THEN
			cur_out08 := cur_temp13;
		elsif (cur_out09 IS null) THEN
			cur_out09 := cur_temp13;
		elsif (cur_out10 IS null) THEN
			cur_out10 := cur_temp13;
		elsif (cur_out11 IS null) THEN
			cur_out11 := cur_temp13;
		elsif (cur_out12 IS null) THEN
			cur_out12 := cur_temp13;
		elsif (cur_out13 IS null) THEN
			cur_out13 := cur_temp13;
		elsif (cur_out14 IS null) THEN
			cur_out14 := cur_temp13;
		ELSE
			cur_out14 := cur_temp13;
		END IF;
	END IF;
END IF;

OPEN cur_temp14 for
SELECT link_id, '<B>' || site_name || '</B> (' || link_code || ')' AS site_name FROM ya_associate_link WHERE associate_id = iAssociateId;
IF (cur_out01 IS null) THEN
	cur_out01 := cur_temp14;
elsif (cur_out02 IS null) THEN
	cur_out02 := cur_temp14;
elsif (cur_out03 IS null) THEN
	cur_out03 := cur_temp14;
elsif (cur_out04 IS null) THEN
	cur_out04 := cur_temp14;
elsif (cur_out05 IS null) THEN
	cur_out05 := cur_temp14;
elsif (cur_out06 IS null) THEN
	cur_out06 := cur_temp14;
elsif (cur_out07 IS null) THEN
	cur_out07 := cur_temp14;
elsif (cur_out08 IS null) THEN
	cur_out08 := cur_temp14;
elsif (cur_out09 IS null) THEN
	cur_out09 := cur_temp14;
elsif (cur_out10 IS null) THEN
	cur_out10 := cur_temp14;
elsif (cur_out11 IS null) THEN
	cur_out11 := cur_temp14;
elsif (cur_out12 IS null) THEN
	cur_out12 := cur_temp14;
elsif (cur_out13 IS null) THEN
	cur_out13 := cur_temp14;
elsif (cur_out14 IS null) THEN
	cur_out14 := cur_temp14;
ELSE
	cur_out14 := cur_temp14;
END IF;
SELECT nvl(lang_id, 1) INTO iLangId FROM ya_associate_link WHERE associate_id = iAssociateId AND rownum=1;


IF (cur_out01 IS null) THEN
	OPEN cur_out01 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out02 IS null) THEN
	OPEN cur_out02 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out03 IS null) THEN
	OPEN cur_out03 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out04 IS null) THEN
	OPEN cur_out04 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out05 IS null) THEN
	OPEN cur_out05 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out06 IS null) THEN
	OPEN cur_out06 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out07 IS null) THEN
	OPEN cur_out07 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out08 IS null) THEN
	OPEN cur_out08 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out09 IS null) THEN
	OPEN cur_out09 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out10 IS null) THEN
	OPEN cur_out10 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out11 IS null) THEN
	OPEN cur_out11 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out12 IS null) THEN
	OPEN cur_out12 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out13 IS null) THEN
	OPEN cur_out13 for
	SELECT 'null_cursor' FROM dual;
END IF;
IF (cur_out14 IS null) THEN
	OPEN cur_out14 for
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
    l.location as location,
    l.priority as priority
  FROM
    ya_cm_creative c,
    ya_cm_creative_location l
  WHERE
    l.file_id = iPpageId
    AND l.site_id = iPsiteId
    AND c.TYPE = 1
    AND c.status <> 3
    AND c.enable = 'Y'
    AND c.creative_id = l.creative_id
  ORDER BY location,priority;

  OPEN curPout_2 FOR
  SELECT
    l.creative_id AS creative_id,
    l.location as location,
    l.priority as priority
  FROM
    ya_cm_creative c,
    ya_cm_creative_location l
  WHERE
    l.file_id = iPpageId
    AND l.site_id = iPsiteId
    AND c.TYPE IN (2, 3)
    AND c.status <> 3
    AND c.enable = 'Y'
    AND c.creative_id = l.creative_id
  ORDER BY location,priority;
  IF (curPout_1 IS null) THEN
    curPout_1 := curPout_2;
  END IF;

  OPEN curPout_3 FOR
  SELECT
    l.prod_lot_id AS prod_lot_id,
    l.lot_location AS location,
    l.priority AS priority
  FROM
    ya_product_lot l
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

  IF (curPout_1 IS null) THEN
  	OPEN curPout_1 for
	  SELECT 'null_cursor' FROM dual;
  END IF;
  IF (curPout_2 IS null) THEN
    OPEN curPout_2 for
    SELECT 'null_cursor' FROM dual;
  END IF;
  IF (curPout_3 IS null) THEN
    OPEN curPout_3 for
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
    ya_cm_creative c,
    ya_cm_creative_text_lang ctl
  WHERE
    ctl.lang_id = iPlangId
    AND c.creative_id = iPcreativeId
    AND c.creative_id = ctl.creative_id
    AND c.enable='Y'
    AND type = 1
    AND c.status<> 3;
  IF (curPout_1 IS null) THEN
    OPEN curPout_1 for
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
    c.type AS TYPE
  FROM
    ya_cm_creative c,
    ya_cm_creative_button_lang cbl
  WHERE
    cbl.lang_id = iPlangId
    AND c.creative_id = iPcreativeId
    AND c.creative_id = cbl.creative_id
    AND c.enable='Y'
    AND c.type in (2,3)
    AND c.status<> 3;
  IF (curPout_1 IS null) THEN
    OPEN curPout_1 for
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
  FROM ya_product_lot pl
  WHERE
    pl.prod_lot_id = iPproductLotId;
  IF (curPout_1 IS null) THEN
    OPEN curPout_1 for
    SELECT 'null_cursor' FROM dual;
  END IF;
END sp_fe_asso_getProductLot;

END Pkg_fe_asso;
/

