create or replace PROCEDURE sp_cross_selling_type3
AS
BEGIN
  delete from ya_cross_selling_type3;

  insert into ya_cross_selling_type3
  select * from ya_cross_selling where type_id = 3;

  commit;

  DBMS_OUTPUT.PUT_LINE('Refresh OK.');

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Refresh Failed. Rollback.');
    ROLLBACK;

END sp_cross_selling_type3;