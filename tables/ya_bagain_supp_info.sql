DROP TABLE ya_bagain_supp_info
/

CREATE TABLE ya_bagain_supp_info (
  site_id int not null ,
  dept_id int not null ,
  prod_count int null,
  max_discount number(9,2) null,
  updated_date date null
) 
/


CREATE PUBLIC SYNONYM ya_bagain_supp_info FOR ya_bagain_supp_info;
