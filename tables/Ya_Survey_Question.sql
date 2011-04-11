DROP TABLE Ya_Survey_Question
/

CREATE TABLE Ya_Survey_Question (
    id            int              NOT NULL , 
    survey_id     int              NOT NULL , 
    priority      int              NOT NULL , 
    asset_key     varchar2(100)    NOT NULL 
)
/

ALTER TABLE Ya_Survey_Question
ADD CONSTRAINT PK_Survey_Question PRIMARY KEY(id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Survey_Question FOR Ya_Survey_Question
/
