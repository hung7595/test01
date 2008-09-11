DROP TABLE Ya_Rev_Account_Group
/

CREATE TABLE Ya_Rev_Account_Group (
	definition_id                   int                   NOT NULL ,
	product_category_id             int                   NOT NULL ,
	rev_account_id                  int                   NOT NULL
)	
/

ALTER TABLE Ya_Rev_Account_Group
ADD CONSTRAINT PK_Rev_Account_Group PRIMARY KEY (product_category_id, rev_account_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Rev_Account_Group FOR Ya_Rev_Account_Group
/