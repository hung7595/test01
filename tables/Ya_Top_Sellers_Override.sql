DROP TABLE Ya_Top_Sellers_Override
/

CREATE TABLE Ya_Top_Sellers_Override (
	rank                   int                  NOT NULL ,
	site_id                int                  NOT NULL ,
	sku                    int                  NOT NULL ,
	dept_id                int                  NOT NULL
)	
/

ALTER TABLE Ya_Top_Sellers_Override
ADD CONSTRAINT PK_Top_Sellers_Override PRIMARY KEY (rank, site_id, dept_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Top_Sellers_Override_01 ON Ya_Top_Sellers_Override(sku, site_id, rank) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Top_Sellers_Override FOR Ya_Top_Sellers_Override
/