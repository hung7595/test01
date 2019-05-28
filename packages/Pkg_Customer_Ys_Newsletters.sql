CREATE OR REPLACE package Pkg_Customer_Ys_Newsletters
As
  -- iPshopperId is a ya_shopper.shopper_id
  -- iPreturn_value 1 means the customer is subscribing to YS newsletter 
  -- iPreturn_value 0 means the customer is not subscribing to YS newsletter
  PROCEDURE IsYsNewslettersSubscrip (
    iPshopperId IN VARCHAR2,
    iPreturn_value OUT INT
  );
  
END Pkg_Customer_Ys_Newsletters;
/

CREATE OR REPLACE PACKAGE BODY Pkg_Customer_Ys_Newsletters 
is
  PROCEDURE IsYsNewslettersSubscrip (
    iPshopperId IN VARCHAR2,
    iPreturn_value OUT INT
    )
  AS
  BEGIN
	  select count(1) INTO iPreturn_value from ya_newsletter_subscriber where shopper_id = iPshopperId  and site_id = 10 and STATUS = 'A' and NEWSLETTER_ID = 45;
  END IsYsNewslettersSubscrip;
END Pkg_Customer_Ys_Newsletters;
/