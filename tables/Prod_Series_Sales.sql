DROP TABLE Prod_Series_Sales   
/

CREATE TABLE Prod_Series_Sales (
	prod_id                   int                ,
	site_id                   int                ,
	sale_qnty                 int                NOT NULL ,
	mod_dt                    date  
)
/


CREATE PUBLIC SYNONYM Prod_Series_Sales FOR Prod_Series_Sales
/