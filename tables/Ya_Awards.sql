DROP TABLE Ya_Awards
/

CREATE TABLE Ya_Awards (
	award_id                       int                     NOT NULL ,
	sku                            int                     NOT NULL ,
	award_name                     varchar2(4000)          ,
	award_category                 varchar2(4000)          ,
	award_year                     int                     ,
	award_status_type              int
)
/

ALTER TABLE Ya_Awards
ADD CONSTRAINT PK_Awards PRIMARY KEY (sku, award_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Awards FOR Ya_Awards
/