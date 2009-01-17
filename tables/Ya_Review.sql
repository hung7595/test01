DROP TABLE Ya_Review
/

CREATE TABLE Ya_Review (
	review_id                       int                             NOT NULL ,
	review                          clob                            ,
	review_img_loc                  varchar2(200)                   ,
	review_img_width                int                             ,
	review_img_height               int                             ,
	rowguid                         varchar2(50)                    DEFAULT SYS_GUID() NOT NULL
)	
/

ALTER TABLE Ya_Review
ADD CONSTRAINT PK_Review PRIMARY KEY (review_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Review_01 ON Ya_Review(rowguid) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Review_02 ON Ya_Review(CASE WHEN REVIEW IS NOT NULL THEN REVIEW_ID ELSE NULL END ) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Review_03 ON Ya_Review(CASE WHEN REVIEW IS NOT NULL THEN 'Y' ELSE NULL END ) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Review_04 ON Ya_Review(CASE WHEN LENGTH("REVIEW_IMG_LOC")>0 THEN 'Y' ELSE NULL END ) TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Review FOR Ya_Review
/