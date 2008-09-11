DROP TABLE Ya_Themestore_Vote
/

CREATE TABLE Ya_Themestore_Vote (
	vote_id                     int                        NOT NULL ,
	themestore_id               int                        NOT NULL ,
	item_id                     int                        ,
	us_sku                      int                        ,
	gb_sku                      int                        ,
	created_by                  nvarchar2(100)             ,
	created_datetime            date
)	
/

ALTER TABLE Ya_Themestore_Vote
ADD CONSTRAINT PK_Themestore_Vote PRIMARY KEY (vote_id, item_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Themestore_Vote FOR Ya_Themestore_Vote
/