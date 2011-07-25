DROP TABLE Ya_Artist_Deleted
/

CREATE TABLE Ya_Artist_Deleted (
	artist_id                   number(10)                  NOT NULL ,
	status                      number(10)                  NOT NULL ,
	fullname                    nvarchar2(255)              ,        
	lastname                    nvarchar2(255)              ,        
	firstname                   nvarchar2(255)              ,        
	created_date                date                        NOT NULL ,
	updated_date                date                        NOT NULL 
)
/

ALTER TABLE Ya_Artist_Deleted
ADD CONSTRAINT PK_Artist_Deleted PRIMARY KEY (artist_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Artist_Deleted FOR Ya_Artist_Deleted
/