DROP TABLE SKLam_Searchable_sku   
/

CREATE TABLE SKLam_Searchable_sku (
	sku                   int                         NOT NULL ,
	account_id            int                         NOT NULL
)
/

ALTER TABLE SKLam_Searchable_sku
ADD CONSTRAINT PK_SKLam_Searchable_sku PRIMARY KEY (sku, account_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/