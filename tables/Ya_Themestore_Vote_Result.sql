DROP TABLE Ya_Themestore_Vote_Result
/

CREATE TABLE Ya_Themestore_Vote_Result (
	vote_id                    int                        NOT NULL ,
	item_id                    int                        NOT NULL ,
	result_count               int                        ,
	last_update                date
)	
/

ALTER TABLE Ya_Themestore_Vote_Result
ADD CONSTRAINT PK_Themestore_Vote_Result PRIMARY KEY (vote_id, item_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Themestore_Vote_Result FOR Ya_Themestore_Vote_Result
/