DROP TABLE Ya_Article
/

CREATE TABLE Ya_Article (
	article_id                    number(10)                     NOT NULL ,
	product_group_sku             number(10)                     ,
	in_tracking_no                varchar2(50)                   ,
	out_tracking_no               varchar2(50)                   ,
	status                        number(10)                     NOT NULL ,
	enable                        char(1)                        NOT NULL ,
	created_user                  varchar2(50)                   NOT NULL ,
	created_date                  date                           NOT NULL ,
	updated_user                  varchar2(50)                   NOT NULL ,
	updated_date                  date                           NOT NULL ,
	is_ya_us_enabled              varchar2(1)                    DEFAULT 'Y' NOT NULL ,
	is_ya_gb_enabled              varchar2(1)                    DEFAULT 'Y' NOT NULL ,
	is_ys_gb_enabled              varchar2(1)                    DEFAULT 'Y' NOT NULL
	
)
/

ALTER TABLE Ya_Article
ADD CONSTRAINT PK_Article PRIMARY KEY (article_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Article_01 ON Ya_Article(updated_date, enable, article_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Article FOR Ya_Article
/


create or replace TRIGGER TRI_article
BEFORE INSERT OR UPDATE OF enable
ON ya_article
FOR EACH ROW
BEGIN
	:NEW.enable := UPPER(:NEW.enable);
END;