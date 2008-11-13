CREATE OR REPLACE PACKAGE cron_fe_updateBargainFPH_v5
AS
  TYPE refCur IS REF CURSOR;
	
	PROCEDURE cron_fe_updateBargainFPH
	(
    iPfileId IN INT,
    iPsiteId IN INT,
    iPdeptId IN INT,
    iPlot_startLocation IN INT,
    iProwNum IN INT,
    iPdept_preferred IN INT
	);

END cron_fe_updateBargainFPH_v5;
/

CREATE OR REPLACE PACKAGE BODY cron_fe_updateBargainFPH_v5
IS
	
	PROCEDURE cron_fe_updateBargainFPH
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
      END LOOP;
      CLOSE curP_productSku;
    END;
    
    IF SQLCODE = 0 THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END cron_fe_updateBargainFPH;
	
END cron_fe_updateBargainFPH_v5;
/