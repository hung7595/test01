CREATE OR REPLACE package Pkg_fe_ThemeStoreAccess
AS
  TYPE refCur IS ref CURSOR;

  PROCEDURE GetGuestBookBySku (
    iPsku IN INT,
    iPsiteId IN INT,
    curPgetThemestore1 OUT refCur,
    curPgetThemestore2 OUT refCur
  );

  /* proc_fe_themestore_AddSubscribe */
  PROCEDURE AddSubscriber (
    iPtheme_id IN INT,
    vcPemail IN NVARCHAR2,
    clobPshipping_address IN NCLOB,
    ncPcheck_num IN NVARCHAR2
  );

  /* proc_fe_themestore_isSubscribeEmailExist */
  PROCEDURE CheckSubscriberExist (
    iPtheme_id IN INT,
    vcPemail IN NVARCHAR2,
    iPresult OUT INT
  );

  PROCEDURE UpdateSubscribeEmailActive (
    iPthemeStore_id IN INT,
    ncPmail IN NVARCHAR2,
    ncPcheck_num IN NVARCHAR2
  );

  PROCEDURE AddNewVote (
    iPvote_id IN INT,
    iPthemestore_id IN INT,
    nvcPcreated_by IN NVARCHAR2,
    iPlang_id IN INT,
    nvcPitem_desc IN NVARCHAR2
  );

  PROCEDURE CheckItemDesc (
    nvcPitem_desc IN NVARCHAR2,
    iPitem_id OUT INT
  );

  PROCEDURE UpdateVote (
    iPitem_id IN INT
  );

  PROCEDURE AddAdditionalInfo (
    iPthemestore_id IN INT,
    nvcPemail IN NVARCHAR2,
    nvcPname IN NVARCHAR2,
    iPlocation IN INT
  );

  PROCEDURE AddTempVote (
    iPthemestore_id IN INT,
    nvcPemail IN NVARCHAR2,
    iPitem_id IN INT,
    iPlang_id IN INT,
    nvcPitem_desc IN NVARCHAR2
  );

  PROCEDURE GetTop5Votes (
    iPlang_id IN INT,
    rcPresult OUT refCur
  );

  PROCEDURE GetVoteResult (
    iPlangId IN INT,
    curPresult OUT refcur
  );

  /* For the E-Mag GuestBook */
  PROCEDURE GetGuestBookBySkuAndLangId (
    iPsku IN INT,
    iPsiteId IN INT,
    iPlangId IN INT, 
    curPgetThemestore1 OUT refCur,
    curPgetThemestore2 OUT refCur
  );

END Pkg_fe_ThemeStoreAccess;
/

CREATE OR REPLACE package body Pkg_fe_ThemeStoreAccess
IS

  PROCEDURE GetGuestBookBySku (
    iPsku IN INT,
    iPsiteId IN INT,
    curPgetThemestore1 OUT refCur,
    curPgetThemestore2 OUT refCur
  )
AS
BEGIN
  open curPgetThemestore1 FOR
  SELECT
    sum(actual_count) AS actual_count,
    avg(average_rating) AS average_rating,
    sku
  FROM
    ya_review_summary
  WHERE
    sku = iPsku
    AND site_id = iPsiteId
  GROUP BY
    sku;

  open curPgetThemestore2 FOR
  SELECT a.rating_id,
    c.review_id,
    a.sku,
    cast(NVL(a.product_rating, 0) AS INT) AS product_rating,
    a.date_posted,
    a.review_approved,
    a.shopper_id AS shopper_id,
    NVL(a.reviewer, 'Anonymous') AS reviewer,
    a.reviewer_type,
    cast(NVL(b.lang_id, 1) AS INT) AS lang_id,
    b.title AS title,
    c.review AS review,
    c.review_img_loc AS review_img_loc,
    cast(NVL(c.review_img_width, 0) AS INT) AS review_img_width,
    cast(NVL(c.review_img_height, 0) AS INT) AS review_img_height
  FROM
    ya_product_rating a,
    ya_prod_rating_lang b,
    ya_review c
  WHERE
    a.rating_id = b.rating_id
    AND (b.us_review_id = c.review_id OR
         b.hk_review_id = c.review_id OR
         b.jp_review_id = c.review_id OR
         b.tw_review_id = c.review_id)
    AND b.us_review_id = c.review_id
    AND a.sku = iPsku
    AND a.reviewer_type = 'USER'
    AND review_approved = 'Y'
  ORDER BY a.date_posted DESC;
  RETURN;
END GetGuestBookBySku;


  PROCEDURE AddSubscriber (
    iPtheme_id IN INT,
    vcPemail IN NVARCHAR2,
    clobPshipping_address IN NCLOB,
    ncPcheck_num IN NVARCHAR2
  )
  AS
  BEGIN
    INSERT INTO ya_themestore_subscribe
      (
        themestore_id,
        email,
        shipping_address,
        check_num
      )
    VALUES
      (
        iPtheme_id,
        vcPemail,
        clobPshipping_address,
        ncPcheck_num
      );
    IF sqlcode <> 0 THEN
      ROLLBACK;
    ELSE
      COMMIT;
    END IF;
  END AddSubscriber;



  PROCEDURE CheckSubscriberExist (
    iPtheme_id IN INT,
    vcPemail IN NVARCHAR2,
    iPresult OUT INT
  )
  AS
  BEGIN
    SELECT COUNT(1)
    INTO iPresult
    FROM ya_themestore_subscribe
    WHERE
      themestore_id = iPtheme_id
      AND email = vcPemail;
    RETURN;
  END CheckSubscriberExist;


  PROCEDURE UpdateSubscribeEmailActive (
    iPthemeStore_id IN INT,
    ncPmail IN NVARCHAR2,
    ncPcheck_num IN NVARCHAR2
  )
  AS
    iLtemp INT;
  BEGIN
    SELECT COUNT(1)
    INTO iLtemp
    FROM
      ya_themestore_subscribe
    WHERE
      email = ncPmail
      AND check_num = ncPcheck_num
      AND themestore_id = iPthemeStore_id
      AND active = 0;

    IF iLtemp > 0 THEN
      BEGIN
        UPDATE ya_themestore_subscribe
        SET
          active = 1,
          actived_datetime = SYSDATE
        WHERE
          email = ncPmail
          AND check_num = ncPcheck_num
          AND themestore_id = iPthemeStore_id;
      END;
    END IF;

    IF sqlcode <> 0 THEN
      ROLLBACK;
    ELSE
      COMMIT;
    END IF;
  END UpdateSubscribeEmailActive;


  PROCEDURE AddNewVote (
    iPvote_id IN INT,
    iPthemestore_id IN INT,
    nvcPcreated_by IN NVARCHAR2,
    iPlang_id IN INT,
    nvcPitem_desc IN NVARCHAR2
  )
  AS
    iLitem_id INT;
  BEGIN
    SELECT SEQ_themestore_vote.nextval INTO iLitem_id FROM DUAL;

    INSERT INTO ya_themestore_vote
      (
        vote_id,
        themestore_id,
        created_by,
        item_id
      )
    VALUES
      (
        iPvote_id,
        iPthemestore_id,
        nvcPcreated_by,
        iLitem_id
      );

    INSERT INTO ya_themestore_vote_lang
      (
        item_id,
        lang_id,
        item_desc
      )
    VALUES
      (
        iLitem_id,
        iPlang_id,
        nvcPitem_desc
      );

    INSERT INTO ya_themestore_vote_result
      (
        vote_id,
        item_id,
        result_count
      )
    VALUES
      (
        iPvote_id,
        iLitem_id,
        1
      );

    IF sqlcode <> 0 THEN
      ROLLBACK;
    ELSE
      COMMIT;
    END IF;
  END AddNewVote;



  PROCEDURE CheckItemDesc (
    nvcPitem_desc IN NVARCHAR2,
    iPitem_id OUT INT
  )
  AS
  BEGIN
    SELECT NVL(MAX(item_id),-1)
    INTO iPitem_id
    FROM ya_themestore_vote_lang
    WHERE
      item_desc LIKE nvcPitem_desc;
  END CheckItemDesc;


  PROCEDURE UpdateVote (
    iPitem_id IN INT
  )
  AS
  BEGIN
    /*
    SELECT result_count + 1
    INTO iLresult_count
    FROM ya_themestore_vote_result
    WHERE item_id = iPitem_id;

    UPDATE ya_themestore_vote_result
    SET
      result_count = iLresult_count,
      last_update = SYSDATE()
    WHERE item_id = iPitem_id;
    */

    UPDATE ya_themestore_vote_result
    SET
      result_count = result_count + 1,
      last_update = SYSDATE()
    WHERE item_id = iPitem_id;

    IF sqlcode = 0 THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END UpdateVote;


  PROCEDURE AddAdditionalInfo (
    iPthemestore_id IN INT,
    nvcPemail IN NVARCHAR2,
    nvcPname IN NVARCHAR2,
    iPlocation IN INT
  )
  AS
  BEGIN
    INSERT INTO ya_themestore_sub_add_info
      (
        themestore_id,
        email,
        name,
        location
      )
    VALUES
      (
        iPthemestore_id,
        nvcPemail,
        nvcPname,
        iPlocation
      );

    IF sqlcode = 0 THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END AddAdditionalInfo;


  PROCEDURE AddTempVote (
    iPthemestore_id IN INT,
    nvcPemail IN NVARCHAR2,
    iPitem_id IN INT,
    iPlang_id IN INT,
    nvcPitem_desc IN NVARCHAR2
  )
  AS
  BEGIN
    INSERT INTO ya_themestore_vote_temp
      (
        themestore_id,
        email,
        item_id,
        lang_id,
        item_desc
      )
    VALUES
      (
        iPthemestore_id,
        nvcPemail,
        iPitem_id,
        iPlang_id,
        nvcPitem_desc
      );

    IF sqlcode = 0 THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
  END AddTempVote;


  PROCEDURE GetTop5Votes (
    iPlang_id IN INT,
    rcPresult OUT refCur
  )
  AS
  BEGIN
    OPEN rcPresult FOR
    SELECT *
    FROM
    (
      SELECT
        r.item_id,
        v.us_sku,
        v.gb_sku,
        l.item_desc
      FROM
        ya_themestore_vote_result r
        INNER JOIN ya_themestore_vote v ON
          r.item_id = v.item_id
        INNER JOIN ya_themestore_vote_lang l ON
          l.item_id = r.item_id
      WHERE
        r.vote_id = 1
        AND r.item_id <= 23
        AND lang_id = iPlang_id
      ORDER BY result_count DESC
    )
    WHERE ROWNUM <= 5;
  END;

  PROCEDURE GetVoteResult (
    iPlangId IN INT,
    curPresult OUT refcur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT tvr.item_id, NVL( item_desc, ' ') AS item_desc,
           result_count, NVL(tv.us_sku, 0) AS us_sku,
           NVL(tv.gb_sku, 0) AS gb_sku
      FROM ya_themestore_vote_result tvr, ya_themestore_vote_lang tvl, ya_themestore_vote tv
     WHERE tvr.item_id  = tvl.item_id (+)
       AND tvl.lang_id (+) = iPlangId
       AND tvr.item_id  = tv.item_id;
  END GetVoteResult;

  PROCEDURE GetGuestBookBySkuAndLangId (
    iPsku IN INT,
    iPsiteId IN INT,
    iPlangId IN INT,
    curPgetThemestore1 OUT refCur,
    curPgetThemestore2 OUT refCur
  )
  AS
  BEGIN
    open curPgetThemestore1 FOR
    SELECT
      sum(actual_count) AS actual_count,
      avg(average_rating) AS average_rating,
      sku
    FROM
      ya_review_summary
    WHERE
      sku = iPsku
      AND site_id = iPsiteId
      AND (lang_id = 1 OR lang_id=iPlangId)
    GROUP BY
      sku;
  
    open curPgetThemestore2 FOR
    SELECT a.rating_id,
      c.review_id,
      a.sku,
      cast(NVL(a.product_rating, 0) AS INT) AS product_rating,
      a.date_posted,
      a.review_approved,
      a.shopper_id AS shopper_id,
      NVL(a.reviewer, 'Anonymous') AS reviewer,
      a.reviewer_type,
      cast(NVL(b.lang_id, 1) AS INT) AS lang_id,
      b.title AS title,
      c.review AS review,
      c.review_img_loc AS review_img_loc,
      cast(NVL(c.review_img_width, 0) AS INT) AS review_img_width,
      cast(NVL(c.review_img_height, 0) AS INT) AS review_img_height
    FROM
      ya_product_rating a,
      ya_prod_rating_lang b,
      ya_review c
    WHERE
      a.rating_id = b.rating_id
      AND (b.us_review_id = c.review_id OR
           b.hk_review_id = c.review_id OR
           b.jp_review_id = c.review_id OR
           b.tw_review_id = c.review_id)
      AND b.us_review_id = c.review_id
      AND a.sku = iPsku
      AND a.reviewer_type = 'USER'
      AND review_approved = 'Y'
      AND (lang_id = 1 OR lang_id = iPlangId)
    ORDER BY a.date_posted DESC;
    RETURN;
  END GetGuestBookBySkuAndLangId;

END Pkg_fe_ThemeStoreAccess;
/

