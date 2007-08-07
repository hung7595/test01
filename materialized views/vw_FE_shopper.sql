drop materialized view vw_FE_shopper
/

Create materialized view vw_FE_shopper
REFRESH COMPLETE ON DEMAND
AS 
SELECT
shopper_id, member_type, created_date, anonymous, yns.site_id as subscribe_site_id, yns.status as subscribe_sts
FROM
ya_shopper yas
LEFT JOIN
ya_newsletter_subscriber yns ON yas.email = yns.email
WHERE yas.created_date >= to_date('21-01-2002 15:42:34', 'DD-MM-YYYY HH24:MI:SS')
AND yas.anonymous = 'N'
/

grant select on vw_FE_shopper to be_app;
