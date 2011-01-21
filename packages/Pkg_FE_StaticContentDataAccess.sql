create or replace PACKAGE PKG_FE_STATICCONTENTDATAACCESS
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE CopyNewSiteData
  (
    iPfromSiteId IN INT,
    iPtoSiteId IN INT,
    iProwAffected OUT int
  );
  END Pkg_Fe_StaticContentDataAccess;
/

create or replace PACKAGE BODY PKG_FE_STATICCONTENTDATAACCESS AS

  PROCEDURE CopyNewSiteData
  (
    iPfromSiteId IN INT,
    iPtoSiteId IN INT,
    iProwAffected OUT INT
  ) AS
  
  iLstaticContentId INT;
  curLstaticContent refCur;
  iLinsertStaticContentId INT;
  iLcontentType INT;
  iLentryType INT;
  cLimgUrl VARCHAR2(100);
  iLversion INT;
  dtLupdateDate DATE;
  cLupdateUser VARCHAR2(50);
  dtLdisplayDate DATE;
  cLenabled VARCHAR2(1);
  dtLpublishStartDate DATE;
  dtLpublishEndDate DATE;
  iLpriority INT;
  curLstaticContentLang refCur;
  iLstaticContentLangId INT;
  cLtitle VARCHAR2(500);
  cLcontent CLOB;
  cLwriter NVARCHAR2(150);
  cLlocale VARCHAR2(5);
  iLversionLang INT;
  iLrowAffected INT;
  iLcount INT;
  
  BEGIN
    OPEN curLstaticContent FOR
  select id from static_content where site_id = iPfromSiteId order by id;
  select count(*) into iLcount from static_content where site_id = iPtoSiteId;
  
  IF (iLcount > 0) THEN
    RETURN;
  END IF;
  
  FETCH curLstaticContent INTO iLstaticContentId;
    WHILE curLstaticContent%FOUND LOOP
      BEGIN
        select content_type, entry_type, img_url, version, update_date, update_user, display_date, enabled, publish_start_date, publish_end_date, priority into iLcontentType, iLentryType, cLimgUrl, iLversion, dtLupdateDate, cLupdateUser, dtLdisplayDate, cLenabled, dtLpublishStartDate, dtLpublishEndDate, iLpriority 
        from static_content
        where id = iLstaticContentId;
		
        select SEQ_CONTENT.nextval into iLinsertStaticContentId from dual;
		
        INSERT INTO STATIC_CONTENT (id, content_type, entry_type, img_url, version, update_date, update_user, display_date, enabled, publish_start_date, publish_end_date, priority, site_id)
        VALUES (iLinsertStaticContentId, iLcontentType, iLentryType, cLimgUrl, iLversion, dtLupdateDate, cLupdateUser, dtLdisplayDate, cLenabled, dtLpublishStartDate, dtLpublishEndDate, iLpriority, iPtoSiteId);
		
        OPEN curLstaticContentLang FOR
        select title, content, writer, locale, version from static_content_lang where content_id = iLstaticContentId;
		
        FETCH curLstaticContentLang INTO cLtitle, cLcontent, cLwriter, cLlocale, iLversionLang;
          WHILE curLstaticContentLang%FOUND LOOP
            BEGIN
              select SEQ_CONTENT_LANG.nextval into iLstaticContentLangId from dual;
			  
              INSERT INTO STATIC_CONTENT_LANG (id, content_id, title, content, writer, locale, version) 
              VALUES (iLstaticContentLangId, iLinsertStaticContentId, cLtitle, cLcontent, cLwriter, cLlocale, iLversionLang);
			  
            END;
            FETCH curLstaticContentLang INTO cLtitle, cLcontent, cLwriter, cLlocale, iLversionLang;
          END LOOP;
      END;
      FETCH curLstaticContent INTO iLstaticContentId;
    END LOOP;
    
    IF sqlcode = 0 THEN      
      COMMIT;
    ELSE        
      ROLLBACK;          
    END IF;
  END CopyNewSiteData;

END PKG_FE_STATICCONTENTDATAACCESS;
/
