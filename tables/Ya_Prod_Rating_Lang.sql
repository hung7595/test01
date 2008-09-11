DROP TABLE Ya_Prod_Rating_Lang
/

CREATE TABLE Ya_Prod_Rating_Lang (
	rating_id                        int                       NOT NULL ,
	lang_id                          int                       NOT NULL ,
	title                            varchar2(200)             ,
	us_review_id                     int                       ,
	hk_review_id                     int                       ,
	jp_review_id                     int                       ,
	tw_review_id                     int                       ,
	preferred_flag                   char(1)                   ,
	rowguid                          varchar2(50)              DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Prod_Rating_Lang
ADD CONSTRAINT PK_Prod_Rating_Lang PRIMARY KEY (rating_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Prod_Rating_Lang_01 ON Ya_Prod_Rating_Lang(us_review_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Prod_Rating_Lang_02 ON Ya_Prod_Rating_Lang(rowguid) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Prod_Rating_Lang_03 ON Ya_Prod_Rating_Lang(rating_id, us_review_id, lang_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Rating_Lang FOR Ya_Prod_Rating_Lang
/


create or replace TRIGGER TRI_prod_rating_lang
BEFORE INSERT OR UPDATE OF preferred_flag
ON ya_prod_rating_lang
FOR EACH ROW
BEGIN
	:NEW.preferred_flag := UPPER(:NEW.preferred_flag);
END;