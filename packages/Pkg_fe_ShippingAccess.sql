CREATE OR REPLACE PACKAGE Pkg_fe_ShippingAccess
AS

  TYPE refcur IS REF CURSOR;

  PROCEDURE GetShippingScheme (
    iPsite_id		IN 	INT,
    iPcountry_id	IN	INT,
    iPshipping_method	IN	INT,
    curPgetShipping	OUT	refcur
  );
END Pkg_fe_ShippingAccess;
/

CREATE OR REPLACE PACKAGE BODY Pkg_fe_ShippingAccess
IS
    PROCEDURE GetShippingScheme (
    iPsite_id		IN 	INT,
    iPcountry_id	IN	INT,
    iPshipping_method	IN	INT,
    curPgetShipping	OUT	refcur
  )
  AS
  BEGIN
    OPEN curPgetShipping FOR
    SELECT
      per_unit_rate,
      handling_fee,
      special_handling_fee,
      lower_shipping_time,
      upper_shipping_time
    FROM
      ya_shipping_rate
    WHERE
      site_id  = iPsite_id
      AND country_id  = iPcountry_id
      AND shipping_method_id  = iPshipping_method;
    RETURN;
  END GetShippingScheme;
END Pkg_fe_ShippingAccess;
/

