create or replace procedure sp_order_act_tracking
as
  cursor curTable_list
  is select id, order_num, sku, quantity, campaign_code from ya_order_act_tracking 
     where status = 1 order by 1;
  iID		 	    NUMBER;
  iOrder_num 	    NUMBER;
  iOrder_ID    	    NUMBER;  
  isku      	    NUMBER;
  iquantity		    NUMBER;
  icampaign_code    NUMBER;
begin
  OPEN curTable_list;
  LOOP
    FETCH curTable_list INTO iID, iOrder_num, isku, iquantity, icampaign_code;
    EXIT WHEN curTable_list%NOTFOUND;

    BEGIN
      SELECT ID INTO iOrder_ID FROM ORDER_INFO WHERE origin_order_id = TO_CHAR(iOrder_num);
     
      INSERT INTO ya_campaign_order VALUES (iOrder_num, iOrder_ID, isku, iquantity, icampaign_code);
      
      UPDATE ya_order_act_tracking set status = 2 where id = iID;
      
    EXCEPTION 
      WHEN NO_DATA_FOUND THEN 
          iOrder_ID := 0; 
    END;

--    DBMS_OUTPUT.PUT_LINE(iOrder_ID);    

  END LOOP;
  CLOSE curTable_list;

  COMMIT;
EXCEPTION
  WHEN Others THEN
    ROLLBACK;
  RAISE;

END sp_order_act_tracking;
/
