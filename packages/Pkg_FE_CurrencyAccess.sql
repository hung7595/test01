
REM START SS_ADM PKG_FE_CURRENCYACCESS

  CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_FE_CURRENCYACCESS" 
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetCurrencyRate (
    curPresult1 OUT refCur
  );


END Pkg_FE_CurrencyAccess;
/
CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_FE_CURRENCYACCESS" 
is
  PROCEDURE GetCurrencyRate (
    curPresult1 OUT refCur
  )
  AS


  BEGIN


OPEN curPresult1 FOR
select
(select code from ya_lookup where type_id=94 and code_id=cs.currency_id) as currency,
(select code from ya_lookup where type_id=94 and code_id=er.source_currency_id) as source_currency,
er.exchange_rate
from ya_currency_site cs left join ya_exchange_rate er on cs.currency_id=er.currency_id
order by priority;




return;



  END GetCurrencyRate;

END Pkg_FE_CurrencyAccess;
/
 
REM END SS_ADM PKG_FE_CURRENCYACCESS
