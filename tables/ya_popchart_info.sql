----  ya_popchart_info
CREATE TABLE ya_popchart_info (
 id            INT NOT NULL,
 file_id       INT NOT NULL , 
 start_dt      DATE NOT NULL ,
 end_dt        DATE NOT NULL
); 

ALTER TABLE ya_popchart_info
ADD CONSTRAINT PK_ya_popchart_info PRIMARY KEY (id);

ALTER INDEX PK_ya_popchart_info rebuild tablespace sscommerceserver_index;

CREATE PUBLIC SYNONYM ya_popchart_info FOR ss_adm.ya_popchart_info;

GRANT select ON ya_popchart_info to v5_web;