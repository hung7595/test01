DROP TABLE Ya_Survey
/

CREATE TABLE Ya_Survey (
    id           int             NOT NULL ,
    site_id      int             NOT NULL ,
    name         varchar2(400)   ,
    start_dt     date            NOT NULL , 
    end_dt       date            NOT NULL , 
    year         int
)
/

ALTER TABLE Ya_Survey
ADD CONSTRAINT PK_Survey PRIMARY KEY(id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Survey FOR Ya_Survey
/
