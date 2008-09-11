DROP TABLE Ya_Ranking_Score
/

CREATE TABLE Ya_Ranking_Score (
	prod_id                    int                          NOT NULL ,
	site_id                    int                          NOT NULL ,
	score_type                 int                          NOT NULL ,
	score                      number(18,2)                 ,
	create_dt                  date                         NOT NULL
)	
/

ALTER TABLE Ya_Ranking_Score
ADD CONSTRAINT PK_Ranking_Score PRIMARY KEY (prod_id, site_id, score_type, create_dt)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Ranking_Score_01 ON Ya_Ranking_Score(prod_id, site_id, score_type) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Ranking_Score FOR Ya_Ranking_Score
/