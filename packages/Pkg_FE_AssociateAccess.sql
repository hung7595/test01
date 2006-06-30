CREATE OR REPLACE PACKAGE Pkg_FE_AssociateAccess
AS
  TYPE curG IS REF CURSOR;

  PROCEDURE InsertAssociateHitsRawData (
    cPassociateID IN VARCHAR2,
    iPreturn OUT INT
  );

  PROCEDURE GetAssociateLinkId (
    cPlinkCode IN VARCHAR2,
    curPresult1 OUT curG
  );
END Pkg_FE_AssociateAccess;
/

CREATE OR REPLACE PACKAGE body Pkg_FE_AssociateAccess
IS
  /* proc_fe_InsertAssociateHitsRawEntry */
  PROCEDURE InsertAssociateHitsRawData (
    cPassociateID IN VARCHAR2,
    iPreturn OUT INT
  )
  AS
  BEGIN
    INSERT INTO ya_associate_hits_raw (link_id)
    SELECT link_id
    FROM ya_associate_link
    WHERE link_code = cPassociateID;

    iPreturn := SQL%ROWCOUNT;
    COMMIT;
  EXCEPTION WHEN others THEN
    BEGIN
      ROLLBACK;
      iPreturn := -1;
    END;
  END InsertAssociateHitsRawData;


  PROCEDURE GetAssociateLinkId (
    cPlinkCode IN VARCHAR2,
    curPresult1 OUT curG
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT link_id
    FROM ya_associate_link
    WHERE link_code = cPlinkCode;
    RETURN;
   END GetAssociateLinkId;
END Pkg_FE_AssociateAccess;
/

