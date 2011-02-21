CREATE OR REPLACE package Pkg_fe_AssociateMgtAccess
As
  TYPE curGgetNews IS REF CURSOR;
  
  PROCEDURE GenerateAssociateLinkId (
    iPassociateId IN INT,
    cPsiteName IN VARCHAR2,
    cPlinkUrl IN VARCHAR2,
    cPlinkDesc IN VARCHAR2,
    cPcreatedUser IN VARCHAR2,
    iLlinkId OUT INT
  );
  
END Pkg_fe_AssociateMgtAccess;
/

CREATE OR REPLACE package body Pkg_fe_AssociateMgtAccess
IS

  PROCEDURE GenerateAssociateLinkId
  (
    iPassociateId IN INT,
    cPsiteName IN VARCHAR2,
    cPlinkUrl IN VARCHAR2,
    cPlinkDesc IN VARCHAR2,
    cPcreatedUser IN VARCHAR2,
    iLlinkId OUT INT
  )
  IS
    cLlinkCode VARCHAR(8);
    iLcheck INT;
    iLlength INT;
  BEGIN
    iLcheck := 1;
    iLlength := 8;

    WHILE (iLcheck>0)
    LOOP
      SELECT dbms_random.string('X', iLlength) str INTO cLlinkCode FROM dual;
      SELECT COUNT(1) INTO iLcheck FROM YA_ASSOCIATE_LINK WHERE link_code = cLlinkCode;
    END LOOP;

    SELECT SEQ_ASSOCIATE_LINK.nextval into iLlinkId from dual;

    INSERT INTO YA_ASSOCIATE_LINK (
      associate_id,link_id,site_name,LINK_CODE,LINK_TYPE,LINK_PERCENTAGE,LINK_STATUS,LINK_URL,LINK_DESC,CREATED_USER,CREATED_DATE,LANG_ID)
    VALUES (iPassociateId, iLlinkId, cPsiteName, cLlinkCode , 2, 0.1, 2, cPlinkUrl, cPlinkDesc, cPcreatedUser, sysdate, 1 );
    
    IF (SQL%ROWCOUNT>0) AND (SQLCODE=0) THEN
        COMMIT;
    ELSE
        iLlinkId := -1;
        ROLLBACK;
    END IF;
  END GenerateAssociateLinkId;
  
END Pkg_fe_AssociateMgtAccess;
/