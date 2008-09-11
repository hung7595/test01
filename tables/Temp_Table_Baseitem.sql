DROP TABLE Temp_Table_Baseitem
/

CREATE GLOBAL TEMPORARY TABLE Temp_Table_Baseitem (
	sku                        int                      ,
	release_date               date                     ,
	us_cansell                 char(1)                  ,
	us_enabled                 char(1)                  ,
	tw_cansell                 char(1)                  ,
	tw_enabled                 char(1)                  ,
	us_launch_date             date                     ,
	tw_launch_date             date                     ,
	us_priority                int                      ,
	tw_priority                int                      ,
	adult_sku                  int                      ,
	is_parent                  char(1)                  ,
	us_sales                   int                      ,
	tw_sales                   int                      ,
	us_rank                    float(126)               ,
	tw_rank                    float(126)               ,
	prod_name                  varchar2(300)
	num_children               int
) ON COMMIT PRESERVE ROWS
/

CREATE INDEX IX_Temp_Table_Baseitem_1 ON Temp_Table_Baseitem (sku)
/