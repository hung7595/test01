DROP TABLE Temp_Approve_Credit02
/

CREATE GLOBAL TEMPORARY TABLE Temp_Approve_Credit02 (
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

ALTER TABLE Temp_Approve_Credit02
ADD CONSTRAINT PK_Temp_Approve_Credit02 PRIMARY KEY (link_id, origin_order_id, row_id)
/

CREATE INDEX IX_Temp_Approve_Credit02_02 ON Temp_Approve_Credit02
    (
      id
    )
/

