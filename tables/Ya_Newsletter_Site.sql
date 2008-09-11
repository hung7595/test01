DROP TABLE Ya_Newsletter_Site
/

CREATE TABLE Ya_Newsletter_Site (
	newsletter_id                int                      NOT NULL ,
	site_id                      int                      NOT NULL ,
	site_enabled                 char(1)                  NOT NULL
)
/

ALTER TABLE Ya_Newsletter_Site
ADD CONSTRAINT PK_Newsletter_Site PRIMARY KEY (newsletter_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Newsletter_Site FOR Ya_Newsletter_Site
/


create or replace TRIGGER TRI_newsletter_site  
BEFORE INSERT OR UPDATE OF site_enabled        
ON ya_newsletter_site                          
FOR EACH ROW                                   
BEGIN                                          
	:NEW.site_enabled := UPPER(:NEW.site_enabled);
END;                                           