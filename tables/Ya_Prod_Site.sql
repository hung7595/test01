DROP TABLE Ya_Prod_Site
/

CREATE TABLE Ya_Prod_Site (
	logid                              int                           NOT NULL ,
	sku                                int                           NOT NULL ,
	siteid                             int                           NOT NULL ,
	logdatetime                        date                          ,
	logmessage                         nvarchar2(1000)
)
/

ALTER TABLE Ya_Prod_Site
ADD CONSTRAINT PK_Prod_Site PRIMARY KEY (siteid, sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Prod_Site_01 ON Ya_Prod_Site(sku, site_id, product_edit_status) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Site FOR Ya_Prod_Site
/


create or replace TRIGGER TRI_prod_site
BEFORE INSERT OR UPDATE OF Product_Edit_Status
ON ya_prod_site
FOR EACH ROW
BEGIN
	:NEW.Product_Edit_Status := UPPER(:NEW.Product_Edit_Status);
END;