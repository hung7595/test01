DROP TABLE Ya_Email_Shopper_Sub_Artist
/

CREATE TABLE Ya_Email_Shopper_Sub_Artist (
	shopper_id                  varchar2(50)                 NOT NULL ,
	artist_id                   int                          NOT NULL ,
	pref_id                     int                          NOT NULL ,
	rowguid                     varchar2(50)                 DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Email_Shopper_Sub_Artist
ADD CONSTRAINT PK_Email_Shopper_Sub_Artist PRIMARY KEY (shopper_id, artist_id, pref_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Email_Shopper_Sub_Artist FOR Ya_Email_Shopper_Sub_Artist
/