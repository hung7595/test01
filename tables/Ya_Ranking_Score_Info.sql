DROP TABLE Ya_Ranking_Score_Info
/

CREATE TABLE Ya_Ranking_Score_Info (
	score_type                       int                           NOT NULL ,
	last_calculation_time            date                          ,
	is_running                       varchar2(1)                   DEFAULT 'N' NOT NULL ,
	error_msg                        varchar2(120)                 ,
	mod_dt                           date                          NOT NULL
)	
/

ALTER TABLE Ya_Ranking_Score_Info
ADD CONSTRAINT PK_Ranking_Score_Info PRIMARY KEY (score_type)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Ranking_Score_Info FOR Ya_Ranking_Score_Info
/