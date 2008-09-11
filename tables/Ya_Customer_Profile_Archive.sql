DROP TABLE Ya_Customer_Profile_Archive
/

CREATE TABLE Ya_Customer_Profile_Archive (
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

ALTER TABLE Ya_Customer_Profile_Archive
ADD CONSTRAINT PK_Customer_Profile_Archive PRIMARY KEY (shopper_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/