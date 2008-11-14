CREATE OR REPLACE PACKAGE CRON_FE_UPDATEBARGAINFPH_V5
AS
  TYPE refCur IS ref CURSOR;

	PROCEDURE cron_fe_updateBargainFPH;
  
  PROCEDURE updateBargainFPH
	(
    iPfileId IN INT,
    iPsiteId IN INT,
    iPdeptId IN INT,
    iPlot_startLocation IN INT,
    iProwNum IN INT,
    iPdept_preferred IN INT
	);
END CRON_FE_UPDATEBARGAINFPH_V5;
/


CREATE OR REPLACE PACKAGE BODY CRON_FE_UPDATEBARGAINFPH_V5
IS
  PROCEDURE cron_fe_updateBargainFPH
  AS
  BEGIN
    
  -- V5 - Movies and Videos - All Chinese -> 106
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,106,101,1,106); --US
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,106,101,1,106); --GB
  
  -- V5 - Movies and Videos - Japan -> 6918
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,6918,102,1,6918); --US
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,6918,102,1,6918); --GB
  
  -- V5 - Movies and Videos - Korea -> 295
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,295,103,1,295); --US
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,295,103,1,295); --GB
  
  -- V5 - Movies and Videos - Western -> 8648
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,8648,104,1,8648); --US
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,8648,104,1,8648); --GB
  
  -- V5 - Music - All Chinese -> 83
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,83,105,1,83); --US
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,83,105,1,83); --GB
  
  -- V5 - Music - Japanese -> 97
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,97,106,1,97); --US
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,97,106,1,97); --GB
  
  -- V5 - Music - Korean -> 91
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,91,107,1,91); --US
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,91,107,1,91); --GB
  
  -- V5 - Concerts and MVs - All Chinese -> 163
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,163,108,1,163); --US
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,163,108,1,163); --GB
  
  -- V5 - Games - All -> 5
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,5,109,1,5); --US
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,5,109,1,5); --GB
  
  -- V5 - Toys - All -> 7153
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,7153,110,1,7153); --US
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,7153,110,1,7153); --GB
  
  -- V5 - Books - In Chinese -> 3591
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,3591,111,1,3591); --US
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,3591,111,1,3591); --GB
  
  -- V5 - Comics - In Chinese -> 2980
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,2980,112,1,2980); --US
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,2980,112,1,2980); --GB
  
  -- V5 - TV - All Chinese -> 157
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,157,113,1,157); --US
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,157,113,1,157); --GB
  
  -- V5 - TV - Japan -> 179
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,179,114,1,179); --US
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,179,114,1,179); --GB
  
  -- V5 - TV - Korea -> 2957
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,2957,115,1,2957); --US
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,2957,115,1,2957); --GB
  
  -- V5 - TV - Western -> 10961
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,1,10961,116,1,10961); --US
  Cron_fe_updateBargainFPH_v5.updateBargainFPH(234626,7,10961,116,1,10961); --GB

  END cron_fe_updateBargainFPH;

	PROCEDURE updateBargainFPH
	(
    iPfileId IN INT,
    iPsiteId IN INT,
    iPdeptId IN INT,
    iPlot_startLocation IN INT,
    iProwNum IN INT,
    iPdept_preferred IN INT
	)
	AS
    iLsku INT;
    iLsku_Count INT;
    iLnew_ProdlotId INT;
    iLcurr_lotLocation INT;   
    curP_productSku refCur;
  BEGIN
    OPEN curP_productSku FOR
    SELECT sku
    FROM
    (
      SELECT sku
      FROM
      (
        SELECT sku
        FROM
        (
          --Only randomize from the top 50 highest rank of product line
          SELECT
          bp.sku AS sku
          FROM
          ya_bargain_product bp
          INNER JOIN
          ya_prod_dept pd ON bp.sku = pd.sku
          INNER JOIN
          backend_adm.prod_region pr ON bp.sku = pr.prod_id AND pr.region_id = iPsiteId AND pr.is_enabled = 'Y'    
          INNER JOIN
          backend_adm.prod_avlb pa ON bp.sku = pa.prod_id AND pa.region_id = pr.region_id AND pa.avlb < 60
          INNER JOIN
          ya_prod_score score ON score.sku=bp.sku AND score.siteid = iPsiteId
          WHERE
          bp.sale_start <= sysdate
          AND bp.sale_end >=  sysdate
          AND bp.discount > 0
          AND bp.discount < 1
          AND pd.dept_id = iPdeptId
          AND bp.site_id = iPsiteId
          AND bp.sku NOT IN (SELECT ad.sku FROM ya_adult_product ad)
          ORDER BY score.rank DESC
        )
        WHERE ROWNUM < 51
      )
      ORDER BY dbms_random.value
    )
    WHERE ROWNUM < 2;
    
    DELETE 
    FROM ya_product_lot 
    WHERE file_id = iPfileId 
    AND 
    (
      (lot_location >= iPlot_startLocation) 
      AND 
      (lot_location < (iPlot_startLocation + iProwNum))
    );
    
    DELETE 
    FROM ya_mirror_product_lot 
    WHERE file_id = iPfileId 
    AND 
    (
      (lot_location >= iPlot_startLocation) 
      AND 
      (lot_location < (iPlot_startLocation + iProwNum))
    ); 
    
    BEGIN
      iLcurr_lotLocation := iPlot_startLocation;
      iLsku_Count := 0;
      
      FETCH curP_productSku INTO iLsku;
      WHILE (curP_productSku%FOUND)
      LOOP
          INSERT INTO ya_mirror_product_lot
          (file_id, lot_location, sku, dept_id, active, priority, updated_user, updated_date)    
          VALUES 
          (iPfileId, iLcurr_lotLocation, iLsku, iPdept_preferred, 'Y', iLsku_Count, 'Corn Bargain FP v5', sysdate);
          
          SELECT seq_ya_mirror_product_lot.nextval into iLnew_ProdlotId from dual;
          
          INSERT INTO ya_product_lot
          (prod_lot_id, file_id, lot_location, sku, dept_id, active, priority, updated_user, updated_date)
          VALUES 
          (iLnew_ProdlotId, iPfileId, iLcurr_lotLocation, iLsku, iPdept_preferred, 'Y', iLsku_Count, 'Corn Bargain FP v5', sysdate);
          
          FETCH curP_productSku INTO iLsku;
					iLsku_Count := iLsku_Count + 1;
					iLcurr_lotLocation := iLcurr_lotLocation + 1;
      END LOOP;
      CLOSE curP_productSku;
    END;
    
    IF SQLCODE = 0 THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END updateBargainFPH;

END CRON_FE_UPDATEBARGAINFPH_V5;
/