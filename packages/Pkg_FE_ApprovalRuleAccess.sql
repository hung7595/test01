  CREATE OR REPLACE PACKAGE Pkg_FE_APPROVALRULEACCESS
AS
  PROCEDURE IsSuccessCreditCard(
    cPshopper_id IN VARCHAR2,
    cPencrypted_cc_num IN VARCHAR2,
    iPreturn OUT INT
  );
  
  PROCEDURE IsWhiteListCreditCard(
    cPshopper_id IN VARCHAR2,
    cPencrypted_cc_num IN VARCHAR2,
    iPreturn OUT INT
  );  
END Pkg_FE_APPROVALRULEACCESS;
/
CREATE OR REPLACE PACKAGE BODY Pkg_FE_APPROVALRULEACCESS
AS
  PROCEDURE IsSuccessCreditCard (
    cPshopper_id IN VARCHAR2,
    cPencrypted_cc_num IN VARCHAR2,
    iPreturn OUT INT
  )
  AS
  BEGIN
    IF sysdate >= to_date('2008-07-25 21:00:00', 'YYYY-MM-DD HH24:MI:SS') and sysdate <= to_date('2008-07-29 02:00:00', 'YYYY-MM-DD HH24:MI:SS') THEN
      BEGIN
        SELECT 1 INTO iPreturn FROM DUAL;
      END;
    ELSE
      BEGIN
        SELECT 1
        INTO iPreturn
        FROM vw_trusted_cust
        WHERE
          cust_id = cPshopper_id
          AND cc_num_encrypted = cPencrypted_cc_num;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        iPreturn := -1;
      END;
    END IF;
  END IsSuccessCreditCard;

  PROCEDURE IsWhiteListCreditCard (
    cPshopper_id IN VARCHAR2,
    cPencrypted_cc_num IN VARCHAR2,
    iPreturn OUT INT
  )
  AS
  BEGIN
    SELECT 1
    INTO iPreturn
    FROM white_list_cust
    WHERE
      cust_id = cPshopper_id
      AND encrypted_cc_num = cPencrypted_cc_num;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    iPreturn := -1;
  END IsWhiteListCreditCard;
END Pkg_FE_APPROVALRULEACCESS;
/