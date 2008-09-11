DROP TABLE Ya_Prod_Printed
/

CREATE TABLE Ya_Prod_Printed (
	sku                              int                       NOT NULL ,
	paper_type                       varchar2(50)              ,
	pages                            varchar2(20)              ,
	isbn                             varchar2(30)              ,
	current_issue                    varchar2(20)              ,
	num_of_issues                    int                       ,
	can_subscribe                    char(1)                   ,
	format                           int                       ,
	edition                          int                       ,
	edition_number                   varchar2(200)             ,
	volume_number                    varchar2(30)              ,
	grade_from                       int                       ,
	grade_to                         int                       ,
	release_status                   int                       ,
	reference_price                  number(18,2)              ,
	reference_currency               varchar2(20)              ,
	condition                        int                       ,
	print_number                     int
)
/

ALTER TABLE Ya_Prod_Printed
ADD CONSTRAINT PK_Prod_Printed PRIMARY KEY (sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Printed FOR Ya_Prod_Printed
/


create or replace TRIGGER TRI_prod_printed
BEFORE INSERT OR UPDATE OF can_subscribe
ON ya_prod_printed
FOR EACH ROW
BEGIN
	:NEW.can_subscribe := UPPER(:NEW.can_subscribe);
END;