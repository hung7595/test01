DROP TABLE Ya_Markup
/

CREATE TABLE Ya_Markup (
	account_id                            int                      NOT NULL ,
	attribute_id                          int                      NOT NULL ,
	site_id                               int                      NOT NULL ,
	price_floor                           number(18,2)             ,
	std_markup_percentage                 float(126)               ,
	std_markup_value                      number(18,2)             ,
	spl_markup_percentage                 float(126)               ,
	spl_markup_value                      number(18,2)             ,
	std_markdown_percentage               float(126)               ,
	std_markdown_value                    number(18,2)             ,
	spl_markdown_percentage               float(126)               ,
	spl_markdown_value                    number(18,2)             ,
	status                                char(1)                  NOT NULL
)
/

ALTER TABLE Ya_Markup
ADD CONSTRAINT PK_Markup PRIMARY KEY (account_id, attribute_id, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Markup FOR Ya_Markup
/