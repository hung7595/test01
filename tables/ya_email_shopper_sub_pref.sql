DROP TABLE ya_email_shopper_sub_pref
/

CREATE TABLE ya_email_shopper_sub_pref (
	shopper_subscribe_id	int NOT NULL ,
	shopper_id		char(32) NOT NULL ,
	site_id			int DEFAULT 7 NOT NULL ,
	lang_pref		int DEFAULT 1 NOT NULL ,
	choice_pref		int DEFAULT 0 NOT NULL ,
	rowguid			varchar(50) DEFAULT SYS_GUID() NOT NULL ,
	format_pref		int NOT NULL ,
	subtitle_pref		int NOT NULL
) 
/

ALTER TABLE ya_email_shopper_sub_pref
ADD CONSTRAINT PK_email_shopper_sub_pref PRIMARY KEY (shopper_subscribe_id)
USING INDEX TABLESPACE SSCommerceServer_Index
/

CREATE INDEX IX_email_shopper_sub_pref ON ya_email_shopper_sub_pref (choice_pref) TABLESPACE SSCommerceServer_Index
/
