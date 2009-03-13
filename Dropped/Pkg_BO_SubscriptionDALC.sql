
REM START SS_ADM PKG_BO_SUBSCRIPTIONDALC

  CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_BO_SUBSCRIPTIONDALC" 
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetSubscriptionProduct (
        iPsubscriptionSku IN INT,
	iPsiteId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur
  );


END Pkg_BO_SubscriptionDALC;
/
CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_BO_SUBSCRIPTIONDALC" 
is
  PROCEDURE GetSubscriptionProduct (
    iPsubscriptionSku IN INT,
    iPsiteId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur
  )
  AS
    iLNumOfIssue INT;
    datLStartDate DATE;
    numLFirstIssueSku INT:=-1;

  BEGIN
  /* case 1 In April > April issue available > May issue available > First issue: May Issue*/
  /* get first issue sku */
    begin
      select  sku,start_date into numLFirstIssueSku,datLStartDate  from (select sku,start_date from ya_product_subscription,
prod_avlb pa, prod_region pr where ya_product_subscription.sku=pa.prod_id and pa.avlb=0 and pa.origin_id=iPSiteId and pa.category=1
and ya_product_subscription.sku=pr.prod_id and pr.category_id=1 and pr.origin_id=iPsiteId and  pr.is_can_sell='Y' and  pr.is_enabled='Y' and subscription_sku=iPsubscriptionSku
and start_date >= sysdate order by start_date desc) where rownum<2;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
        numLFirstIssueSku := -1;
	datLStartDate:=to_date('1900/01/01','yyyy/mm/dd');
      END;
    end;






  /* case 2 In April > April issue available > May issue not ready > First issue: April issue */
    IF numLFirstIssueSku <0 THEN
     BEGIN
	begin
         /* get first issue sku */
         select  sku,start_date into numLFirstIssueSku,datLStartDate from (select sku,start_date from ya_product_subscription,
         prod_avlb pa, prod_region pr where ya_product_subscription.sku=pa.prod_id and          pa.origin_id=iPSiteId and pa.avlb=0 and pa.category=1
         and ya_product_subscription.sku=pr.prod_id and pr.category_id=1 and 	pr.origin_id=iPsiteId and    pr.is_can_sell='Y' and  pr.is_enabled='Y' and subscription_sku=iPsubscriptionSku
         and start_date < sysdate order by start_date desc) where rownum<2;
       EXCEPTION WHEN NO_DATA_FOUND THEN
         BEGIN
           numLFirstIssueSku := -1;
	   datLStartDate:=to_date('1900/01/01','yyyy/mm/dd');
         END;
       end;
     END;
    END IF;

 /*  case 3 In April > April issue not available > May issue not ready > First issue: May issue */
   IF numLFirstIssueSku <0 THEN
    BEGIN
      /* get first issue sku */
      begin
        select  sku,start_date into numLFirstIssueSku,datLStartDate from (select sku,start_date from ya_product_subscription,
        prod_avlb pa, prod_region pr where ya_product_subscription.sku=pa.prod_id and pa.category=1 and         pa.origin_id=iPSiteId and ya_product_subscription.sku=pr.prod_id and pr.category_id=1 and            pr.origin_id=iPsiteId and subscription_sku=iPsubscriptionSku and start_date > sysdate order by start_date) where  rownum<2 ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        BEGIN
          numLFirstIssueSku := -1;
	  datLStartDate:=to_date('1900/01/01','yyyy/mm/dd');
        END;
      END;
    END;
   END IF;

/* Get number of Subscribe Issue*/
select number_of_issues into iLNumOfIssue from ya_subscription where subscription_sku=iPsubscriptionSku;

OPEN curPresult1 FOR
select number_of_issues from ya_subscription where subscription_sku=iPsubscriptionSku;


OPEN curPresult2 FOR
select s.sku,pl.lang_id,pl.prod_title_volume from ya_prod_lang pl,(
select  * from
(select s.sku,s.start_date from ya_product_subscription s
where  s.sku in (select sku from ya_product_subscription where
 start_date >= datLStartDate  and subscription_sku= iPsubscriptionSku)
 order by start_date,sku) where rownum<= iLNumOfIssue )  s
 where s.sku=pl.sku order by start_date,sku,lang_id;

return;



  END GetSubscriptionProduct;

END Pkg_BO_SubscriptionDALC;
/
 
REM END SS_ADM PKG_BO_SUBSCRIPTIONDALC
