drop materialized view vw_FE_shopper
/

CREATE MATERIALIZED VIEW vw_FE_shopper
  REFRESH COMPLETE ON DEMAND
    AS 
  SELECT
      yas.shopper_id, yas.email, yas.created_date
    FROM
      ya_shopper yas
    LEFT OUTER JOIN ya_customer_profile yap 
      ON (yas.shopper_id = yap.shopper_id)
    WHERE 
      yas.member_type = 1  -- B2C 
      AND yas.created_date >= TO_DATE('21-01-2002 15:42:34', 'DD-MM-YYYY HH24:MI:SS') -- earliest order date
      AND (yap.shopper_id IS NULL or yap.REGISTER_SITE_ID = 1 or yap.REGISTER_SITE_ID = 7) -- YA US or GB site
      AND yas.anonymous = 'N' -- registered customers
/

grant select on vw_FE_shopper to be_app;
