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
	  SELECT a.shopper_id
	  FROM ya_shopper a where not exists (select * from ya_reminder_exclude_list b 
	  where b.shopper_id = a.shopper_id) and not exists (select * from ya_customer_profile c 
	  where c.shopper_id = a.shopper_id) and not exists (select * from ya_newsletter_subscriber d 
	  where d.shopper_id = a.shopper_id) and exists (select * from order_info e 
	  where e.cust_id = a.shopper_id and e.origin_id = iPsite_id and e.approval_dt is not null 
	  and (e.sts = 11 or e.sts = 12 or e.sts = 13))
	  FOR UPDATE;
		BEGIN
		  OPEN ShopperIdCursor;
		  LOOP
		    FETCH ShopperIdCursor INTO x;
		    EXIT WHEN ShopperIdCursor%NOTFOUND;
		    INSERT INTO ya_newsletter_subscriber
		    (email,shopper_id,guid,date_time,site_id,newsletter_id,status,downloaded_flag,rowguid)
		    VALUES
		    ((SELECT email from ya_shopper where shopper_id=x),x,sys_guid(),sysdate,iPsite_id,45,'A','N',sys_guid());
		    INSERT INTO ya_newsletter_subscriber
		    (email,shopper_id,guid,date_time,site_id,newsletter_id,status,downloaded_flag,rowguid)
		    VALUES
		    ((SELECT email from ya_shopper where shopper_id=x),x,sys_guid(),sysdate,iPsite_id,46,'A','N',sys_guid());
		    INSERT INTO ya_newsletter_subscriber
		    (email,shopper_id,guid,date_time,site_id,newsletter_id,status,downloaded_flag,rowguid)
		    VALUES
		    ((SELECT email from ya_shopper where shopper_id=x),x,sys_guid(),sysdate,iPsite_id,47,'A','N',sys_guid());
		    INSERT INTO ya_newsletter_subscriber
		    (email,shopper_id,guid,date_time,site_id,newsletter_id,status,downloaded_flag,rowguid)
		    VALUES
		    ((SELECT email from ya_shopper where shopper_id=x),x,sys_guid(),sysdate,iPsite_id,48,'A','N',sys_guid());
			INSERT INTO ya_newsletter_subscriber
		    (email,shopper_id,guid,date_time,site_id,newsletter_id,status,downloaded_flag,rowguid)
		    VALUES
		    ((SELECT email from ya_shopper where shopper_id=x),x,sys_guid(),sysdate,iPsite_id,49,'A','N',sys_guid());
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