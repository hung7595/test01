DROP TABLE Ya_Review_Summary
/

CREATE TABLE Ya_Review_Summary (
	site_id                               int                 NOT NULL ,
	sku                                   int                 NOT NULL ,
	lang_id                               int                 NOT NULL ,
	weighted_count                        int                 NOT NULL ,
	actual_count                          int                 NOT NULL ,
	average_rating                        number(18,2)        NOT NULL ,
	last_n_day_count                      int                 NOT NULL ,
	last_updated_datetime                 date                NOT NULL
)	
/

ALTER TABLE Ya_Review_Summary
ADD CONSTRAINT PK_Review_Summary PRIMARY KEY (site_id, sku, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Review_Summary_01 ON Ya_Review_Summary(sku, site_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Review_Summary FOR Ya_Review_Summary
/