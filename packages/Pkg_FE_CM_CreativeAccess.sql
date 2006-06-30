CREATE OR REPLACE package Pkg_FE_CM_CreativeAccess
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetCreativeText (
        iPfileId IN INT,
	iPsiteId IN INT,
    iPlangId IN INT,
    curPresult1 OUT refCur
  );
   PROCEDURE GetCreativeText_Mirror (
        iPfileId IN INT,
	iPsiteId IN INT,
    iPlangId IN INT,
    curPresult1 OUT refCur
  );
  PROCEDURE GetCreativeButton (
        iPfileId IN INT,
	iPsiteId IN INT,
    iPlangId IN INT,
    curPresult1 OUT refCur
  );
  PROCEDURE GetCreativeButton_Mirror (
        iPfileId IN INT,
	iPsiteId IN INT,
    iPlangId IN INT,
    curPresult1 OUT refCur
  );

END Pkg_FE_CM_CreativeAccess;
/

CREATE OR REPLACE package body Pkg_FE_CM_CreativeAccess
is
  PROCEDURE GetCreativeText (
    iPfileId IN INT,
    iPsiteId IN INT,
    iPlangId IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT c.creative_id,c.name,location,priority,content, c.creative_group_id, c.type
    from ya_cm_creative c,  ya_cm_creative_location cl,ya_cm_creative_text_lang  ctl

WHERE
c.creative_id=cl.creative_id and
c.creative_id=ctl.creative_id  and
cl.site_id=iPsiteId and cl.file_id=iPfileId and
ctl.lang_id=iPlangId and
c.type=1 and c.status<>3
 order by cl.location,cl.priority;
    RETURN;
  END GetCreativeText;
PROCEDURE GetCreativeText_Mirror (
    iPfileId IN INT,
    iPsiteId IN INT,
    iPlangId IN INT,
    curPresult1 OUT refCur
  )
  AS
  BEGIN
    OPEN curPresult1 FOR
    SELECT c.creative_id,c.name,location,priority,content, c.creative_group_id, c.type
    from ya_cm_mirror_creative c ,ya_cm_mirror_creative_location cl,ya_cm_mirror_creative_txt_lang  ctl
WHERE
c.creative_id=cl.creative_id and
c.creative_id=ctl.creative_id  and
cl.site_id=iPsiteId and cl.file_id=iPfileId and
ctl.lang_id=iPlangId and
c.type=1 and c.status<>3
 order by cl.location,cl.priority;
    RETURN;
  END GetCreativeText_Mirror;

  PROCEDURE GetCreativeButton (
     iPfileId IN INT,
    iPsiteId IN INT,
    iPlangId IN INT,
    curPresult1 OUT refCur
  )
  AS
   BEGIN
   OPEN curPresult1 FOR
    SELECT c.creative_id,c.name,location,priority,image_loc,NVL(cbl.image_width,0),NVL(cbl.image_height,0),cbl.alt,cbl.link_url, c.creative_group_id, c.type
    from ya_cm_creative c ,ya_cm_creative_location cl,ya_cm_creative_button_lang cbl
WHERE
c.creative_id=cl.creative_id and
 c.creative_id=cbl.creative_id and
cl.site_id=iPsiteId and cl.file_id=iPfileId and
cbl.lang_id=iPlangId and
c.type in (2,3) and c.status<>3
 order by cl.location,cl.priority;
    RETURN;
  END GetCreativeButton;
PROCEDURE GetCreativeButton_Mirror (
     iPfileId IN INT,
    iPsiteId IN INT,
    iPlangId IN INT,
    curPresult1 OUT refCur
  )
  AS
   BEGIN
   OPEN curPresult1 FOR
    SELECT c.creative_id,c.name,location,priority,image_loc,NVL(image_width,0),NVL(image_height,0),alt,link_url,  c.creative_group_id, c.type
    from ya_cm_mirror_creative c ,ya_cm_mirror_creative_location cl,ya_cm_mirror_creative_btn_lang cbl
WHERE
c.creative_id=cl.creative_id and
 c.creative_id=cbl.creative_id and
cl.site_id=iPsiteId and cl.file_id=iPfileId and
cbl.lang_id=iPlangId and
c.type in (2,3) and c.status<>3

 order by cl.location,cl.priority;
    RETURN;
  END GetCreativeButton_Mirror;


END Pkg_FE_CM_CreativeAccess;
/

