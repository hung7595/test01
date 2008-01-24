
  CREATE OR REPLACE PACKAGE "SS_ADM"."PKG_BO_ASSETTRANSLATIONDALC" 
AS
  TYPE refCur IS REF CURSOR;
  PROCEDURE GetTranslations (
    curPresult OUT refCur,
    key1 IN INT DEFAULT -1,
    key2 IN INT DEFAULT -1,
    key3 IN INT DEFAULT -1,
    key4 IN INT DEFAULT -1,
    key5 IN INT DEFAULT -1,
    key6 IN INT DEFAULT -1,
    key7 IN INT DEFAULT -1,
    key8 IN INT DEFAULT -1,
    key9 IN INT DEFAULT -1,
    key10 IN INT DEFAULT -1,
    key11 IN INT DEFAULT -1,
    key12 IN INT DEFAULT -1,
    key13 IN INT DEFAULT -1,
    key14 IN INT DEFAULT -1,
    key15 IN INT DEFAULT -1,
    key16 IN INT DEFAULT -1,
    key17 IN INT DEFAULT -1,
    key18 IN INT DEFAULT -1,
    key19 IN INT DEFAULT -1,
    key20 IN INT DEFAULT -1,
    key21 IN INT DEFAULT -1,
    key22 IN INT DEFAULT -1,
    key23 IN INT DEFAULT -1,
    key24 IN INT DEFAULT -1,
    key25 IN INT DEFAULT -1,
    key26 IN INT DEFAULT -1,
    key27 IN INT DEFAULT -1,
    key28 IN INT DEFAULT -1,
    key29 IN INT DEFAULT -1,
    key30 IN INT DEFAULT -1,
    key31 IN INT DEFAULT -1,
    key32 IN INT DEFAULT -1,
    key33 IN INT DEFAULT -1,
    key34 IN INT DEFAULT -1,
    key35 IN INT DEFAULT -1,
    key36 IN INT DEFAULT -1,
    key37 IN INT DEFAULT -1,
    key38 IN INT DEFAULT -1,
    key39 IN INT DEFAULT -1,
    key40 IN INT DEFAULT -1
  );

  PROCEDURE GetWholeTranslationTable (
    curPresult OUT refCur
  );

  PROCEDURE GetInvalidTranslation (
    cPserver_id IN Varchar2,
    curPresult OUT refCur
  );
  
  PROCEDURE MarkInvalidTranslation (
    cPserver_id IN Varchar2,
    iPAssetId IN INT
  );
  
  PROCEDURE InsertInvalidTranslation (
    cPserver_id IN Varchar2,
    iPAssetId IN INT
  );

END Pkg_bo_AssetTranslationDalc;
/
CREATE OR REPLACE PACKAGE BODY "SS_ADM"."PKG_BO_ASSETTRANSLATIONDALC" 
AS
  PROCEDURE GetWholeTranslationTable (
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT t.asset_id, t.lang_Id, t.data
    FROM
      ya_asset_translation t
    ORDER BY
      t.asset_id, t.lang_id;
  END GetWholeTranslationTable;

  PROCEDURE GetInvalidTranslation (
    cPserver_id IN Varchar2,
    curPresult OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult  FOR
    SELECT t.asset_id, t.lang_Id, t.data
    FROM
      ya_asset_translation t,
      ya_asset_translation_invalid ti
    WHERE
      ti.asset_id = t.asset_id
      and ti.SERVER_ID = cPserver_id
      and ti.PROCESS_FLAG <> 'Y'
    ORDER BY
      t.asset_id;

--    DELETE FROM
--      ya_asset_translation_invalid;
--    COMMIT;
  END GetInvalidTranslation;

  PROCEDURE GetTranslations (
    curPresult out refCur,
    key1 IN INT DEFAULT -1,
    key2 IN INT DEFAULT -1,
    key3 IN INT DEFAULT -1,
    key4 IN INT DEFAULT -1,
    key5 IN INT DEFAULT -1,
    key6 IN INT DEFAULT -1,
    key7 IN INT DEFAULT -1,
    key8 IN INT DEFAULT -1,
    key9 IN INT DEFAULT -1,
    key10 IN INT DEFAULT -1,
    key11 IN INT DEFAULT -1,
    key12 IN INT DEFAULT -1,
    key13 IN INT DEFAULT -1,
    key14 IN INT DEFAULT -1,
    key15 IN INT DEFAULT -1,
    key16 IN INT DEFAULT -1,
    key17 IN INT DEFAULT -1,
    key18 IN INT DEFAULT -1,
    key19 IN INT DEFAULT -1,
    key20 IN INT DEFAULT -1,
    key21 IN INT DEFAULT -1,
    key22 IN INT DEFAULT -1,
    key23 IN INT DEFAULT -1,
    key24 IN INT DEFAULT -1,
    key25 IN INT DEFAULT -1,
    key26 IN INT DEFAULT -1,
    key27 IN INT DEFAULT -1,
    key28 IN INT DEFAULT -1,
    key29 IN INT DEFAULT -1,
    key30 IN INT DEFAULT -1,
    key31 IN INT DEFAULT -1,
    key32 IN INT DEFAULT -1,
    key33 IN INT DEFAULT -1,
    key34 IN INT DEFAULT -1,
    key35 IN INT DEFAULT -1,
    key36 IN INT DEFAULT -1,
    key37 IN INT DEFAULT -1,
    key38 IN INT DEFAULT -1,
    key39 IN INT DEFAULT -1,
    key40 IN INT DEFAULT -1
  )
  AS
  BEGIN
    OPEN curPresult FOR
    SELECT t.asset_id, t.lang_Id, t.data
    FROM
      ya_asset_translation t
    WHERE
      t.asset_id IN
      (
        key1, key2, key3, key4, key5,
        key6, key7, key8, key9, key10,
        key11, key12, key13, key14, key15,
        key16, key17, key18, key19, key20,
        key21, key22, key23, key24, key25,
        key26, key27, key28, key29, key30,
        key31, key32, key33, key34, key35,
        key36, key37, key38, key39, key40
      )
    ORDER BY
      t.asset_id, t.lang_id;
  END GetTranslations;
  
  PROCEDURE MarkInvalidTranslation (
    cPserver_id IN Varchar2,
    iPAssetId IN INT
  ) AS
  BEGIN
    update ya_asset_translation_invalid set process_flag = 'Y' 
    where server_id = cPserver_id and asset_id = iPAssetId and process_flag = 'N';
    COMMIT;
    RETURN;
    EXCEPTION WHEN OTHERS THEN
      BEGIN
        ROLLBACK;
        RETURN;
      END;
  END MarkInvalidTranslation;
  
  PROCEDURE InsertInvalidTranslation (
    cPserver_id IN Varchar2,
    iPAssetId IN INT
  )
  AS
  BEGIN
    insert into ya_asset_translation_invalid ( asset_id, server_id ) values ( iPAssetId, cPserver_id );
    COMMIT;
    RETURN;
    EXCEPTION WHEN OTHERS THEN
      BEGIN
        ROLLBACK;
        RETURN;
      END;
  END InsertInvalidTranslation;
END Pkg_bo_AssetTranslationDalc;
/
 