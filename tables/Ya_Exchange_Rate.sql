DROP TABLE Ya_Exchange_Rate
/

CREATE TABLE Ya_Exchange_Rate (
	currency_id                       int                   NOT NULL ,
	source_currency_id                int                   NOT NULL ,
	effective_date                    date                  NOT NULL ,
	exchange_rate                     number(18,5)          NOT NULL
)
/

ALTER TABLE Ya_Exchange_Rate
ADD CONSTRAINT PK_Exchange_Rate PRIMARY KEY (currency_id, source_currency_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Exchange_Rate FOR Ya_Exchange_Rate
/