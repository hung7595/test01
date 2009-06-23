Drop Table Ya_Customer_Review
/

CREATE TABLE Ya_Customer_Review (
	id                          int                 NOT NULL ,
	sku                         int                 NOT NULL ,
	site_id                     int                 NOT NULL ,
	title                       varchar2(200)       NOT NULL ,
	product_rating              int                 NOT NULL ,
	date_posted                 date                NOT NULL ,
	shopper_id                  char(32)            NOT NULL ,
	review_approved             char(1)             NOT NULL ,
	lang_id                     int                 NOT NULL ,
	review                      nclob               NOT NULL ,
	reviewer_type               number              NOT NULL ,
	mod_user                    varchar2(50)        NOT NULL ,
	mod_dt                      date                NOT NULL	
)
/

ALTER TABLE Ya_Customer_Review
ADD CONSTRAINT PK_Customer_Review PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Customer_Review_01 ON Ya_Customer_Review(date_posted, reviewer_type, review_approved) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Customer_Review_02 ON Ya_Customer_Review(sku, shopper_id) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Customer_Review_03 ON Ya_Customer_Review(id, reviewer_type, review_approved) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Customer_Review_04 ON Ya_Customer_Review(shopper_id, review_approved, reviewer_type) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Customer_Review_05 ON Ya_Customer_Review(sku, reviewer_type, review_approved) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Customer_Review_06 ON Ya_Customer_Review(date_posted, reviewer_type, review_approved, sku) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Customer_Review_07 ON Ya_Customer_Review(id, lang_id, review_approved) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Customer_Review FOR Ya_Customer_Review
/