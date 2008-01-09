CREATE OR REPLACE PACKAGE Pkg_FE_CampaignMgtAccess
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetRevenueAccount (
	curPresult1 out refCur
  );
  PROCEDURE ImportCampaign (
    cSKUCsv IN VARCHAR2,
	iCampaignCode IN INT,
	iProw_affacted OUT INT
  );
  PROCEDURE RemoveCampaign (
    cSKUCsv IN VARCHAR2,
	iCampaignCode IN INT,
	iProw_affacted OUT INT
  );
  PROCEDURE GetCampaignDescription (
	iCampaignCode IN INT,
	curPresult1 out refCur
  );
  PROCEDURE GetCampaignProdInfo (
	iStartRow IN INT,
	iEndRow IN INT,
	iCampaignCode IN INT,
	curPresult1 out refCur
  );
  PROCEDURE GetCampaignProdInfoPage (
	iCampaignCode IN INT,
	iPcountRow OUT INT
  );
  PROCEDURE CreateCampaign (
    cSKUList IN VARCHAR2,
	iCampaignCode IN INT,
	iProw_affacted OUT INT
  );
  PROCEDURE RemoveCampaignBySku (
    iSKU IN INT,
	iCampaignCode IN INT,
	iProw_affacted OUT INT
  );
  END Pkg_FE_CampaignMgtAccess;

/


CREATE OR REPLACE PACKAGE BODY Pkg_FE_CampaignMgtAccess
IS
  PROCEDURE GetRevenueAccount (
	curPresult1 out refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
		select g.account_id as account_id, l.meaning as meaning
		from ya_group g
		inner join ya_lookup l on g.account_id = l.code_id and l.type_id = 45
		where division_id = 10 and group_id = 3
		order by account_id;
	RETURN;
  END GetRevenueAccount;

  PROCEDURE ImportCampaign (
    cSKUCsv IN VARCHAR2,
	iCampaignCode IN INT,
	iProw_affacted OUT INT
  )
  AS
	sLSQL1 VARCHAR2(500);
	sLSQL2 VARCHAR2(400);
  BEGIN
	sLSQL1 := 'INSERT INTO ya_campaign (campaign_code, sku, campaign_datetime, created_datetime)
          SELECT '|| iCampaignCode || ', sku, sysdate, sysdate FROM ya_product, dual WHERE sku in (' || cSKUCsv || ') AND sku not in (SELECT sku FROM ya_campaign WHERE campaign_code = '|| iCampaignCode || ')';
		  dbms_output.put_line(sLSQL1);
	EXECUTE IMMEDIATE sLSQL1;
	--INSERT INTO ya_campaign (campaign_code, sku, campaign_datetime, created_datetime)
          --SELECT iCampaignCode, sku, dtLcurrDate, dtLcurrDate FROM ya_product WHERE sku in (cSKUCsv)
          --AND sku not in (SELECT sku FROM ya_campaign WHERE campaign_code = iCampaignCode);
	sLSQL2 := 'INSERT INTO ya_campaign_history (campaign_code, sku, action_type_id, action_datetime)
          SELECT '|| iCampaignCode || ', sku, 1, sysdate FROM ya_product,dual WHERE sku in (' || cSKUCsv || ')';
		  dbms_output.put_line(sLSQL2);
	EXECUTE IMMEDIATE sLSQL2;
	--INSERT INTO ya_campaign_history (campaign_code, sku, action_type_id, action_datetime)
          --SELECT iCampaignCode, sku, 1, dtLcurrDate FROM ya_product WHERE sku in (cSKUCsv);

    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
  END ImportCampaign;

  PROCEDURE RemoveCampaign (
    cSKUCsv IN VARCHAR2,
	iCampaignCode IN INT,
	iProw_affacted OUT INT
  )
  AS
	sLSQL1 VARCHAR2(500);
	sLSQL2 VARCHAR2(400);
  BEGIN
	sLSQL1 := 'DELETE FROM ya_campaign WHERE campaign_code = ' || iCampaignCode || ' AND sku in (' || cSKUCsv || ')';
		  dbms_output.put_line(sLSQL1);
	EXECUTE IMMEDIATE sLSQL1;
	--DELETE FROM ya_campaign WHERE campaign_code = iCampaignCode AND sku in (cSKUCsv);
	sLSQL2 := 'INSERT INTO ya_campaign_history (campaign_code, sku, action_type_id, action_datetime)
           SELECT '|| iCampaignCode || ', sku, 2, sysdate FROM ya_product, dual WHERE sku in ('|| cSKUCsv || ')';
		  dbms_output.put_line(sLSQL2);
	EXECUTE IMMEDIATE sLSQL2;
	--INSERT INTO ya_campaign_history (campaign_code, sku, action_type_id, action_datetime)
           --SELECT iCampaignCode, sku, 2, dtLcurrDate FROM ya_product WHERE sku in (cSKUCsv);

    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
  END RemoveCampaign;

  PROCEDURE GetCampaignDescription (
	iCampaignCode IN INT,
	curPresult1 out refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
		SELECT campaing_description FROM ya_campaign_lookup WHERE campaign_code = iCampaignCode;
	RETURN;
  END GetCampaignDescription;

  PROCEDURE GetCampaignProdInfo (
	iStartRow IN INT,
	iEndRow IN INT,
	iCampaignCode IN INT,
	curPresult1 out refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
		SELECT p.sku as sku, pl.prod_name as ename, pc.prod_name as cname
FROM (SELECT * FROM (select c.*, rownum as rnum from ya_campaign c where c.campaign_code = iCampaignCode and rownum <= iEndRow) where rnum > iStartRow) c
INNER JOIN ya_product p ON p.sku = c.sku 
INNER JOIN ya_prod_lang pl ON p.sku = pl.sku AND pl.lang_id = 1
INNER JOIN ya_prod_lang pc ON p.sku = pc.sku AND pc.lang_id = 2
ORDER BY p.sku;
	RETURN;
  END GetCampaignProdInfo;

  PROCEDURE GetCampaignProdInfoPage (
	iCampaignCode IN INT,
	iPcountRow OUT INT
  )
  AS
  BEGIN
	SELECT count(*) into iPcountRow
	      FROM (SELECT * FROM ya_campaign c WHERE c.campaign_code =  iCampaignCode) c
              INNER JOIN ya_product p ON p.sku = c.sku
	      INNER JOIN ya_prod_lang pl ON p.sku = pl.sku AND pl.lang_id = 1
	      INNER JOIN ya_prod_lang pc ON p.sku = pc.sku AND pc.lang_id = 2
	      ORDER BY p.sku;
	RETURN;
  END GetCampaignProdInfoPage;
  PROCEDURE CreateCampaign (
    cSKUList IN VARCHAR2,
	iCampaignCode IN INT,
	iProw_affacted OUT INT
  )
  AS
    dtLcurrDate VARCHAR2(50);
	sLSQL1 VARCHAR2(500);
	sLSQL2 VARCHAR2(400);
	sLSQL3 VARCHAR2(400);

  BEGIN
    SELECT TO_CHAR(SYSDATE, 'DD-MON-YYYY HH:MI:SS') INTO dtLcurrDate FROM DUAL;

	sLSQL1 := 'INSERT INTO ya_campaign (campaign_code, sku, campaign_datetime, created_datetime)' ||
        'SELECT ' || iCampaignCode || ', sku,  sysdate, sysdate FROM ya_product, dual WHERE sku in (' ||
		cSKUList || ') AND sku not in (SELECT sku FROM ya_campaign WHERE campaign_code = ' || iCampaignCode || ')';
	--Need to remove sku from 135 once it is in 133
	EXECUTE IMMEDIATE sLSQL1;

	If iCampaignCode = 133 Then
		sLSQL2 := 'DELETE FROM ya_campaign ' || 'WHERE campaign_code = 135 ' || 'AND sku in (' || cSKUList || ')';
		EXECUTE IMMEDIATE sLSQL2;
	END IF;
	sLSQL3 := 'INSERT INTO ' || 'ya_campaign_history ' || '(campaign_code, sku, ' || 'action_type_id,' || ' action_datetime) SELECT ' ||	iCampaignCode || ' , sku, 1, sysdate FROM ya_product, dual' || ' WHERE sku in (' || cSKUList || ')';
	EXECUTE IMMEDIATE sLSQL3;
    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END CreateCampaign;

  PROCEDURE RemoveCampaignBySku (
    iSKU IN INT,
	iCampaignCode IN INT,
	iProw_affacted OUT INT
  )
  AS
    dtLcurrDate DATE;
  BEGIN
    SELECT SYSDATE INTO dtLcurrDate FROM DUAL;
	DELETE FROM ya_campaign WHERE sku = iSKU and campaign_code = iCampaignCode;
	INSERT INTO ya_campaign_history (campaign_code, sku, action_type_id, action_datetime)
        VALUES (iCampaignCode , iSKU , 2, dtLcurrDate);

    IF sqlcode = 0 THEN
		iProw_affacted := SQL%ROWCOUNT;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
	RETURN;
  END RemoveCampaignBySku;

END Pkg_FE_CampaignMgtAccess;

/
