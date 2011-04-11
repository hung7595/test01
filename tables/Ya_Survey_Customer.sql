DROP TABLE Ya_Survey_Customer
/

CREATE TABLE Ya_Survey_Customer (
    id               int               NOT NULL , 
    survey_id        int               NOT NULL , 
    shopper_id       varchar2(32)      , 
    email            varchar2(255)     ,
    create_dt        date NOT NULL     ,
    mod_dt           date NOT NULL     ,
    answer_dt        date NOT NULL
)
/

ALTER TABLE Ya_Survey_Customer
ADD CONSTRAINT PK_Survey_Customer PRIMARY KEY(id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Survey_Customer FOR Ya_Survey_Customer
/
