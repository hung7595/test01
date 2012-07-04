CREATE OR REPLACE PACKAGE Pkg_FE_searchIndex
AS

  PROCEDURE InsertSearchIndexProductId (
  iPprodId IN INT
  );

  END Pkg_FE_searchIndex;
/


CREATE OR REPLACE PACKAGE BODY Pkg_FE_searchIndex
IS

PROCEDURE InsertSearchIndexProductId (
  iPprodId IN INT
  )
  AS
  BEGIN
    delete from ya_se_reindex_duplicate where sku = iPprodId;
	
    insert into ya_se_reindex_duplicate (sku, action, mod_dt) 
    select distinct sku, 0, sysdate from 
    (
      select sku from  ya_product where sku = iPprodId and is_prod_grp_parent = 'N'
	);
	
    EXCEPTION WHEN OTHERS THEN
    BEGIN
      DBMS_OUTPUT.PUT_LINE(iPprodId);
    END;
     
  END InsertSearchIndexProductId;

END Pkg_FE_searchIndex;
/
