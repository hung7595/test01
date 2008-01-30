CREATE OR REPLACE PACKAGE PKG_FE_PROD_GALLERYACCESS AS
TYPE CUR_RETURN IS REF CURSOR;

PROCEDURE AddImage
(
  iPSku IN int,
  iPSection_id IN int,
  iPImage_path IN VARCHAR2,
  iPThumb_path IN VARCHAR2,
  iPDesc_en IN NVARCHAR2,
  iPDesc_b5 IN NVARCHAR2,
  iPDesc_jp IN NVARCHAR2,
  iPDesc_kr IN NVARCHAR2,
  iPDesc_gb IN NVARCHAR2,
  iPPriority IN INT,
  iPArrange_priority IN INT := 0,
  cPisCommit IN CHAR DEFAULT 'Y'
);

PROCEDURE AddSection
(
  iPName_en IN NVARCHAR2,
  iPName_b5 IN NVARCHAR2,
  iPName_jp IN NVARCHAR2,
  iPName_kr IN NVARCHAR2,
  iPName_gb IN NVARCHAR2,
  iPPriority IN int
);

PROCEDURE CanGalleryOverride
(
  iPSku IN INT,
  curPout OUT cur_return
);

PROCEDURE DeleteImage
(
  iPImage_id_csv IN VARCHAR2
);

PROCEDURE GetGalleryStatBySku
(
  iPSku IN INT,
  iPSection_id IN INT,
  curPout OUT cur_return
);

PROCEDURE GetImageBySku
(
  iPSku IN int,
  iPLang_id IN int,
  curPout OUT cur_return
);

PROCEDURE GetImageDescriptionBySku
(
  iPSku IN INT,
  curPout OUT cur_return
);

PROCEDURE GetImageInfo
(
  iPImageId IN INT,
  curPout OUT cur_return
);

PROCEDURE GetImgByImgId
(
  iPImageId IN INT,
  curPout OUT cur_return
);

PROCEDURE GetProdCover
(
  iPSku IN INT,
  curPout OUT cur_return
);

PROCEDURE GetSectionInfo
(
  iPSectionId IN INT,
  curPout OUT cur_return
);

PROCEDURE GetSectionList
(
  iPLang_id IN INT,
  curPout OUT cur_return
);

PROCEDURE GetSectionNameBySku
(
  iPSku IN INT,
  curPout OUT cur_return
);

PROCEDURE SetGalleryOverride
(
  iPSku IN INT,
  iPCanOverride IN INT
);

PROCEDURE UpdateImageDesc
(
  iPImageId IN INT,
  iPLangId IN INT,
  iPDescription IN NVARCHAR2
);

PROCEDURE UpdateImageInfo
(
  iPImageId IN INT,
  iPPriority IN INT,
  iPSectionId IN INT
);

PROCEDURE UpdateSectionInfo
(
  iPSectionId IN INT,
  iPLangId IN INT,
  iPSectionName IN NVARCHAR2,
  iPPriority IN INT
);

END PKG_FE_PROD_GALLERYACCESS;
/

CREATE OR REPLACE PACKAGE BODY PKG_FE_PROD_GALLERYACCESS AS

  PROCEDURE AddImage
(
  iPSku IN int,
  iPSection_id IN int,
  iPImage_path IN VARCHAR2,
  iPThumb_path IN VARCHAR2,
  iPDesc_en IN NVARCHAR2,
  iPDesc_b5 IN NVARCHAR2,
  iPDesc_jp IN NVARCHAR2,
  iPDesc_kr IN NVARCHAR2,
  iPDesc_gb IN NVARCHAR2,
  iPPriority IN INT,
  iPArrange_priority IN INT := 0,
  cPisCommit IN CHAR DEFAULT 'Y'
) AS
  intGalleryId int;
  intImageId int;
  intCounter int := 0;
  BEGIN
    /* Create New Gallery If Sku Does Not Have Gallery, And Get the gallery_id */
    SELECT count(*) into intCounter FROM ya_prod_gallery WHERE sku=iPSku;
    IF intCounter > 0 then
      SELECT gallery_id into intGalleryId  FROM ya_prod_gallery WHERE sku=iPSku and rownum = 1;
    ELSE
        SELECT count(*) into intCounter FROM ya_prod_gallery;
        IF intCounter > 0 then
          SELECT MAX(gallery_id) into intGalleryId  FROM ya_prod_gallery;
          intGalleryId := intGalleryId + 1;
        ELSE
          intGalleryId := 1;
        END IF;
        INSERT INTO ya_prod_gallery(gallery_id, sku) VALUES(intGalleryId, iPSku);
    END IF;
 
    /* Rearrange Priority If Sku Is For YesStyle */
    SELECT count(*) into intCounter FROM ya_prod_gallery_image WHERE gallery_id = intGalleryId AND priority = 0;
    IF (iPArrange_priority != 0  AND iPPriority = 0 AND intCounter > 0) then
        UPDATE ya_prod_gallery_image SET priority = priority + 1 WHERE gallery_id = intGalleryId;
    END IF;
    
    /* Insert Image */
    Select SEQ_imageid.NEXTVAL into intImageId from DUAL;
    INSERT INTO ya_prod_gallery_image( image_id, gallery_id, section_id, image_path, thumb_path, priority) 
    VALUES(intImageId, intGalleryId, iPSection_id, iPImage_path, iPThumb_path, iPPriority);
    
    /* Insert Image Description */
    INSERT INTO ya_prod_gallery_desc(image_id, lang_id, description) VALUES( intImageId, 1, iPDesc_en );
    INSERT INTO ya_prod_gallery_desc(image_id, lang_id, description) VALUES( intImageId, 2, iPDesc_b5 );
    INSERT INTO ya_prod_gallery_desc(image_id, lang_id, description) VALUES( intImageId, 3, iPDesc_jp );
    INSERT INTO ya_prod_gallery_desc(image_id, lang_id, description) VALUES( intImageId, 4, iPDesc_kr );
    INSERT INTO ya_prod_gallery_desc(image_id, lang_id, description) VALUES( intImageId, 5, iPDesc_gb );
    
    IF cPisCommit = 'Y' THEN
      BEGIN
        COMMIT;
      END;
    END IF;

    RETURN;
    EXCEPTION WHEN OTHERS THEN
      BEGIN
        ROLLBACK;
        RETURN;
      END;
  END AddImage;

  PROCEDURE AddSection
(
  iPName_en IN NVARCHAR2,
  iPName_b5 IN NVARCHAR2,
  iPName_jp IN NVARCHAR2,
  iPName_kr IN NVARCHAR2,
  iPName_gb IN NVARCHAR2,
  iPPriority IN int
) AS
  intSection_id int;
  BEGIN
    /* Get the new section_id */
    BEGIN
      SELECT MAX(section_id) into intSection_id  FROM ya_prod_gallery_section;
      intSection_id := intSection_id + 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          intSection_id := 1;
        END;
    END;
    
    /* Insert Section */
    INSERT INTO ya_prod_gallery_section(section_id, lang_id, section_name) VALUES( intSection_id, 1,  iPName_en );
    INSERT INTO ya_prod_gallery_section(section_id, lang_id, section_name) VALUES( intSection_id, 2,  iPName_b5 );
    INSERT INTO ya_prod_gallery_section(section_id, lang_id, section_name) VALUES( intSection_id, 3,  iPName_jp );
    INSERT INTO ya_prod_gallery_section(section_id, lang_id, section_name) VALUES( intSection_id, 4,  iPName_kr );
    INSERT INTO ya_prod_gallery_section(section_id, lang_id, section_name) VALUES( intSection_id, 5,  iPName_gb );

    update ya_prod_gallery_section set priority = iPPriority where section_id = intSection_id;

    COMMIT;
    RETURN;
    EXCEPTION WHEN OTHERS THEN
      BEGIN
        ROLLBACK;
        RETURN;
      END;
  END AddSection;

  PROCEDURE CanGalleryOverride
(
  iPSku IN INT,
  curPout OUT cur_return
) AS
  counter int;
  BEGIN
    SELECT count(1) into counter FROM ya_prod_gallery WHERE sku=iPSku ;
    IF counter > 0 THEN
      OPEN curPout FOR
        SELECT canOverride FROM ya_prod_gallery WHERE sku = iPSku;
    ELSE
      OPEN curPout FOR
        SELECT 1 from dual;
    END IF;
    
    RETURN;
  END CanGalleryOverride;

  PROCEDURE DeleteImage
(
  iPImage_id_csv IN VARCHAR2
) AS
  BEGIN
    DELETE FROM ya_prod_gallery_image WHERE image_id IN ( iPImage_id_csv );
    DELETE FROM ya_prod_gallery_desc WHERE image_id IN ( iPImage_id_csv );

    COMMIT;
    RETURN;
    EXCEPTION WHEN OTHERS THEN
      BEGIN
        ROLLBACK;
        RETURN;
      END;
  END DeleteImage;

  PROCEDURE GetGalleryStatBySku
(
  iPSku IN INT,
  iPSection_id IN INT,
  curPout OUT cur_return
) AS
  gallery_id int;
  counter int;
  BEGIN
    -- Counter to check there exist any rows in table ya_prod_gallery with that sku
    -- Exist : > 0
    -- Not Exist : = 0
    SELECT count(*) into counter FROM ya_prod_gallery WHERE skU=iPSku;

    IF counter = 0 THEN
      BEGIN
        -- Counter to check there exist any rows in table ya_prod_gallery
        -- Exist : > 0
        -- Not Exst : = 0
        SELECT count(*) into counter FROM ya_prod_gallery;
        
        IF counter > 0 Then
          Begin
            SELECT MAX(gallery_id) into gallery_id  FROM ya_prod_gallery;
            gallery_id := gallery_id + 1;
          End;
        Else
          gallery_id := 1;
        End If;
        INSERT INTO ya_prod_gallery(gallery_id, sku, canOverride) VALUES(gallery_id, iPSku, 1);
      End;
    END IF;

    -- Counter to check there exists any rows
    -- Exists : > 0
    -- Not Exists : = 0
    SELECT count(*) into counter FROM ya_prod_gallery a, ya_prod_gallery_image b 
    WHERE a.gallery_id=b.gallery_id AND a.sku=iPSku AND b.section_id=iPSection_id AND b.thumb_path not LIKE '%/%';
    
    IF counter = 0 Then
      Begin
        OPEN curPout FOR
        SELECT gallery_id, iPSection_id as section_id, '' as max_filename FROM ya_prod_gallery 
        WHERE sku=iPSku;
      End;
    Else
      Begin
        OPEN curPout FOR
        SELECT b.gallery_id, b.section_id, max(thumb_path) as max_filename FROM ya_prod_gallery a, ya_prod_gallery_image b WHERE a.gallery_id=b.gallery_id AND a.sku=iPSku AND b.section_id=iPSection_id AND b.thumb_path not LIKE '%/%'
        GROUP BY b.gallery_id, b.section_id;
      End;
    End IF;
    
    RETURN;
  END GetGalleryStatBySku;

  PROCEDURE GetImageBySku
(
  iPSku IN int,
  iPLang_id IN int,
  curPout OUT cur_return
) AS
  BEGIN
    OPEN curPout FOR
    /* Get All Image Gallery Of Specified Sku */
    SELECT 
    b.section_id, 
    b.section_name, 
    c.image_id, 
    c.image_path, 
    c.thumb_path, 
    d.description, 
    c.priority as priority, 
    b.priority as section_priority
    FROM ya_prod_gallery a, ya_prod_gallery_section b, ya_prod_gallery_image c, ya_prod_gallery_desc d
    WHERE a.gallery_id=c.gallery_id AND b.section_id=c.section_id AND  c.image_id=d.image_id
    AND a.sku = iPSku AND b.lang_id=iPLang_id AND d.lang_id=iPLang_id
    ORDER BY section_priority, b.section_id, c.priority, c.image_id;

    RETURN;
  END GetImageBySku;

  PROCEDURE GetImageDescriptionBySku
(
  iPSku IN INT,
  curPout OUT cur_return
) AS
  BEGIN
    /* Get All Image Gallery Of Specified Sku */
    OPEN curPout FOR
      SELECT image_id, lang_id, description
      FROM ya_prod_gallery_desc
      WHERE image_id IN(
           SELECT b.image_id
           FROM ya_prod_gallery a, ya_prod_gallery_image B
           WHERE a.gallery_id=b.gallery_id
           AND a.sku = iPSku
      )
      ORDER BY image_id, lang_id;
    RETURN;
  END GetImageDescriptionBySku;

  PROCEDURE GetImageInfo
(
  iPImageId IN INT,
  curPout OUT cur_return
) AS
  BEGIN
    OPEN curPout FOR
      SELECT
	ya_prod_gallery_image.image_id AS image_id, 
	ya_prod_gallery_image.gallery_id AS gallery_id, 
	ya_prod_gallery_image.section_id AS section_id, 
	ya_prod_gallery_image.image_path AS image_path, 
	ya_prod_gallery_image.thumb_path AS thumb_path, 
	ya_prod_gallery_image.priority AS priority, 
	ya_prod_gallery_desc.lang_id AS lang_id, 
	ya_prod_gallery_desc.description AS description, 
	ya_prod_gallery.sku AS sku
      FROM
	ya_prod_gallery_image INNER JOIN
	ya_prod_gallery_desc ON 
	ya_prod_gallery_image.image_id = ya_prod_gallery_desc.image_id INNER JOIN
	ya_prod_gallery ON 
	ya_prod_gallery_image.gallery_id = ya_prod_gallery.gallery_id
      WHERE
	ya_prod_gallery_image.image_id = iPImageId;
    RETURN;
  END GetImageInfo;

  PROCEDURE GetImgByImgId
(
  iPImageId IN INT,
  curPout OUT cur_return
) AS
  BEGIN
    /* TODO implementation required */
    OPEN curPout FOR
      SELECT * FROM ya_prod_gallery_image 
      WHERE image_id = iPImageId;
    RETURN;
  END GetImgByImgId;

  PROCEDURE GetProdCover
(
  iPSku IN INT,
  curPout OUT cur_return
) AS
  BEGIN
    OPEN curPout FOR
      SELECT cover_img_loc, cover_img_width, cover_img_height 
      FROM ya_product
      WHERE sku = iPSku;
    RETURN;
  END GetProdCover;

  PROCEDURE GetSectionInfo
(
  iPSectionId IN INT,
  curPout OUT cur_return
) AS
  BEGIN
    OPEN curPout FOR
      select * from ya_prod_gallery_section where section_id = iPSectionId;
    Return;
  END GetSectionInfo;

  PROCEDURE GetSectionList
(
  iPLang_id IN INT,
  curPout OUT cur_return
) AS
  BEGIN
    OPEN curPout FOR
      /* Get All Image Gallery Of Specified Sku */
      SELECT section_id, section_name, priority
      FROM ya_prod_gallery_section
      WHERE lang_id=iPLang_id
      ORDER BY section_name;
    RETURN;
  END GetSectionList;

  PROCEDURE GetSectionNameBySku
(
  iPSku IN INT,
  curPout OUT cur_return
) AS
  BEGIN
    OPEN curPout FOR
      /* Get All Image Gallery Of Specified Sku */
      SELECT section_id, lang_id, section_name
      FROM ya_prod_gallery_section
      WHERE section_id IN(
         SELECT b.section_id
         FROM ya_prod_gallery a, ya_prod_gallery_image b
         WHERE a.gallery_id=b.gallery_id
         AND a.sku = iPSku
      )
      ORDER BY section_id, lang_id;
    RETURN;
  END GetSectionNameBySku;

  PROCEDURE SetGalleryOverride
(
  iPSku IN INT,
  iPCanOverride IN int
) AS
  BEGIN
    UPDATE ya_prod_gallery SET canOverride = iPCanOverride WHERE sku = iPSku;
    COMMIT;
    RETURN;
  EXCEPTION WHEN OTHERS THEN
    BEGIN
      ROLLBACK;
      RETURN;
    END;
  END SetGalleryOverride;

  PROCEDURE UpdateImageDesc
(
  iPImageId IN INT,
  iPLangId IN INT,
  iPDescription IN NVARCHAR2
) AS
  BEGIN
    UPDATE ya_prod_gallery_desc
    SET	description = iPDescription
    WHERE image_id = iPImageId
    AND lang_id = iPLangId;
    COMMIT;
    RETURN;
  EXCEPTION WHEN OTHERS THEN
    BEGIN
      ROLLBACK;
      RETURN;
    END;
  END UpdateImageDesc;

  PROCEDURE UpdateImageInfo
(
  iPImageId IN INT,
  iPPriority IN INT,
  iPSectionId IN INT
) AS
  BEGIN
    UPDATE ya_prod_gallery_image
    SET	section_id = iPSectionId,
    priority = iPPriority
    WHERE image_id = iPImageId;
    COMMIT;
    RETURN;
  EXCEPTION WHEN OTHERS THEN
    BEGIN
      ROLLBACK;
      RETURN;
    END;
  END UpdateImageInfo;

  PROCEDURE UpdateSectionInfo
(
  iPSectionId IN INT,
  iPLangId IN INT,
  iPSectionName IN NVARCHAR2,
  iPPriority IN INT
) AS
  BEGIN
    UPDATE ya_prod_gallery_section
    SET section_name = iPSectionName,
    priority = iPPriority
    where section_id = iPSectionId
    and lang_id = iPLangId;
    COMMIT;
    RETURN;
  EXCEPTION WHEN OTHERS THEN
    BEGIN
      ROLLBACK;
      RETURN;
    END;
  END UpdateSectionInfo;

END PKG_FE_PROD_GALLERYACCESS;
/