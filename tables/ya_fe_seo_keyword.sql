CREATE TABLE Ya_Fe_Seo_Keyword 
(
	id                int                 NOT NULL ,
	text              nvarchar2(128)      ,
	lang_id           int                 NOT NULL ,
	enable            int                 NOT NULL ,
	note              nvarchar2(512)      ,
	last_update       date NOT NULL       ,
	last_update_user  nvarchar2(24)
) 
/

ALTER TABLE Ya_Fe_Seo_Keyword  ADD 
CONSTRAINT PK_Ya_Fe_Seo_Keyword PRIMARY KEY  (id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Fe_Seo_Keyword  FOR Ya_Fe_Seo_Keyword 
/


