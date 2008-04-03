drop materialized view vw_attribute_list
/

Create materialized view vw_attribute_list
REFRESH COMPLETE ON DEMAND
AS 
select a.attribute_id,al.attribute_name,a.count_prod, al.lang_id,a.attribute_type_id, a.publisher_id, a.dept_id from (
select pa.attribute_id,a.attribute_type_id, p.publisher_id, pd.dept_id,count(pa.attribute_id) as count_prod 
 from ya_product p 
inner join ya_prod_attr pa on p.sku=pa.sku
inner join ya_prod_dept pd on p.sku=pd.sku
inner join ya_attribute a on pa.attribute_id=a.attribute_id
inner join ya_attribute_type att on a.attribute_type_id=att.attribute_type_id and a.attribute_type_id in (64, 65, 68)
inner join prod_avlb pav on p.sku=pav.prod_id and region_id=10 and avlb<=40
inner join prod_region pr on p.sku=pr.prod_id and pr.region_id=10 and pr.is_can_sell='Y' and pr.is_enabled='Y'
where 1=1 -- p.publisher_id=233766 
and pd.dept_id in (10864, 11118, 11434)
group by pa.attribute_id,a.attribute_type_id, p.publisher_id, pd.dept_id
)
 a
inner join ya_attribute_lang al on a.attribute_id=al.attribute_id --and al.lang_id=1
order by count_prod desc
/


Create public synonym vw_attribute_list for ss_adm.vw_attribute_list;

grant select on vw_attribute_list to ys_staging, ys_web;
