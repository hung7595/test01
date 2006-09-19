CREATE OR REPLACE PACKAGE Pkg_fe_CampaignAccess
AS
  TYPE refcur IS REF CURSOR;

  PROCEDURE GetProductByCampaignCode (
    iPcampaign_code IN INT,
    curPsku OUT refcur
  );

END Pkg_fe_CampaignAccess;
/

CREATE OR REPLACE PACKAGE BODY Pkg_fe_CampaignAccess
IS

  PROCEDURE GetProductByCampaignCode (
    iPcampaign_code IN INT,
    curPsku OUT refcur
  )
  AS
  BEGIN
    OPEN curPsku FOR
    SELECT
      c.sku
    FROM
      ya_campaign c
    WHERE
      c.campaign_code = iPcampaign_code;
    RETURN;
  END GetProductByCampaignCode;

END Pkg_fe_CampaignAccess;
/

