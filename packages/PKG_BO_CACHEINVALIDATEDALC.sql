
  CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_BO_CACHEINVALIDATEDALC" 
AS
  TYPE refCur IS ref CURSOR;

  PROCEDURE GetInvalidateProductList (
    cPserver_id IN Varchar2,
    curPout OUT refCur
  );

  PROCEDURE MarkProductInvalidate (
    cPserver_id IN Varchar2,
    iPSku IN INT
  );
  
  PROCEDURE InsertInvalidateProduct (
    cPserver_id IN Varchar2,
    iPSku IN INT
  );
  
  PROCEDURE InsertBEInvalidateProduct (
    iPSku IN INT
  );

END PKG_BO_CACHEINVALIDATEDALC;
/
CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_BO_CACHEINVALIDATEDALC" AS

  PROCEDURE GetInvalidateProductList (
    cPserver_id IN Varchar2,
    curPout OUT refCur
  ) AS
  BEGIN
    OPEN curPout FOR
      select sku from ya_cache_invalidate 
      where server_id = cPserver_id and process_flag = 'N'
      order by created_datetime;
    RETURN;
  END GetInvalidateProductList;

  PROCEDURE MarkProductInvalidate (
    cPserver_id IN Varchar2,
    iPSku IN INT
  ) AS
  BEGIN
    update ya_cache_invalidate set process_flag = 'Y' 
    where server_id = cPserver_id and sku = iPSku and process_flag = 'N';
    COMMIT;
    RETURN;
    EXCEPTION WHEN OTHERS THEN
      BEGIN
        ROLLBACK;
        RETURN;
      END;
  END MarkProductInvalidate;
  
  PROCEDURE InsertInvalidateProduct (
    cPserver_id IN Varchar2,
    iPSku IN INT
  ) AS 
  BEGIN
      insert into ya_cache_invalidate ( sku, server_id ) values ( iPSku, cPserver_id );
      COMMIT;
      RETURN;
    EXCEPTION WHEN OTHERS THEN
      BEGIN
        ROLLBACK;
        RETURN;
      END;
  END InsertInvalidateProduct;
  
  PROCEDURE InsertBEInvalidateProduct (
    iPSku IN INT
  ) AS
  BEGIN
    InsertInvalidateProduct ( 'Backend', iPSku );
    EXCEPTION WHEN OTHERS THEN
      BEGIN
        ROLLBACK;
        RETURN;
      END;
  END;

END PKG_BO_CACHEINVALIDATEDALC;
/
 