DROP TABLE Country_Group   
/

CREATE TABLE Country_Group (
	set_id                     int                         NOT NULL ,
	country_id                 int                         NOT NULL ,
	country_group_id           int                         ,
	country_group              nvarchar2(100) 
)
/

ALTER TABLE Country_Group
ADD CONSTRAINT PK_Country_Group PRIMARY KEY (set_id, country_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Country_Group FOR Country_Group
/