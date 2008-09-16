/* Reference to ss_adm package PKG_FE_DESIGNERACCESS */
CREATE OR REPLACE PACKAGE PKG_FE_DESIGNERACCESS
AS
  TYPE refCur IS REF CURSOR;
  
  PROCEDURE GetDesignersByPublisherId(
    iPpublisher_id IN INT,
	iPlang_id IN INT,
    curPresult OUT refcur    
  );
  
END PKG_FE_DESIGNERACCESS;
/

CREATE OR REPLACE PACKAGE BODY PKG_FE_DESIGNERACCESS
AS
  
  PROCEDURE GetDesignersByPublisherId (
    iPpublisher_id IN INT,
	iPlang_id IN INT,
    curPresult OUT refcur  
  )
  AS
  BEGIN  
    OPEN curPresult FOR
		select dl.designer_name, dl.publisher_bg_url, dl.designer_icon_url
		from ya_publisher_designer pd, ya_designer_lang dl 
		where pd.designer_id = dl.designer_id 
		and dl.lang_id = iPlang_id 
		and pd.publisher_id = iPpublisher_id ;
    RETURN;
    
  END GetDesignersByPublisherId;
  
END PKG_FE_DESIGNERACCESS;
/

