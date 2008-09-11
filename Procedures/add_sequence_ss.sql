create or replace PROCEDURE add_sequence_ss AS
  itemp INT;
  csql CHAR(2000);
BEGIN
  /* ya_page */
  SELECT NVL(MAX(page_id),1) INTO itemp from ya_page;
  csql := 'CREATE SEQUENCE seq_page START WITH ' || itemp || ' INCREMENT BY 1';
  EXECUTE IMMEDIATE csql;

  /* ya_blocktemplate */
  SELECT NVL(MAX(blocktemplate_id),1) INTO itemp from ya_blocktemplate;
  csql := 'CREATE SEQUENCE seq_blocktemplate START WITH ' || itemp || ' INCREMENT BY 1';
  EXECUTE IMMEDIATE csql;

  /* ya_asset */
  SELECT NVL(MAX(asset_id),1) INTO itemp from ya_asset;
  csql := 'CREATE SEQUENCE seq_asset START WITH ' || itemp || ' INCREMENT BY 1';
  EXECUTE IMMEDIATE csql;



END;