CREATE OR REPLACE PACKAGE Pkg_FE_BargainAccess
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetBargainProductCount (
    iPsite_id IN INT,
    rcPresult OUT refCur
  );
END Pkg_FE_BargainAccess;
/

CREATE OR REPLACE PACKAGE body Pkg_FE_BargainAccess
IS
  PROCEDURE GetBargainProductCount (
    iPsite_id IN INT,
    rcPresult OUT refCur
  )
  AS
  BEGIN
    OPEN rcPresult FOR
    SELECT
      dept_id,
      COUNT
    FROM ya_bargain_prod_count
    WHERE site_id = iPsite_id;
  END GetBargainProductCount;
END;
/

