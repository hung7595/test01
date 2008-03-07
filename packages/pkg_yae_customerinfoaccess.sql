  CREATE OR REPLACE PACKAGE PKG_YAE_CUSTOMERINFOACCESS
AS
  PROCEDURE AddCustomerInfo(
    cPcustomer_name IN VARCHAR2,
    cPemail IN VARCHAR2,
    cPaddress IN VARCHAR2,
    cPcity IN VARCHAR2,
    cPstate IN VARCHAR2,
    cPzip IN VARCHAR2
  );
END PKG_YAE_CUSTOMERINFOACCESS;
/

CREATE OR REPLACE PACKAGE BODY PKG_YAE_CUSTOMERINFOACCESS
AS
  PROCEDURE AddCustomerInfo(
    cPcustomer_name IN VARCHAR2,
    cPemail IN VARCHAR2,
    cPaddress IN VARCHAR2,
    cPcity IN VARCHAR2,
    cPstate IN VARCHAR2,
    cPzip IN VARCHAR2
  )
  AS
  BEGIN
  INSERT INTO yae_customer_info (id, customer_name, address, city, state, zip, email, created_datetime)
  VALUES (SEQ_YAE_CUSTOMER_INFO.NEXTVAL, cPcustomer_name, cPaddress, cPcity, cPstate, cPzip, cPemail, sysdate);
  COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      BEGIN
        ROLLBACK;
      END;
  END AddCustomerInfo;
END PKG_YAE_CUSTOMERINFOACCESS;
/