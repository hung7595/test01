CREATE OR REPLACE PACKAGE Pkg_FE_CalendarAccess
AS
  TYPE curG IS REF CURSOR;

  PROCEDURE GetCountryHolidays (
    iPcountry_id IN INTEGER,
    curPresult1 OUT curG
  );
END Pkg_FE_CalendarAccess;
/

CREATE OR REPLACE PACKAGE BODY Pkg_FE_CalendarAccess
IS
  PROCEDURE GetCountryHolidays (
    iPcountry_id IN INTEGER,
    curPresult1 OUT curG
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT holiday
    FROM ya_holidays
    WHERE country_id = iPcountry_id
    ORDER BY holiday;
    RETURN;
  END GetCountryHolidays;
END Pkg_FE_CalendarAccess;
/

