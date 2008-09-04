CREATE OR REPLACE PACKAGE Cron_fe_UpdateNewsSubscriber
AS
  PROCEDURE UpdateNewsSubInfo(
    iPsite_id IN INT
  );
	
END Cron_fe_UpdateNewsSubscriber;
/

CREATE OR REPLACE PACKAGE body Cron_fe_UpdateNewsSubscriber
IS

  PROCEDURE UpdateNewsSubInfo(
    iPsite_id IN INT
 )
	 AS
	 BEGIN
	  DECLARE
	  x ya_newsletter_subscriber.shopper_id%TYPE;
	  CURSOR ShopperIdCursor IS
	  SELECT a.shopper_id FROM ya_shopper a WHERE 
    NOT EXISTS (SELECT * FROM ya_reminder_exclude_list b WHERE b.shopper_id = a.shopper_id) 
    AND NOT EXISTS (SELECT * FROM ya_customer_profile c WHERE c.shopper_id = a.shopper_id 
    AND (c.register_site_id=10 OR c.register_site_id=11))
    AND NOT EXISTS (SELECT * FROM ya_newsletter_subscriber d WHERE d.shopper_id = a.shopper_id 
    AND (site_id=10 OR site_id=11)) 
    AND EXISTS (SELECT * FROM ORder_info e WHERE e.cust_id = a.shopper_id 
    AND e.ORigin_id = 10 AND e.approval_dt is NOT null
	  AND (e.sts = 11 OR e.sts = 12 OR e.sts = 13)) AND shopper_id=a.shopper_id;
		BEGIN
		  OPEN ShopperIdCursor;
		  LOOP
		    FETCH ShopperIdCursor INTO x;
		    EXIT WHEN ShopperIdCursor%NOTFOUND;
		    INSERT INTO ya_newsletter_subscriber
		    (email,shopper_id,guid,date_time,site_id,newsletter_id,status,downloaded_flag,rowguid)
		    VALUES
		    ((SELECT email FROM ya_shopper WHERE shopper_id=x),x,sys_guid(),sysdate,iPsite_id,45,'A','N',sys_guid());
		    INSERT INTO ya_newsletter_subscriber
		    (email,shopper_id,guid,date_time,site_id,newsletter_id,status,downloaded_flag,rowguid)
		    VALUES
		    ((SELECT email FROM ya_shopper WHERE shopper_id=x),x,sys_guid(),sysdate,iPsite_id,46,'A','N',sys_guid());
		    INSERT INTO ya_newsletter_subscriber
		    (email,shopper_id,guid,date_time,site_id,newsletter_id,status,downloaded_flag,rowguid)
		    VALUES
		    ((SELECT email FROM ya_shopper WHERE shopper_id=x),x,sys_guid(),sysdate,iPsite_id,47,'A','N',sys_guid());
		    INSERT INTO ya_newsletter_subscriber
		    (email,shopper_id,guid,date_time,site_id,newsletter_id,status,downloaded_flag,rowguid)
		    VALUES
		    ((SELECT email FROM ya_shopper WHERE shopper_id=x),x,sys_guid(),sysdate,iPsite_id,48,'A','N',sys_guid());
			INSERT INTO ya_newsletter_subscriber
		    (email,shopper_id,guid,date_time,site_id,newsletter_id,status,downloaded_flag,rowguid)
		    VALUES
		    ((SELECT email FROM ya_shopper WHERE shopper_id=x),x,sys_guid(),sysdate,iPsite_id,49,'A','N',sys_guid());
		    END LOOP;
		  CLOSE ShopperIdCursor;
		END;
		IF (SQLCODE = 0) THEN
			COMMIT;
		ELSE
			ROLLBACK;
	  END IF;

	 END UpdateNewsSubInfo;


END Cron_fe_UpdateNewsSubscriber;
/