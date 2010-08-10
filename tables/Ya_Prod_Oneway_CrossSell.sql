Drop Table Ya_Prod_Oneway_CrossSell
/

CREATE TABLE Ya_Prod_Oneway_CrossSell (
	host_sku               int                NOT NULL ,
	dependence_sku         int                NOT NULL ,
	priority               int                NOT NULL ,
	mod_user               varchar2(50)       NOT NULL ,
	mod_dt                 date               NOT NULL
)
/

ALTER TABLE Ya_Prod_Oneway_CrossSell
ADD CONSTRAINT PK_Prod_Oneway_Cross_Sell PRIMARY KEY (host_sku, dependence_sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Oneway_CrossSell FOR Ya_Prod_Oneway_CrossSell
/
