  CREATE OR REPLACE PACKAGE Pkg_FE_APPROVALRULEACCESS
AS
  PROCEDURE IsSuccessCreditCard(
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
    SELECT 1
    INTO iPreturn
    FROM vw_trusted_cust
    WHERE
      cust_id = cPshopper_id
      AND cc_num_encrypted = cPencrypted_cc_num;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    iPreturn := -1;
  END IsSuccessCreditCard;
END Pkg_FE_APPROVALRULEACCESS;
/