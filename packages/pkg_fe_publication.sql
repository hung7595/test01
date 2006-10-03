CREATE OR REPLACE PACKAGE pkg_fe_publication AS

TYPE cur_return IS REF CURSOR;

PROCEDURE AddPublication
(
  dPpostingDate IN DATE,
  iPpublicationId OUT INT
);
PROCEDURE UpdatePublication
(
  iPpublicationId IN INT,
  dPpostingDate IN DATE
);
PROCEDURE UpdatePublicationContent
(
  iPpublicationId IN INT,
  cPtitle IN NVARCHAR2,
  cPcontent IN NCLOB,
  iPlangId IN INT
);
PROCEDURE AddPublicationSite
(
  iPpublicationId IN INT,
  iPsiteId IN INT
);
PROCEDURE DeletePublicationSite
(
  iPpublicationId IN INT,
  iPsiteId IN INT
);
PROCEDURE GetAllPublication
(
  curPout1 OUT cur_return
);
PROCEDURE GetPublicationAllLang
(
  iPpublicationId IN INT,
  curPout1 OUT cur_return,
  curPout2 OUT cur_return,
  curPout3 OUT cur_return
);
PROCEDURE GetPublicationByPage
(
  iPsiteId IN INT,
  iPlangId IN INT,
  iPpageIndex IN INT,
  iPpageSize IN INT,
  iPtotalCount OUT INT,
  curPout1 OUT cur_return
);
PROCEDURE GetPublication
(
  iPpublicationId IN INT,
  iPsiteId IN INT,
  iPlangId IN INT,
  curPout1 OUT cur_return
);

END pkg_fe_publication;
/


CREATE OR REPLACE PACKAGE BODY pkg_fe_publication AS

PROCEDURE AddPublication
(
  dPpostingDate IN DATE,
  iPpublicationId OUT INT
)
IS
BEGIN

  SELECT SEQ_YA_PUBLICATION.NEXTVAL INTO iPpublicationId FROM dual;
  INSERT INTO YA_PUBLICATION(publication_id, posting_date) VALUES(iPpublicationId, dPpostingDate);
  IF (SQLCODE=0) THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;

END AddPublication;

PROCEDURE UpdatePublication
(
  iPpublicationId IN INT,
  dPpostingDate IN DATE
)
IS
BEGIN

  UPDATE YA_PUBLICATION SET posting_date = dPpostingDate WHERE publication_id = iPpublicationId;

END UpdatePublication;

PROCEDURE UpdatePublicationContent
(
  iPpublicationId IN INT,
  cPtitle IN NVARCHAR2,
  cPcontent IN NCLOB,
  iPlangId IN INT
)
IS
  iPcount INT;
BEGIN

  SELECT COUNT(1) INTO iPcount FROM YA_PUBLICATION_LANG WHERE publication_id = iPpublicationId AND lang_id = iPlangId;
  IF (iPcount<1) THEN
    BEGIN
      INSERT INTO YA_PUBLICATION_LANG(publication_id, lang_id, title, content) VALUES(iPpublicationId, iPlangId, cPtitle, cPcontent);
    END;
  ELSE
    BEGIN
      UPDATE YA_PUBLICATION_LANG SET title = cPtitle, content = cPcontent WHERE publication_id = iPpublicationId AND lang_id = iPlangId;
    END;
  END IF;
  IF (SQLCODE=0) THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;

END UpdatePublicationContent;

PROCEDURE AddPublicationSite
(
  iPpublicationId IN INT,
  iPsiteId IN INT
)
IS
BEGIN

  INSERT INTO YA_PUBLICATION_SITE(publication_id, site_id) VALUES(iPpublicationId, iPsiteId);
  IF (SQLCODE=0) THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;

END AddPublicationSite;

PROCEDURE DeletePublicationSite
(
  iPpublicationId IN INT,
  iPsiteId IN INT
)
IS
BEGIN

  DELETE YA_PUBLICATION_SITE WHERE publication_id = iPpublicationId AND site_id = iPsiteId;
  IF (SQLCODE=0) THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;

END DeletePublicationSite;

PROCEDURE GetAllPublication
(
  curPout1 OUT cur_return
)
IS
BEGIN

  OPEN curPout1 FOR
  SELECT
    p.publication_id,
    p.posting_date,
    pl.lang_id,
    pl.title,
    pl.content
  FROM YA_PUBLICATION p
  inner join YA_PUBLICATION_LANG pl
  ON p.publication_id = pl.publication_id
  WHERE pl.lang_id = 1;

END GetAllPublication;

PROCEDURE GetPublicationAllLang
(
  iPpublicationId IN INT,
  curPout1 OUT cur_return,
  curPout2 OUT cur_return,
  curPout3 OUT cur_return
)
IS
BEGIN

  OPEN curPout1 FOR
  SELECT
    publication_id,
    posting_date
  FROM YA_PUBLICATION
  WHERE publication_id = iPpublicationId;

  OPEN curPout2 FOR
  SELECT
    lang_id,
    title,
    content
  FROM YA_PUBLICATION_LANG
  WHERE publication_id = iPpublicationId;

  OPEN curPout3 FOR
  SELECT
    site_id
  FROM YA_PUBLICATION_SITE
  WHERE publication_id = iPpublicationId;

END GetPublicationAllLang;


PROCEDURE GetPublicationByPage
(
  iPsiteId IN INT,
  iPlangId IN INT,
  iPpageIndex IN INT,
  iPpageSize IN INT,
  iPtotalCount OUT INT,
  curPout1 OUT cur_return
)
IS
  iPstartRowNum INT;
BEGIN

  SELECT (iPpageIndex*iPpageSize)+1 INTO iPstartRowNum FROM dual;
  SELECT COUNT(1) INTO iPtotalCount FROM YA_PUBLICATION_SITE WHERE site_id = iPsiteId;
  OPEN curPout1 FOR
  SELECT *
  FROM
  (
    SELECT
      p.publication_id,
      p.posting_date,
      pl.title,
      pl.content,
      pl.lang_id
    FROM YA_PUBLICATION p
    inner join YA_PUBLICATION_SITE ps ON p.publication_id = ps.publication_id AND ps.site_id = iPsiteId
    inner join YA_PUBLICATION_LANG pl ON p.publication_id = pl.publication_id AND pl.lang_id = iPlangId
    WHERE posting_date<=
    (
      SELECT posting_date
      FROM
      (
        SELECT posting_date
        FROM YA_PUBLICATION
        ORDER BY posting_date DESC
      )
      WHERE ROWNUM = iPstartRowNum
    )
    ORDER BY posting_date DESC
  ) WHERE ROWNUM<=iPpageSize;

END GetPublicationByPage;

PROCEDURE GetPublication
(
  iPpublicationId IN INT,
  iPsiteId IN INT,
  iPlangId IN INT,
  curPout1 OUT cur_return
)
IS
BEGIN

  OPEN curPout1 FOR
  SELECT
    p.publication_id,
    p.posting_date,
    pl.lang_id,
    pl.title,
    pl.content
  FROM YA_PUBLICATION p
  inner join YA_PUBLICATION_LANG pl ON p.publication_id = pl.publication_id
  inner join YA_PUBLICATION_SITE ps ON p.publication_id = ps.publication_id
  WHERE p.publication_id = iPpublicationId AND pl.lang_id = iPlangId AND ps.site_id = iPsiteId;

END GetPublication;

END pkg_fe_publication;
/
