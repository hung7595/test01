CREATE OR REPLACE PACKAGE Pkg_fe_LogAccess
AS

  PROCEDURE InsertSearchKeywordData (
    iPsite_id		IN	INT,
    cPshopper_id	IN	CHAR,
    cPsearch_section	IN	VARCHAR2,
    ncPkeyword		IN	VARCHAR2
  );

  PROCEDURE InsertMonitorLog (
    cPmonitor_id	IN	VARCHAR2,
    cPreferrer_link	IN	VARCHAR2,
    cPshopper_id	IN	CHAR
  );

  PROCEDURE InsertCmsCreativeMonitorLog(
    cPtrackingType IN VARCHAR2,
    cPcreativeTypeKey IN VARCHAR2,
    cPcreativeGroupIdKey IN VARCHAR2,
    cPcreativeType IN VARCHAR2,
    cPcreativeGroupId IN VARCHAR2,
    iPid IN OUT INT
  );

  PROCEDURE InsertCrossSellingMonitorLog(
    cPtrackingType IN VARCHAR2,
    cPmainSkuKey IN VARCHAR2,
    cPcrossSellingSkuKey IN VARCHAR2,
    cPmainSku IN VARCHAR2,
    cPcrossSellingSku IN VARCHAR2,
    iPid IN OUT INT,
    cPsiteKey IN VARCHAR2,
    cPsiteId IN VARCHAR2
  );

  PROCEDURE InsertConversionRate(
    cPtrackingType IN VARCHAR2,
    cPmonitorKey IN VARCHAR2,
    iPorderNum IN INT
  );
END Pkg_fe_LogAccess;
/

CREATE OR REPLACE PACKAGE BODY Pkg_fe_LogAccess
IS

/* InsertSearchKeywordData */
  PROCEDURE InsertSearchKeywordData (
    iPsite_id		IN	INT,
    cPshopper_id	IN	CHAR,
    cPsearch_section	IN	VARCHAR2,
    ncPkeyword		IN	VARCHAR2
    )
AS
BEGIN
  INSERT INTO ya_search_keyword_log (
    site_id,
    shopper_id,
    search_section,
    keyword,
    UNIQUE_ID,
    SEARCH_DATETIME
    )
  VALUES (
    iPsite_id,
    cPshopper_id,
    cPsearch_section,
    ncPkeyword,
    SYS_GUID(),
    SYSDATE
    );
  COMMIT;
END InsertSearchKeywordData;

/* proc_fe_insert_monitor_log */
  PROCEDURE InsertMonitorLog (
    cPmonitor_id	IN	VARCHAR2,
    cPreferrer_link	IN	VARCHAR2,
    cPshopper_id	IN	CHAR
    )
AS
BEGIN
  INSERT INTO ya_monitor_log
  (
  	monitor_id,
  	referrer_link,
  	transaction_datetime,
  	shopper_id,
  	rowguid
  )
  values
  (
  	cPmonitor_id,
  	cPreferrer_link,
  	SYSDATE,
  	cPshopper_id,
  	SYS_GUID()
  );
  COMMIT;
END InsertMonitorLog;

PROCEDURE InsertCmsCreativeMonitorLog(
    cPtrackingType IN VARCHAR2,
    cPcreativeTypeKey IN VARCHAR2,
    cPcreativeGroupIdKey IN VARCHAR2,
    cPcreativeType IN VARCHAR2,
    cPcreativeGroupId IN VARCHAR2,
    iPid IN OUT INT
  )
AS
  dtLtoDay DATE;
  iLseq_currval INT;
  iLseq_diff INT;
BEGIN
  dtLtoDay := SYSDATE;

  IF iPid IS NULL OR iPid < 0 THEN
    SELECT SEQ_LINK_MONITOR.nextval INTO iPid FROM DUAL;
  ELSE
    SELECT SEQ_LINK_MONITOR.nextval INTO iLseq_currval FROM dual;
    iLseq_diff := iPid - iLseq_currval;
    IF iLseq_diff <> 0 THEN
      EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_LINK_MONITOR INCREMENT BY ' || iLseq_diff;
      SELECT SEQ_LINK_MONITOR.nextval INTO iLseq_currval FROM dual;
      EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_LINK_MONITOR INCREMENT BY 1';
    END IF;
  END IF;
  INSERT INTO ya_link_tracking_log
    (rec_id, tracking_type, created_datetime)
  VALUES
    (iPid, cPtrackingType, dtLtoDay);

  INSERT INTO ya_link_tracking
    (rec_id, data_type, data_value)
  VALUES
    (iPid, cPcreativeTypeKey, cPcreativeType);

  INSERT INTO ya_link_tracking
    (rec_id, data_type, data_value)
  VALUES
    (iPid, cPcreativeGroupIdKey, cPcreativeGroupId);

  COMMIT;
  -- throw exceptions when errors have been encountered.
END InsertCmsCreativeMonitorLog;


  PROCEDURE InsertCrossSellingMonitorLog(
    cPtrackingType IN VARCHAR2,
    cPmainSkuKey IN VARCHAR2,
    cPcrossSellingSkuKey IN VARCHAR2,
    cPmainSku IN VARCHAR2,
    cPcrossSellingSku IN VARCHAR2,
    iPid IN OUT INT,
    cPsiteKey IN VARCHAR2,
    cPsiteId IN VARCHAR2
  )
AS
  dtLtoDay DATE;
  iLseq_currval INT;
  iLseq_diff INT;
BEGIN
  dtLtoDay := SYSDATE;

  IF iPid IS NULL OR iPid < 0 THEN
    SELECT SEQ_LINK_MONITOR.nextval INTO iPid FROM DUAL;
  ELSE
    SELECT SEQ_LINK_MONITOR.nextval INTO iLseq_currval FROM dual;
    iLseq_diff := iPid - iLseq_currval;
    IF iLseq_diff <> 0 THEN
      EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_LINK_MONITOR INCREMENT BY ' || iLseq_diff;
      SELECT SEQ_LINK_MONITOR.nextval INTO iLseq_currval FROM dual;
      EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_LINK_MONITOR INCREMENT BY 1';
    END IF;
  END IF;
  INSERT INTO ya_link_tracking_log
    (rec_id, tracking_type, created_datetime)
  VALUES
    (iPid, cPtrackingType, dtLtoDay);

  INSERT INTO ya_link_tracking
    (rec_id, data_type, data_value)
  VALUES
    (iPid, cPmainSkuKey, cPmainSku);

  INSERT INTO ya_link_tracking
    (rec_id, data_type, data_value)
  VALUES
    (iPid, cPcrossSellingSkuKey, cPcrossSellingSku);

  INSERT INTO ya_link_tracking
    (rec_id, data_type, data_value)
  VALUES
    (iPid, cPsiteKey, cPsiteId);
  COMMIT;
  -- throw exceptions when errors have been encountered.
END InsertCrossSellingMonitorLog;

  PROCEDURE InsertConversionRate(
    cPtrackingType IN VARCHAR2,
    cPmonitorKey IN VARCHAR2,
    iPorderNum IN INT
  )
AS
BEGIN
  INSERT INTO ya_cross_sell_conversion
  (tracking_type, monitor_key, order_num, created_datetime)
  VALUES
  (cPtrackingType, cPmonitorKey, iPorderNum, SYSDATE);
  COMMIT;
END InsertConversionRate;


END Pkg_fe_LogAccess;
/

