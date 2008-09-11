DROP TABLE Ya_Review_Shadow
/

CREATE TABLE Ya_Review_Shadow (
	id                                int                             NOT NULL ,
	sku                               int                             ,
	site_name                         varchar2(10)                    ,
	rating_id                         int                             ,
	lang_id                           int                             ,
	review_id                         int                             ,
	review                            clob                            ,
	review_img_loc                    varchar2(200)                   ,
	review_img_width                  int                             ,
	review_img_height                 int                             ,
	preferred_flag                    char(1)
)	
/

ALTER TABLE Ya_Review_Shadow
ADD CONSTRAINT PK_Review_Shadow PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Review_Shadow FOR Ya_Review_Shadow
/


create or replace TRIGGER TRI_review_shadow
BEFORE INSERT OR UPDATE OF preferred_flag
ON ya_review_shadow
FOR EACH ROW
BEGIN
	:NEW.preferred_flag := UPPER(:NEW.preferred_flag);
END;