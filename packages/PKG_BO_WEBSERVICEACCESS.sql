
  CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_BO_WEBSERVICEACCESS" AS
  
  TYPE refCur IS ref CURSOR;
  
  PROCEDURE GetWebServiceListByServiceType (
    cPserviceType IN VARCHAR2,
    curPgetWebService OUT refCur
  );
  
  PROCEDURE AddWebService (
    cPIpAddress IN VARCHAR2,
    cPServiceType IN VARCHAR2,
    cPServerID IN VARCHAR2
  );
  
  PROCEDURE DeleteWebServiceByPrimaryKey (
    iPKey IN INT
  );
  
  PROCEDURE UpdateWebServiceByPrimaryKey (
    iPKey IN INT,
    cPIpAddress IN VARCHAR2,
    cPServiceType IN VARCHAR2,
    cPServerID IN VARCHAR2
  );

END PKG_BO_WEBSERVICEACCESS;
/
CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_BO_WEBSERVICEACCESS" AS

  PROCEDURE GetWebServiceListByServiceType (
    cPserviceType IN VARCHAR2,
    curPgetWebService OUT refCur
  ) AS
  BEGIN
    open curPgetWebService For
      select * from ya_server_webservice where service_type = cPserviceType order by ip_address;
  END GetWebServiceListByServiceType;

  PROCEDURE AddWebService (
    cPIpAddress IN VARCHAR2,
    cPServiceType IN VARCHAR2,
    cPServerID IN VARCHAR2
  ) AS
    iKey  INT;
    counter INT;         
  BEGIN
    SELECT count(*) into counter FROM ya_server_webservice;
    if counter > 0 THEN
      select max(key) into iKey from ya_server_webservice;
      iKey := iKey + 1 ;
    else
      iKey := 1;  
    end if;
    
    INSERT INTO ya_server_webservice ( IP_ADDRESS, SERVICE_TYPE, SERVER_ID, KEY ) 
    values ( cPIpAddress, cPServiceType, cPServerID, iKey );
        
    COMMIT;
    RETURN;
    EXCEPTION WHEN OTHERS THEN
      BEGIN
        ROLLBACK;
        RETURN;
      END;
  END AddWebService;

  PROCEDURE DeleteWebServiceByPrimaryKey (
    iPKey IN INT
  ) AS
  BEGIN
    delete from ya_server_webservice where key = iPKey;
    COMMIT;
    RETURN;
    EXCEPTION WHEN OTHERS THEN
      BEGIN
        ROLLBACK;
        RETURN;
      END;
  END DeleteWebServiceByPrimaryKey;

  PROCEDURE UpdateWebServiceByPrimaryKey (
    iPKey IN INT,
    cPIpAddress IN VARCHAR2,
    cPServiceType IN VARCHAR2,
    cPServerID IN VARCHAR2
  ) AS
  BEGIN
    update ya_server_webservice set IP_ADDRESS = cPIpAddress, SERVICE_TYPE = cPServiceType, SERVER_ID = cPServerID
    where key = iPKey;
    
    COMMIT;
    RETURN;
    EXCEPTION WHEN OTHERS THEN
      BEGIN
        ROLLBACK;
        RETURN;
      END;
  END UpdateWebServiceByPrimaryKey;

END PKG_BO_WEBSERVICEACCESS;
/
 