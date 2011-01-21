CREATE OR REPLACE PACKAGE Pkg_Fe_ToySectPublisherDept
AS
  PROCEDURE cron_fe_updatePublisherArtist (
    iPdept_id IN VARCHAR2
  );
  
END Pkg_Fe_ToySectPublisherDept;
/


CREATE OR REPLACE PACKAGE BODY Pkg_Fe_ToySectPublisherDept
IS
 PROCEDURE cron_fe_updatePublisherArtist (
    iPdept_id IN VARCHAR2
  )

 AS
 BEGIN
	INSERT INTO tmp_updatePublisherArtist 
	  (
	    publisher_id,
	    dept_id
	  )
	SELECT p.publisher_id, pa.artist_id FROM ya_product p
	  INNER JOIN ya_product_artist pa
	    ON p.sku = pa.sku
	  INNER JOIN ya_prod_dept pd
	    ON pd.sku = p.sku
	  INNER JOIN ya_browse_dept_path c
	    ON pd.dept_id = c.terminal_dept_id AND c.dept_id = 7153
	  WHERE p.publisher_id IS NOT NULL
	    AND EXISTS (SELECT 1 FROM prod_region bpr WHERE bpr.prod_id = p.sku and bpr.region_id in (1,7) and bpr.is_enabled = 'Y')
	    AND EXISTS (SELECT 1 FROM prod_avlb bpa WHERE bpa.prod_id = p.sku and bpa.region_id in (1,7) and bpa.avlb < 60)
	  GROUP BY p.publisher_id, pa.artist_id;
	
	 
	DELETE FROM ya_publisher_dept a
	  WHERE EXISTS (select 1 FROM ya_browse_dept_path c WHERE c.terminal_dept_id = a.dept_id AND c.dept_id = iPdept_id)
	    AND NOT EXISTS (select 1 FROM tmp_updatePublisherArtist b WHERE a.publisher_id = b.publisher_id AND a.dept_id = b.dept_id);
	  
	
	INSERT INTO ya_publisher_dept
	  (
	    publisher_id,
	    dept_id
	  )
	SELECT a.publisher_id, a.dept_id FROM tmp_updatePublisherArtist a
	  WHERE
	    NOT EXISTS(SELECT 1 FROM ya_publisher_dept ppd WHERE a.publisher_id = ppd.publisher_id AND a.dept_id = ppd.dept_id );
	
	COMMIT;

 END cron_fe_updatePublisherArtist;
 
END Pkg_Fe_ToySectPublisherDept;
/

