DROP TABLE Ya_Survey_Answer2
/

CREATE TABLE Ya_Survey_Answer2 (
    id                          int              NOT NULL , 
    survey_question_id          int              NOT NULL , 
    parent_survey_answer_id     int              ,
    priority                    int              NOT NULL ,
    asset_key                   varchar2(100)    NOT NULL 
)
/

ALTER TABLE Ya_Survey_Answer2
ADD CONSTRAINT PK_Survey_Answer2 PRIMARY KEY(id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Survey_Answer2 FOR Ya_Survey_Answer2
/
