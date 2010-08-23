create or replace
PACKAGE Pkg_AssociateUpdate
AS

  TYPE refcur IS REF CURSOR;

  PROCEDURE Ins_CommissionHistory;

  PROCEDURE Upd_PayMethod;

  PROCEDURE Upd_CommissionRate;

  PROCEDURE Daily_Update;

END Pkg_AssociateUpdate;
/

create or replace
PACKAGE BODY Pkg_AssociateUpdate
IS

  PROCEDURE Ins_CommissionHistory
  AS
    CURSOR cur_assoapprove IS
      select distinct associate_id
      from   ya_associate
      where  associate_approved = 'Y';
    iAssoID               NUMBER;
    cValidDate            VARCHAR(10);
    iCountValidDate       NUMBER := 0;
    nRate                 NUMBER(18,4);
    iPayment_Option       NUMBER;
  BEGIN

    SELECT to_char(sysdate,'YYYY-MM') || '-01' INTO cValidDate FROM dual;

    OPEN cur_assoapprove;

    LOOP
      FETCH cur_assoapprove INTO iAssoID;
      EXIT WHEN cur_assoapprove%NOTFOUND;

      SELECT count(1) INTO iCountValidDate FROM ya_associate_commission_hist
      WHERE associate_id = iAssoID AND valid_date = to_date(cValidDate,'YYYY-MM-DD');

      IF iCountValidDate = 0 THEN

		SELECT comm_rate, payment_option
		  INTO nRate, iPayment_Option
		FROM (
		SELECT comm_rate, payment_option
		from ya_associate_commission_hist where associate_id = iAssoID
		order by valid_date desc) WHERE ROWNUM <= 1;

		IF iPayment_Option IS NULL THEN
		  nRate := NULL;
		  select payment_option INTO iPayment_Option from ya_associate where associate_id = iAssoID;
		END IF;

		INSERT INTO ya_associate_commission_hist (associate_id, valid_date, comm_rate, payment_option, rowguid)
		values(iAssoID, to_date(cValidDate,'YYYY-MM-DD'), nRate, iPayment_Option,SYS_GUID());

--DBMS_OUTPUT.PUT_LINE(iAssoID || cValidDate || nRate || iPayment_Option);

      END IF;

    END LOOP;
    CLOSE cur_assoapprove;

  END Ins_CommissionHistory;

  PROCEDURE Upd_PayMethod
  AS
    iAssoID               NUMBER;
    cValidDate            VARCHAR(10);
    iCountValidDate       NUMBER := 0;
    nRate                 NUMBER(18,4);
    iPayment_Option       NUMBER;
  BEGIN

    SELECT to_char(sysdate,'YYYY-MM') || '-01' INTO cValidDate FROM dual;

    UPDATE ya_associate_commission_hist ach
    SET    payment_option =
    ( SELECT a.payment_option
      FROM ya_associate a
      WHERE a.associate_id = ach.associate_id
      AND ach.valid_date = to_date(cValidDate,'YYYY-MM-DD'))
    WHERE exists
    ( SELECT 1
      FROM ya_associate a
      WHERE a.associate_id = ach.associate_id
      AND ach.valid_date = to_date(cValidDate,'YYYY-MM-DD'));

  END Upd_PayMethod;

  PROCEDURE Upd_CommissionRate
  AS
    iAssoID               NUMBER;
    cValidDate            VARCHAR(10);
    cCutOffDate           VARCHAR(10) := '2005-06-01';
    iCountValidDate       NUMBER := 0;
    nRate                 NUMBER(18,4);
    iPayment_Option       NUMBER;

  BEGIN

    SELECT to_char(sysdate,'YYYY-MM') || '-01' INTO cValidDate FROM dual;

    EXECUTE IMMEDIATE 'TRUNCATE TABLE Temp_CSAccount';

    INSERT INTO Temp_CSAccount
    SELECT distinct b.cuscount, ach.associate_id
    FROM ya_associate_commission_hist ach
    LEFT OUTER JOIN (
      SELECT  count(dm.cust_id) as cuscount, yalo.associate_id
      FROM    datamining_adm.dm_new_shopper dm, (
        SELECT to_char(alo.order_num) orderId, yal.associate_id
        FROM ya_associate_link_orders alo, ya_associate_link yal
        WHERE alo.link_id = yal.link_id
        AND alo.order_date >= to_date(cValidDate,'YYYY-MM-DD')
        AND alo.order_date <  add_months(to_date(cValidDate,'YYYY-MM-DD'), 1)
      ) yalo
      WHERE dm.fe_order_id = yalo.orderId
      GROUP BY yalo.associate_id) b
    ON (ach.associate_id = b.associate_id)
    WHERE ach.valid_date = to_date(cValidDate,'YYYY-MM-DD');

    UPDATE ya_associate_commission_hist ach
    SET comm_rate =
    ( SELECT cd.percentage
      from Temp_CSAccount c, ya_associate ya,
      ya_associate_commission_detail cd,  ya_associate_commission_type ct
      WHERE 1=1
      AND c.associate_id = ya.associate_id
      AND ya.commission_id = cd.commission_id
      AND ya.payment_option = cd.payment_option
      AND ct.comm_type_id = cd.comm_type_id
      AND ct.nc_min <= c.customer
      AND (ct.nc_max >= c.customer OR ct.nc_max = 0)
      AND ach.associate_id = ya.associate_id
      AND ach.valid_date = to_date(cValidDate,'YYYY-MM-DD'))
    WHERE EXISTS
    ( SELECT 1
      from Temp_CSAccount c, ya_associate ya,
      ya_associate_commission_detail cd,  ya_associate_commission_type ct
      WHERE 1=1
      AND c.associate_id = ya.associate_id
      AND ya.commission_id = cd.commission_id
      AND ya.payment_option = cd.payment_option
      AND ct.comm_type_id = cd.comm_type_id
      AND ct.nc_min <= c.customer
      AND (ct.nc_max >= c.customer OR ct.nc_max = 0)
      AND ach.associate_id = ya.associate_id
      AND ach.valid_date = to_date(cValidDate,'YYYY-MM-DD'));

  END Upd_CommissionRate;

  PROCEDURE Daily_Update
  AS
  BEGIN

    Ins_CommissionHistory;

    Upd_PayMethod;

    Upd_CommissionRate;

--    COMMIT;

  EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
    RAISE;

  END Daily_Update;

END Pkg_AssociateUpdate;
/