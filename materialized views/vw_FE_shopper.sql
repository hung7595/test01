drop materialized view vw_FE_shopper
/

Create materialized view vw_FE_shopper
REFRESH COMPLETE ON DEMAND
AS 
SELECT
shopper_id, member_type, created_date, anonymous
FROM
ya_shopper
WHERE created_date >= to_date('20-01-2002', 'DD-MM-YYYY')
AND anonymous = 'N'
/

