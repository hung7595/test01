drop materialized view vw_FE_shopper
/

Create materialized view vw_FE_shopper
REFRESH COMPLETE ON DEMAND
AS 
SELECT
shopper_id, member_type, created_date, anonymous
FROM
ya_shopper
WHERE created_date >= to_date('21-01-2002 15:42:34', 'DD-MM-YYYY HH24:MI:SS')
AND anonymous = 'N'
/

