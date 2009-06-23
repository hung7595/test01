Drop Table Ya_Brand_Review
/

CREATE TABLE Ya_Brand_Review (
	id                        int                 NOT NULL ,
	brand_id                  int                 NOT NULL ,
	site_id                   int                 NOT NULL ,
	title                     varchar2(200)       NOT NULL ,
	date_posted               date                NOT NULL ,
	shopper_id                char(32)            NOT NULL ,
	review_approved           char(1)             NOT NULL ,
	lang_id                   number(38)          NOT NULL ,
	review                    nclob               NOT NULL ,
	reviewer_type             varchar2(100)       NOT NULL ,
	mod_user                  varchar2(50)        NOT NULL ,
	mod_dt                    date                NOT NULL	
)
/

ALTER TABLE Ya_Brand_Review
ADD CONSTRAINT PK_Brand_Review PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Brand_Review FOR Ya_Brand_Review
/