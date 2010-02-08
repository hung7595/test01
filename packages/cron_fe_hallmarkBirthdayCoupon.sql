CREATE OR REPLACE PACKAGE Cron_fe_hallmarkBirthdayCoupon
AS
  PROCEDURE CreateHallmarkBirthdayCoupon
  (
    iPmonth INT
  );
  
END Cron_fe_hallmarkBirthdayCoupon;
/

CREATE OR REPLACE PACKAGE body Cron_fe_hallmarkBirthdayCoupon
IS
  PROCEDURE CreateHallmarkBirthdayCoupon
  (
    iPmonth INT
  )
  AS
    CURSOR hallmark_shopper is
      select ys.shopper_id
      from ya_shopper ys
      inner join ya_hallmark_shopper hs on ys.shopper_id = hs.ya_shopper_id 
      where dob is not null
      and to_char(dob, 'mm') = iPmonth
      and (hs.last_bday_coupon_date is null 
            or add_months(last_bday_coupon_date, 11) < sysdate);
  BEGIN
    FOR shopper in hallmark_shopper
    LOOP
      Pkg_FE_CouponAccess.CreateHallmarkBirthdayCoupon(shopper.shopper_id);
      update ya_hallmark_shopper set last_bday_coupon_date = sysdate where ya_shopper_id = shopper.shopper_id;
      commit;
    END LOOP;
  END CreateHallmarkBirthdayCoupon;
END Cron_fe_hallmarkBirthdayCoupon;
/