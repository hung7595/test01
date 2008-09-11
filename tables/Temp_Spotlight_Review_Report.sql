DROP TABLE Temp_Spotlight_Review_Report
/

CREATE GLOBAL TEMPORARY TABLE Temp_Spotlight_Review_Report (
	id                           int                    NOT NULL ,
	positive                     int                    DEFAULT 0 NOT NULL ,
	total                        int                    DEFAULT 0 NOT NULL ,
	perc                         int                    DEFAULT 0 NOT NULL ,
	sku                          int                    NOT NULL ,
	prod_name_u                  nvarchar2(300)         ,
	date_posted                  date                   ,
	review_id                    int                    ,
	review                       clob                   ,
	reviewer                     nvarchar2(100)         ,
	shopper_id                   char(32)               ,
	email                        varchar2(255)          ,
	rating_id                    int                    ,
	title                        varchar2(200)          ,
	status                       nvarchar2(50)          ,
	lang_id                      int                    ,
	reviewer_type                varchar2(100)
	PRIMARY KEY (id)
) ON COMMIT PRESERVE ROWS
/