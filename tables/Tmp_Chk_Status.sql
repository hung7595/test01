DROP TABLE Tmp_Chk_Status
/

CREATE TABLE Tmp_Chk_Status (
	link_id                      number(10)                NOT NULL ,
	origin_order_id              varchar2(50)              NOT NULL ,
	row_id                       number(10)                NOT NULL ,
	credit_status                number(10)                NOT NULL
)
/