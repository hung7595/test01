DROP TABLE Ya_Survey_Customer_Answer
/

CREATE TABLE Ya_Survey_Customer_Answer (
    id                    int              NOT NULL , 
    survey_customer_id    int              NOT NULL , 
    survey_question_id    int              NOT NULL , 
    survey_answer_id      int              ,
    priority              int              , 
    answer                varchar2(2048) 
)
/

ALTER TABLE Ya_Survey_Customer_Answer
ADD CONSTRAINT PK_Survey_Customer_Answer PRIMARY KEY(id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Survey_Customer_Answer FOR Ya_Survey_Customer_Answer
/
