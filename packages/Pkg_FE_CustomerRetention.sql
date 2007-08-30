create or replace PACKAGE Pkg_FE_CustomerRetention
AS
  PROCEDURE CreateCouponForCustomer (
    cPshopperId IN VARCHAR2,
    cPcouponCode OUT VARCHAR2
  );

  PROCEDURE CreateCouponForRegister(
    cPshopperId IN VARCHAR2,
    cPcouponCode OUT VARCHAR2
  );

END Pkg_FE_CustomerRetention;
/
create or replace PACKAGE BODY Pkg_FE_CustomerRetention
IS
  PROCEDURE CreateCouponForCustomer (
    cPshopperId IN VARCHAR2,
    cPcouponCode OUT VARCHAR2
  )
  AS
    cLcoupon_code VARCHAR2(32);
    iLcount INT := 0;
  BEGIN
    BEGIN
      SELECT coupon_code INTO cLcoupon_code
      FROM ya_coupon 
      WHERE shopper_id = RPAD(cPshopperId, 32, ' ')
        AND create_id = 'ya_customer_retention_customer' 
        AND campaign_name = 'YesAsia.com Customer Coupon'
        AND ROWNUM = 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iLcount := -1;
        END;
    END;

    IF iLcount < 0 THEN
      BEGIN
        SELECT cast(dbms_random.string('x', 8) AS VARCHAR2(8)) INTO cLcoupon_code FROM dual;

        -- Make sure unique coupon code
        SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcoupon_code;
        WHILE (iLcount = 1)
        LOOP
          SELECT cast(dbms_random.string('x', 8) AS VARCHAR2(8)) INTO cLcoupon_code FROM dual;
	        SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcoupon_code;
        END LOOP;
          
        INSERT INTO ya_coupon
          (coupon_code, campaign_name, coupon_description, shopper_id, dollar_coupon_value, expiration_date, all_shoppers, coupon_used, coupon_type_id, site_id, order_amount_trigger, create_id, create_date)
        VALUES
          (cLcoupon_code, 'YesAsia.com Customer Coupon', 'YesAsia.com Customer Coupon', cPshopperId, 25, to_date('2010/12/31', 'yyyy/mm/dd'), 'N', 'N', 1, 99, 0, 'ya_customer_retention_customer', sysdate);
        COMMIT;
      END;
    END IF;
  
    cPcouponCode := cLcoupon_code;
  END CreateCouponForCustomer;

  PROCEDURE CreateCouponForRegister(
    cPshopperId IN VARCHAR2,
    cPcouponCode OUT VARCHAR2
  )
  AS
    cLcoupon_code VARCHAR2(32);
    iLcount INT := 0;
  BEGIN
    BEGIN
      SELECT coupon_code INTO cLcoupon_code
      FROM ya_coupon 
      WHERE shopper_id = RPAD(cPshopperId, 32, ' ') 
        AND create_id = 'ya_customer_retention_register' 
        AND campaign_name = 'YesAsia.com Register Coupon'
        AND ROWNUM = 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iLcount := -1;
        END;
    END;

    IF iLcount < 0 THEN
      BEGIN
        SELECT cast(dbms_random.string('x', 8) AS VARCHAR2(8)) INTO cLcoupon_code FROM dual;

        -- Make sure unique coupon code
        SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcoupon_code;
        WHILE (iLcount = 1)
        LOOP
          SELECT cast(dbms_random.string('x', 8) AS VARCHAR2(8)) INTO cLcoupon_code FROM dual;
	        SELECT count(1) INTO iLcount FROM ya_coupon WHERE coupon_code = cLcoupon_code;
        END LOOP;
          
        INSERT INTO ya_coupon
          (coupon_code, campaign_name, coupon_description, shopper_id, dollar_coupon_value, expiration_date, all_shoppers, coupon_used, coupon_type_id, site_id, order_amount_trigger, create_id, create_date)
        VALUES
          (cLcoupon_code, 'YesAsia.com Register Coupon', 'YesAsia.com Register Coupon', cPshopperId, 25, to_date('2010/12/31', 'yyyy/mm/dd'), 'N', 'N', 1, 99, 0, 'ya_customer_retention_register', sysdate);
        COMMIT;
      END;
    END IF;
  
    cPcouponCode := cLcoupon_code;
  END CreateCouponForRegister;
END Pkg_FE_CustomerRetention;
/