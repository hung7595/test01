REM START SS_ADM PKG_FE_REVIEWACCESS

CREATE OR REPLACE PACKAGE "PKG_FE_REVIEWACCESS"
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetShareGroupBySku (
	  iPsku IN INT,
	  iPgroup_id OUT INT
	);
	
	PROCEDURE GetProReviewsByGroupId (
	  iPgroup_id IN INT,
	  curPresult OUT refCur
	);
	
  PROCEDURE GetProdCustomerReview (
	  iPgroup_id IN INT,
	  curPresult OUT refCur
	);

	PROCEDURE GetProdRelByGroupId (
	  iPgroup_id IN INT,
	  curPresult OUT refCur	
	);
	
	PROCEDURE GetProdByShareGroup (
	  iPgroup_id IN INT,
	  iPlang_id IN INT,
	  curPresult OUT refCur
	);
	
	PROCEDURE AddProdToShareGroup (
	  iPsku IN INT,
	  iPgroup_id OUT INT
	);
	
	PROCEDURE DeleteProdFrmShareGroup (
	  iPsku IN INT
	);
	
	PROCEDURE AddShareGroupByMemberSku (
	  iPsku IN INT,
	  iPgroup_member_sku IN INT,
	  iPgroup_id OUT INT
	);
	
	PROCEDURE DeleteProReviewShareByGroupId (
	  iPgroup_id IN INT
	);
	
  PROCEDURE AddShareProReview (
	  iPparent_sku IN INT,
	  iPchild_sku IN INT
	);
	
	PROCEDURE DeleteCustReviewShareByGroupId (
	  iPgroup_id IN INT
	);
	
	PROCEDURE AddShareCustomerReview (
	  iPsku IN INT
	);
  
END Pkg_FE_ReviewAccess;
/
CREATE OR REPLACE PACKAGE BODY "PKG_FE_REVIEWACCESS"
IS	

	PROCEDURE GetShareGroupBySku (
	  iPsku IN INT,
	  iPgroup_id OUT INT
	)
	AS
	BEGIN
    BEGIN
      SELECT group_id INTO iPgroup_id
      FROM ya_review_share_group
      WHERE sku = iPsku;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iPgroup_id := 0;
          RETURN;
        END;
    END;	
	END GetShareGroupBySku;
	
	PROCEDURE GetProReviewsByGroupId (
	  iPgroup_id IN INT,
	  curPresult OUT refCur
	)
	AS
	BEGIN
    OPEN curPresult FOR
    SELECT rsg.sku, tp.lang_id, tp.review, tp.reviewer, tp.us_review_id, tp.tw_review_id, tp.reviewer_type, rsg.updated_user, rsg.updated_dt
    FROM ya_review_share_group rsg
    LEFT OUTER JOIN (
      select a.sku, b.lang_id, b.review, '' reviewer, a.id us_review_id, a.id tw_review_id, 'EDITORIAL' reviewer_type
      from ya_review_share_group d
        left outer join ya_profess_review a on a.sku = d.sku
        left outer join ya_profess_review_lang b on a.id = b.profess_review_id
      where b.review is not null and d.group_id = iPgroup_id	
    ) tp on rsg.sku = tp.sku
    WHERE rsg.group_id = iPgroup_id
    ORDER BY rsg.sku, tp.lang_id;
	END GetProReviewsByGroupId;	
	
	PROCEDURE GetProdCustomerReview (
	  iPgroup_id IN INT,
	  curPresult OUT refCur
	)
	AS
	BEGIN
	  OPEN curPresult FOR
	  SELECT rsg.sku, rsc.sku, rsg.updated_user, rsg.updated_dt
    FROM ya_review_share_group rsg
      LEFT OUTER JOIN ya_review_share_customerReview rsc ON rsc.sku = rsg.sku
    WHERE rsg.group_id = iPgroup_id;
	END GetProdCustomerReview;
	
	PROCEDURE GetProdRelByGroupId (
	  iPgroup_id IN INT,
	  curPresult OUT refCur	
	)
	AS
	BEGIN
	  OPEN curPresult FOR
    SELECT parent_sku, child_sku
    FROM ya_review_share_proReview ysp, ya_review_share_group rsg, ya_review_share_group rsg2
    WHERE rsg.sku = ysp.parent_sku
      AND rsg2.sku = ysp.child_sku
      AND rsg.group_id = iPgroup_id
      AND rsg2.group_id = iPgroup_id;
	END GetProdRelByGroupId;
	
	PROCEDURE GetProdByShareGroup (
	  iPgroup_id IN INT,
	  iPlang_id IN INT,
	  curPresult OUT refCur
	)
	AS
	BEGIN
	  OPEN curPresult FOR
    SELECT pl.sku, pl.prod_name
    FROM ya_prod_lang pl, ya_review_share_group rsg
    WHERE pl.sku = rsg.sku
      AND rsg.group_id = iPgroup_id
      AND lang_id=iPlang_id
    ORDER BY pl.sku;
	END GetProdByShareGroup;
	
	PROCEDURE AddProdToShareGroup (
	  iPsku IN INT,
	  iPgroup_id OUT INT
	)
	AS
	  iLexist INT;
	BEGIN
	  BEGIN
      SELECT 1 INTO iLexist
      FROM ya_product
      WHERE sku = iPsku;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iPgroup_id := 0;
          RETURN;
        END;
    END;

	  BEGIN
      SELECT group_id INTO iPgroup_id
      FROM ya_review_share_group
      WHERE sku = iPsku;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
	        SELECT SEQ_ya_review_share_group.nextval INTO iPgroup_id FROM dual;
	        	
          INSERT INTO ya_review_share_group (group_id, sku, updated_dt, updated_user)
          VALUES (iPgroup_id, iPsku, sysdate, 'system');

          INSERT INTO ya_review_share_customerreview (sku) VALUES (iPsku);
          COMMIT;
          RETURN;
        END;
    END;
	END AddProdToShareGroup;
	
	PROCEDURE DeleteProdFrmShareGroup (
	  iPsku IN INT
	)
	AS
	  iLexist INT;
	BEGIN
    DELETE FROM ya_review_share_proReview where parent_sku = iPsku or child_sku = iPsku;
    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
      END;
    END IF;

    DELETE FROM ya_review_share_group where sku = iPsku AND updated_user = 'system';
    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
      END;
    END IF;

    DELETE FROM ya_review_share_customerReview WHERE sku = iPsku
      AND NOT EXISTS (SELECT 1 FROM ya_review_share_group WHERE sku = iPsku);
    IF SQLCODE <> 0 THEN
      BEGIN
        ROLLBACK;
      END;
    ELSE
      BEGIN
        COMMIT;
      END;
    END IF;
	END DeleteProdFrmShareGroup;
	
	PROCEDURE AddShareGroupByMemberSku (
	  iPsku IN INT,
	  iPgroup_member_sku IN INT,
	  iPgroup_id OUT INT
	)
	AS
	  iLexist INT;
	BEGIN
	  BEGIN
      SELECT 1 INTO iLexist
      FROM ya_product
      WHERE sku = iPsku;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          iPgroup_id := 0;
          RETURN;
        END;
    END;

	  BEGIN
      SELECT group_id INTO iPgroup_id
      FROM ya_review_share_group
      WHERE sku = iPsku;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          INSERT INTO ya_review_share_group (group_id, sku, updated_dt, updated_user)
          SELECT group_id, iPsku, sysdate, 'system'
          FROM ya_review_share_group
          WHERE sku = iPgroup_member_sku
            AND rownum = 1;

          SELECT group_id INTO iPgroup_id
          FROM ya_review_share_group
          WHERE sku = iPsku;
        END;
    END;

	  BEGIN
      SELECT 1 INTO iLexist
      FROM ya_review_share_customerreview
      WHERE sku = iPsku;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          INSERT INTO ya_review_share_customerreview (sku) VALUES (iPsku);
          COMMIT;
          RETURN;
        END;
    END;
	END AddShareGroupByMemberSku;
	
	PROCEDURE DeleteProReviewShareByGroupId (
	  iPgroup_id IN INT
	)
	AS
	BEGIN
    DELETE FROM ya_review_share_proReview
    WHERE parent_sku in (SELECT sku FROM ya_review_share_group where group_id = iPgroup_id and updated_user = 'system')
      OR parent_sku in (SELECT sku FROM ya_review_share_group where group_id = iPgroup_id and updated_user = 'system');
    COMMIT;
	END DeleteProReviewShareByGroupId;
	
	PROCEDURE AddShareProReview (
	  iPparent_sku IN INT,
	  iPchild_sku IN INT
	)
	AS
	BEGIN
    INSERT INTO ya_review_share_proReview (parent_sku, child_sku)
    VALUES (iPparent_sku, iPchild_sku);
    COMMIT;
	END AddShareProReview;
	
	PROCEDURE DeleteCustReviewShareByGroupId (
	  iPgroup_id IN INT
	)
	AS
	BEGIN
    DELETE FROM ya_review_share_customerReview
    WHERE sku in (SELECT sku FROM ya_review_share_group where group_id = iPgroup_id and updated_user = 'system');
    COMMIT;
	END DeleteCustReviewShareByGroupId;

	PROCEDURE AddShareCustomerReview (
	  iPsku IN INT
	)
	AS
	  iLexist INT;
	BEGIN
	  BEGIN
      SELECT 1 INTO iLexist
      FROM ya_review_share_customerreview
      WHERE sku = iPsku;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          INSERT INTO ya_review_share_customerreview (sku) VALUES (iPsku);
          COMMIT;
          RETURN;
        END;
    END;	
	END AddShareCustomerReview;
	
END Pkg_FE_ReviewAccess;
/