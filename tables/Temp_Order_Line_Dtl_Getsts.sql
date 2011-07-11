DROP TABLE Temp_Order_Line_Dtl_Getsts
/

CREATE GLOBAL TEMPORARY TABLE Temp_Order_Line_Dtl_Getsts (
	order_line_id            int                 NOT NULL,   
	cust_id                  nvarchar2(100)      NOT NULL,
	credit_amount            NUMBER(18,2)        ,
	link_id                  int                 NOT NULL,
	origin_order_id          int                 NOT NULL,
	row_id                   int                 ,        
	qnty                     int                 NOT NULL,
	unit_price               number(12,2)        NOT NULL	
) ON COMMIT PRESERVE ROWS
/


CREATE INDEX IX_Temp_Order_Line_Dtl_Getsts ON Temp_Order_Line_Dtl_Getsts
    (
      link_id,
      origin_order_id,
      row_id
    ) 
/
