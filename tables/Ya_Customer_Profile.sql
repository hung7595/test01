DROP TABLE Ya_Customer_Profile
/

CREATE TABLE Ya_Customer_Profile (
	shopper_id                     char(32)            NOT NULL ,
	birthday                       date                ,
	education_level                number              ,
	annual_income                  number              ,
	gender                         number              ,
	ethnicity                      number              ,
	residence_place                number              ,
	register_site_id               number              ,
	created_datetime               date                ,
	updated_datetime               date	
)
/

ALTER TABLE Ya_Customer_Profile
ADD CONSTRAINT PK_Customer_Profile PRIMARY KEY (shopper_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Customer_Profile_01 ON Ya_Customer_Profile(shopper_id, register_site_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Customer_Profile FOR Ya_Customer_Profile
/