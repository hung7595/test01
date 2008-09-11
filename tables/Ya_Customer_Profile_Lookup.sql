DROP TABLE Ya_Customer_Profile_Lookup
/

CREATE TABLE Ya_Customer_Profile_Lookup (
	lookup_id              number                         not null ,
	meaning                nvarchar2(255)                 not null 
)
/

ALTER TABLE Ya_Customer_Profile_Lookup
ADD CONSTRAINT PK_Customer_Profile_Lookup PRIMARY KEY (lookup_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Customer_Profile_Lookup FOR Ya_Customer_Profile_Lookup
/