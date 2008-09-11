DROP TABLE Ya_Product_Artist
/

CREATE TABLE Ya_Product_Artist (
	sku                              int                        NOT NULL ,
	artist_id                        int                        NOT NULL ,
	rel_id                           int                        NOT NULL ,
	created_date                     date                       ,
	updated_date                     date                       ,
	created_user                     varchar2(20)               ,
	updated_user                     varchar2(20)               ,
	show_in_browse                   char(1)                    ,
	us_enabled                       char(1)                    ,
	hk_enabled                       char(1)                    ,
	jp_enabled                       char(1)                    ,
	tw_enabled                       char(1)                    ,
	us_ws_enabled                    char(1)                    ,
	hk_ws_enabled                    char(1)                    ,
	jp_ws_enabled                    char(1)                    ,
	tw_ws_enabled                    char(1)                    ,
	rel_ranking                      int
)
/

ALTER TABLE Ya_Product_Artist
ADD CONSTRAINT PK_Product_Artist PRIMARY KEY (sku, artist_id, rel_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Product_Artist_01 ON Ya_Product_Artist(artist_id, sku, show_in_browse, us_enabled) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_Artist_02 ON Ya_Product_Artist(artist_id, sku, show_in_browse, tw_enabled) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Product_Artist_03 ON Ya_Product_Artist(artist_id, sku, rel_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Artist FOR Ya_Product_Artist
/


create or replace TRIGGER TRI_product_artist_1
BEFORE INSERT OR UPDATE OF jp_enabled
ON ya_product_artist
FOR EACH ROW
BEGIN
	:NEW.jp_enabled := UPPER(:NEW.jp_enabled);
END;

create or replace TRIGGER TRI_product_artist_2
BEFORE INSERT OR UPDATE OF tw_enabled
ON ya_product_artist
FOR EACH ROW
BEGIN
	:NEW.tw_enabled := UPPER(:NEW.tw_enabled);
END;

create or replace TRIGGER TRI_product_artist_3
BEFORE INSERT OR UPDATE OF us_ws_enabled
ON ya_product_artist
FOR EACH ROW
BEGIN
	:NEW.us_ws_enabled := UPPER(:NEW.us_ws_enabled);
END;

create or replace TRIGGER TRI_product_artist_4
BEFORE INSERT OR UPDATE OF hk_ws_enabled
ON ya_product_artist
FOR EACH ROW
BEGIN
	:NEW.hk_ws_enabled := UPPER(:NEW.hk_ws_enabled);
END;

create or replace TRIGGER TRI_product_artist_5
BEFORE INSERT OR UPDATE OF jp_ws_enabled
ON ya_product_artist
FOR EACH ROW
BEGIN
	:NEW.jp_ws_enabled := UPPER(:NEW.jp_ws_enabled);
END;

create or replace TRIGGER TRI_product_artist_6
BEFORE INSERT OR UPDATE OF tw_ws_enabled
ON ya_product_artist
FOR EACH ROW
BEGIN
	:NEW.tw_ws_enabled := UPPER(:NEW.tw_ws_enabled);
END;

create or replace TRIGGER TRI_product_artist_7
BEFORE INSERT OR UPDATE OF show_in_browse
ON ya_product_artist
FOR EACH ROW
BEGIN
	:NEW.show_in_browse := UPPER(:NEW.show_in_browse);
END;

create or replace TRIGGER TRI_product_artist_9
BEFORE INSERT OR UPDATE OF hk_enabled
ON ya_product_artist
FOR EACH ROW
BEGIN
	:NEW.hk_enabled  := UPPER(:NEW.hk_enabled);
END;

create or replace TRIGGER TRI_product_artist_10
BEFORE INSERT OR UPDATE OF us_enabled
ON ya_product_artist
FOR EACH ROW
BEGIN
 :NEW.us_enabled  := UPPER(:NEW.us_enabled);
END;