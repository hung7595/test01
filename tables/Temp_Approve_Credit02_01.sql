DROP TABLE Temp_Approve_Credit02_01
/

CREATE GLOBAL TEMPORARY TABLE Temp_Approve_Credit02_01 (
	id                        int                 NOT NULL,
	cust_id                   nvarchar2(100)      NOT NULL,
	link_id                   int                 NOT NULL,
	origin_order_id           nvarchar2(100)      NOT NULL,
	row_id                    int                 NOT NULL,
	credit_amount             number(18,2)        ,
	qnty                      int                 NOT NULL,
	unit_price                number(18,2)        NOT NULL
) ON COMMIT PRESERVE ROWS
/


CREATE INDEX IX_Temp_Approve_Credit02_01_01 ON Temp_Approve_Credit02_01
    (
      id,
      sku
    ) 
/

CREATE INDEX IX_Temp_Approve_Credit02_01_02 ON Temp_Approve_Credit02_01
    (
      link_id
    )
/

CREATE INDEX IX_Temp_Approve_Credit02_01_03 ON Temp_Approve_Credit02_01
    (
      cust_id
    )
/
