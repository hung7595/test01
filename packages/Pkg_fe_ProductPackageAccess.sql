CREATE OR REPLACE PACKAGE Pkg_fe_ProductPackageAccess
AS
  TYPE refcur IS ref CURSOR;
  PROCEDURE GetProductPackage (
    iPattribute_id		IN	INT,
    curPsku	 		OUT 	refcur
  );

  PROCEDURE GetProductPackageBySku (
    iPsku			IN	INT,
    curPsku	 		OUT 	refcur
  );

  PROCEDURE GetProductPackageNote (
    iPattribute_id 		IN	INT,
    iPlang_id			IN	INT,
    curPdata 			OUT 	refcur
  );

  PROCEDURE GetProductPackageNoteBySku (
    iPsku	 		IN	INT,
    iPlang_id			IN	INT,
    curPdata 			OUT 	refcur
  );

  PROCEDURE InsertPackageSku (
    iPattribute_id 		IN	INT,
    iPsku			IN	INT
  );

  PROCEDURE InsertPackageNote (
    iPattribute_id 		IN	INT,
    iPasset_id			IN	INT
  );

	
END Pkg_fe_ProductPackageAccess;
/

CREATE OR REPLACE PACKAGE body Pkg_fe_ProductPackageAccess
IS

  PROCEDURE GetProductPackage (
    iPattribute_id		IN	INT,
    curPsku	 		OUT 	refcur
  )
  AS
  BEGIN
    OPEN curPsku FOR
      SELECT sku FROM ya_prod_package WHERE attribute_id = iPattribute_id;

  END GetProductPackage;


  PROCEDURE GetProductPackageBySku (
    iPsku			IN	INT,
    curPsku	 		OUT 	refcur
  )
  AS
  BEGIN
    OPEN curPsku FOR
      SELECT pp.sku FROM ya_prod_attr pa INNER JOIN ya_prod_package pp
      ON pa.attribute_id = pp.attribute_id
      WHERE pa.sku = iPsku;

  END GetProductPackageBySku;


  PROCEDURE GetProductPackageNote (
    iPattribute_id 		IN	INT,
    iPlang_id			IN	INT,
    curPdata 			OUT 	refcur
  )
  AS
  BEGIN
    OPEN curPdata FOR
    SELECT at.data FROM ya_prod_package_note ppn INNER JOIN ya_asset_translation at
    ON ppn.asset_id = at.asset_id 
    WHERE at.asset_id = iPattribute_id AND at.lang_id = iPlang_id;

  END GetProductPackageNote;


  PROCEDURE GetProductPackageNoteBySku (
    iPsku	 		IN	INT,
    iPlang_id			IN	INT,
    curPdata 			OUT 	refcur
  )
  AS
  BEGIN
    OPEN curPdata FOR
      SELECT at.data FROM ya_prod_package_note ppn INNER JOIN ya_asset_translation at
        ON ppn.asset_id = at.asset_id INNER JOIN ya_prod_attr pa 
	ON ppn.attribute_id = pa.attribute_id
      WHERE pa.sku = iPsku AND at.lang_id = iPlang_id;

  END GetProductPackageNoteBySku;


  PROCEDURE InsertPackageSku (
    iPattribute_id 		IN	INT,
    iPsku			IN	INT
  )
  AS
  BEGIN
    INSERT INTO ya_prod_package (attribute_id, sku) VALUES (iPattribute_id, iPsku);
  COMMIT;
  END InsertPackageSku;


  PROCEDURE InsertPackageNote (
    iPattribute_id 		IN	INT,
    iPasset_id			IN	INT
  )
  AS
  BEGIN
    INSERT INTO ya_prod_package_note (attribute_id, asset_id) VALUES (iPattribute_id, iPasset_id);
  COMMIT; 
  END InsertPackageNote;

END Pkg_fe_ProductPackageAccess;
/