DROP TABLE Bu_Del_Ya_Shopper   
/

CREATE TABLE Bu_Del_Ya_Shopper (
	shopper_id                   char(32)                      NOT NULL ,
	created_date                 date                          ,
	password                     varchar2(255)                 ,
	email                        varchar2(255)                 NOT NULL ,
	firstname                    varchar2(60)                  ,
	lastname                     varchar2(100)                 ,
	username                     varchar2(100)                 ,
	nickname                     varchar2(50)                  ,
	member_type                  int                           ,
	credit_accumulated           number(18,2)                  ,
	preferred_lang_id            int                           ,
	secret_question              varchar2(100)                 ,
	secret_answer                varchar2(100)                 ,
	income_level                 int                           ,
	education_level              int                           ,
	shopper_occupation           int                           ,
	dob                          date                          ,
	ethnicity                    int                           ,
	credit_rating                int                           ,
	anonymous                    char(1)                       ,
	salt                         varchar2(20)                  ,
	ae_id                        int                           ,
	rowguid                      varchar2(50)                  NOT NULL
)
/