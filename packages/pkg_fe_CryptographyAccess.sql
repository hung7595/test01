CREATE OR REPLACE PACKAGE Pkg_fe_CryptographyAccess AS

TYPE cur_return IS REF CURSOR;

PROCEDURE GetKey
(
  iPkeyId IN INT,
  curPout OUT cur_return
);

END Pkg_fe_CryptographyAccess;
/

CREATE OR REPLACE PACKAGE BODY Pkg_fe_CryptographyAccess AS

PROCEDURE GetKey
(
  iPkeyId IN INT,
  curPout OUT cur_return
)
AS
BEGIN
  OPEN curPout FOR
  SELECT ya_adm.Fn_KeyGeneration(iPkeyId) FROM DUAL;
END GetKey;

END Pkg_fe_CryptographyAccess;
/
