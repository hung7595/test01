
  CREATE OR REPLACE PACKAGE "CRON_FE_PUBLISHERACCESS" 
AS
PROCEDURE CronJobUpdatePublisherDept(
  iPdeptId IN INT
);
END Cron_fe_PublisherAccess;
/

CREATE OR REPLACE PACKAGE BODY "CRON_FE_PUBLISHERACCESS" 
IS
PROCEDURE CronJobUpdatePublisherDept(
  iPdeptId IN INT
)
 AS

 BEGIN
	  -- Empty temp table
	  EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_publisher';

  INSERT INTO temp_publisher(publisher_id, dept_id)
  SELECT p.publisher_id, pd.dept_id
  FROM ya_product p
  INNER JOIN ya_prod_dept pd ON
    p.sku = pd.sku
  INNER JOIN ya_browse_dept_path c ON
    c.terminal_dept_id = pd.dept_id AND c.dept_id =iPdeptId
  INNER JOIN prod_region pr ON p.sku = pr.prod_id AND pr.region_id in (1,7,10) AND pr.is_enabled = 'Y'
  INNER JOIN prod_avlb pa ON p.sku = pa.prod_id AND pa.region_id = pr.region_id AND pa.avlb < 60
  WHERE
    p.publisher_id IS NOT NULL
  GROUP BY p.publisher_id, pd.dept_id;


    -- Delete not existing relationship
	delete from ya_publisher_dept d where exists (
      select a.publisher_id,a.dept_id from ya_publisher_dept a
		inner join ya_browse_dept_path c ON c.terminal_dept_id = a.dept_id AND c.dept_id = iPdeptId
		LEFT JOIN temp_publisher b ON a.publisher_id = b.publisher_id AND a.dept_id = b.dept_id
		WHERE
		((b.publisher_id is null) OR (b.dept_id is null)) and d.publisher_id = a.publisher_id and d.dept_id = a.dept_id);


	-- Insert new relationship
  INSERT INTO ya_publisher_dept(publisher_id, dept_id)
  SELECT publisher_id, dept_id FROM temp_publisher a
  WHERE NOT EXISTS
    (
      SELECT 1 FROM ya_publisher_dept ppd WHERE a.publisher_id = ppd.publisher_id AND a.dept_id = ppd.dept_id
    );


	IF (SQLCODE=0) THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;


 END CronJobUpdatePublisherDept;

  END Cron_fe_PublisherAccess;
/
 