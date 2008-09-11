DROP TABLE Temp_Table_Baseitem_Tmp
/

CREATE TABLE Temp_Table_Baseitem_Tmp (
	sku                        number                   ,
	release_date               date                     ,
	us_cansell                 char(1)                  ,
	us_enabled                 char(1)                  ,
	tw_cansell                 char(1)                  ,
	tw_enabled                 char(1)                  ,
	ys_cansell                 char(1)                  ,
	ys_enabled                 char(1)                  ,
	us_launch_date             date                     ,
	tw_launch_date             date                     ,
	ys_launch_date             date                     ,
	us_priority                number                   ,
	tw_priority                number                   ,
	ys_priority                number                   ,
	adult_sku                  number                   ,
	is_parent                  char(1)                  ,
	us_sales                   number                   ,
	tw_sales                   number                   ,
	ys_sales                   number                   ,
	us_rank                    float(126)               ,
	tw_rank                    float(126)               ,
	ys_rank                    float(126)               ,
	prod_name                  varchar2(300)            ,
	num_children               number	
)
/

CREATE INDEX IX_Temp_Table_Baseitem_Tmp_1 ON Temp_Table_Baseitem_Tmp (sku) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Temp_Table_Baseitem_Tmp FOR Temp_Table_Baseitem_Tmp
/