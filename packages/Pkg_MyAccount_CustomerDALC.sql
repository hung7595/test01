CREATE OR REPLACE PACKAGE Pkg_MyAccount_CustomerDALC
AS
PROCEDURE GetSendingEmail (
cPshopper_id IN CHAR,
cPemail OUT CHAR
);
END Pkg_MyAccount_CustomerDALC;
/

create or replace
PACKAGE BODY Pkg_MyAccount_CustomerDALC
AS
PROCEDURE GetSendingEmail (
cPshopper_id IN CHAR,
cPemail OUT CHAR
)
AS
BEGIN
SELECT nvl(CORRESPONDENCE_EMAIL, email) INTO cPemail FROM ya_shopper WHERE shopper_id = cPshopper_id;
EXCEPTION
WHEN NO_DATA_FOUND THEN
cPemail := null;
END GetSendingEmail;
END Pkg_MyAccount_CustomerDALC;
/