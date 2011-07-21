CREATE OR REPLACE PACKAGE PKG_FE_STATICCONTENTDATAACCESS
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE CopyNewSiteData
  (
    iPfromSiteId IN INT,
    iPtoSiteId IN INT,
    iProwAffected OUT int
  );

  PROCEDURE CopySCToFC
  (
    iProwAffected OUT int
  );
  END Pkg_Fe_StaticContentDataAccess;
/


CREATE OR REPLACE PACKAGE BODY PKG_FE_STATICCONTENTDATAACCESS AS

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

  PROCEDURE CopySCToFC
  (
    iProwAffected OUT INT
  ) AS

  iLstaticContentId INT;
  curLstaticContent refCur;
  iLinsertFCId INT;
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
  cLlangId VARCHAR2(5);
  iLversionLang INT;
  iLrowAffected INT;
  iLcount INT;

  BEGIN
    OPEN curLstaticContent FOR
  select id from static_content where site_id = 10 and enabled = 'Y' and content_type in (18,19,20,22,23) order by id;

  FETCH curLstaticContent INTO iLstaticContentId;
    WHILE curLstaticContent%FOUND LOOP
      BEGIN
        select content_type, img_url, update_date, update_user, display_date, publish_start_date, publish_end_date, priority into iLcontentType, cLimgUrl, dtLupdateDate, cLupdateUser, dtLdisplayDate, dtLpublishStartDate, dtLpublishEndDate, iLpriority
        from static_content
        where id = iLstaticContentId;

        select SEQ_YA_FRONTEND_CONTENT.nextval into iLinsertFCId from dual;

        INSERT INTO YA_FRONTEND_CONTENT (id, TYPE, IMAGE_URL, DISPLAY_DT,VALID_START, VALID_END, PRIORITY, CREATE_USER, CREATE_DT, MOD_USER, MOD_DT)
        VALUES (iLinsertFCId, iLcontentType, cLimgUrl, dtLdisplayDate, dtLpublishStartDate, dtLpublishEndDate, iLpriority, cLupdateUser, sysdate, cLupdateUser, dtLupdateDate);
		
		INSERT INTO ya_frontend_content_site (id, frontend_content_id, site_id,  is_enabled) values (SEQ_YA_FRONTEND_CONTENT_SITE.nextval, iLinsertFCId, 10, 'Y');
		INSERT INTO ya_frontend_content_site (id, frontend_content_id, site_id,  is_enabled) values (SEQ_YA_FRONTEND_CONTENT_SITE.nextval, iLinsertFCId, 13, 'Y');
		INSERT INTO ya_frontend_content_site (id, frontend_content_id, site_id,  is_enabled) values (SEQ_YA_FRONTEND_CONTENT_SITE.nextval, iLinsertFCId, 14, 'Y');
		INSERT INTO ya_frontend_content_site (id, frontend_content_id, site_id,  is_enabled) values (SEQ_YA_FRONTEND_CONTENT_SITE.nextval, iLinsertFCId, 15, 'Y');
		INSERT INTO ya_frontend_content_site (id, frontend_content_id, site_id,  is_enabled) values (SEQ_YA_FRONTEND_CONTENT_SITE.nextval, iLinsertFCId, 18, 'Y');

        OPEN curLstaticContentLang FOR
        select title, content, case when locale = 'en' then 1 when locale = 'zh_TW' then 2 when locale = 'zh_CN' then 5 end as lang_id from static_content_lang where content_id = iLstaticContentId AND LOCALE IN ('en', 'zh_TW', 'zh_CN');

        FETCH curLstaticContentLang INTO cLtitle, cLcontent, cLlangId;
          WHILE curLstaticContentLang%FOUND LOOP
            BEGIN

              INSERT INTO ya_frontend_content_lang (id, frontend_content_id, lang_id, site_id, title, content)
              VALUES (SEQ_CONTENT_LANG.nextval, iLinsertFCId, cLlangId, null, cLtitle, cLcontent);

            END;
            FETCH curLstaticContentLang INTO cLtitle, cLcontent, cLlangId;
          END LOOP;
      END;
      FETCH curLstaticContent INTO iLstaticContentId;
    END LOOP;

    IF sqlcode = 0 THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END CopySCToFC;

END PKG_FE_STATICCONTENTDATAACCESS;
/
