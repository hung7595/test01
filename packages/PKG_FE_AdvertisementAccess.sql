CREATE OR REPLACE PACKAGE PKG_FE_ADVERTISEMENTACCESS AS

  TYPE curGgetAdvertisement IS ref CURSOR;
  PROCEDURE GetZoneIDByPrimaryKey (
    iPsiteId IN INT,
    iPlangId IN INT,
    vcclassName IN VARCHAR,
    vccontorlId IN VARCHAR,
    vcadvertisementName IN VARCHAR,
    curGgetAdvertisement OUT curGgetAdvertisement
  );
  
  PROCEDURE GetAdvListByAdvSysName (
    vcAdvSysName IN VARCHAR,
    curGgetAdvertisement OUT curGgetAdvertisement
  );

END PKG_FE_ADVERTISEMENTACCESS;

/


CREATE OR REPLACE PACKAGE BODY PKG_FE_ADVERTISEMENTACCESS AS

  PROCEDURE GetZoneIDByPrimaryKey (
    iPsiteId IN INT,
    iPlangId IN INT,
    vcclassName IN VARCHAR,
    vccontorlId IN VARCHAR,
    vcadvertisementName IN VARCHAR,
    curGgetAdvertisement OUT curGgetAdvertisement
  ) AS
  BEGIN
    OPEN curGgetAdvertisement FOR
      SELECT s.zoneId FROM ya_advertisement_system s
            WHERE s.SITEID = ipsiteId
            and s.LANGID = iPlangId
            and s.CLASSNAME = vcclassName
            and s.CONTROLID = vccontorlId
            and s.ADVERTISEMENTSYSTEMNAME = vcadvertisementName ;
    RETURN;
  END GetZoneIDByPrimaryKey;

  PROCEDURE GetAdvListByAdvSysName (
    vcAdvSysName IN VARCHAR,
    curGgetAdvertisement OUT curGgetAdvertisement
  ) AS
  BEGIN
    OPEN curGgetAdvertisement FOR
      SELECT * FROM ya_advertisement_system s
            WHERE s.ADVERTISEMENTSYSTEMNAME = vcAdvSysName ;
    RETURN;
  END GetAdvListByAdvSysName;

END PKG_FE_ADVERTISEMENTACCESS;

/
