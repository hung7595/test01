CREATE OR REPLACE package Pkg_FE_SubscriptionAccess
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetSubscriptionProduct (
        iPsubscriptionSku IN INT,
	iPLangId IN INT,
	iPsiteId IN INT,
    curPresult1 OUT refCur,
    curPresult2 OUT refCur
  );


END Pkg_FE_SubscriptionAccess;
/

CREATE OR REPLACE package body Pkg_FE_SubscriptionAccess
is
  PROCEDURE GetSubscriptionProduct (
    iPsubscriptionSku IN INT,
    iPLangId IN INT,
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
productAvailability pa,productRegion where ya_product_subscription.sku=pa.productId and pa.availability=0 and pa.originid=iPSiteId and pa.category=1
and ya_product_subscription.sku=productRegion.productid and categoryId=1 and productRegion.originid=iPsiteId and  productRegion.cansell='Y' and  productRegion.enable='Y'
and subscription_sku=iPsubscriptionSku and start_date >= sysdate order by start_date desc)
where rownum<2;
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
         productAvailability pa,productRegion where ya_product_subscription.sku=pa.productId and          pa.originid=iPSiteId and pa.availability=0 and pa.category=1
         and ya_product_subscription.sku=productRegion.productid and categoryId=1 and 	 productRegion.originid=iPsiteId and subscription_sku=iPsubscriptionSku and productRegion.cansell='Y' and  productRegion.enable='Y'
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
        productAvailability pa,productRegion where ya_product_subscription.sku=pa.productId and pa.category=1 and         pa.originid=iPSiteId and ya_product_subscription.sku=productRegion.productid and categoryId=1 and            productRegion.originid=iPsiteId and subscription_sku=iPsubscriptionSku and start_date > sysdate order by start_date) where rownum<2;
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
select  * from (select s.sku,pl.prod_title_volume from ya_product_subscription s,ya_prod_lang pl where s.sku=pl.sku and pl.lang_id=iPLangId and subscription_sku= iPsubscriptionSku and
 start_date >= datLStartDate  order by start_date) where  rownum<= iLNumOfIssue;


return;



  END GetSubscriptionProduct;

END Pkg_FE_SubscriptionAccess;
/

