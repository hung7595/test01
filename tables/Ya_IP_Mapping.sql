DROP TABLE Ya_IP_Mapping
/

CREATE TABLE Ya_IP_Mapping (
	start_ip_num                number(18)            NOT NULL ,
	end_ip_num                  number(18)            NOT NULL ,
	country_id                  int                   NOT NULL
)
/

ALTER TABLE Ya_IP_Mapping
ADD CONSTRAINT PK_IP_Mapping PRIMARY KEY (start_ip_num, end_ip_num)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_IP_Mapping FOR Ya_IP_Mapping
/