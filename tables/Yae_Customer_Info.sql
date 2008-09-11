DROP TABLE Ya_Customer_Info
/

CREATE TABLE Yae_Customer_Info (
	id                            number                         NOT NULL ,
	customer_name                 varchar2(100)                  NOT NULL ,
	address                       varchar2(500)                  NOT NULL ,
	city                          varchar2(50)                   NOT NULL ,
	state                         varchar2(50)                   NOT NULL ,
	zip                           varchar2(50)                   NOT NULL ,
	created_datetime              date                           NOT NULL ,
	email                         varchar2(100)                  NOT NULL
)
/

ALTER TABLE Yae_Customer_Info
ADD CONSTRAINT PK_Customer_Info PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Customer_Info FOR Ya_Customer_Info
/