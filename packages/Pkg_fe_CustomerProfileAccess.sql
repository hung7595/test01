CREATE OR REPLACE PACKAGE Pkg_fe_CustomerProfileAccess
AS
  TYPE refcur IS ref CURSOR;
  PROCEDURE GetCustomerProfileInfo (
    cPshopper_id 		IN	CHAR,
    iPquestion_id		IN	INT 		DEFAULT	NULL,
    curPanswer_id 		OUT 	refcur

  );

  PROCEDURE GetCustomerProfile (
    cPshopper_id 		IN	CHAR,
    curPshopper_info 		OUT refcur
  );

  PROCEDURE UpdateCustomerProfile (
    cPshopper_id 		IN	CHAR,
    dtPbirthday			IN	DATE		DEFAULT NULL,
    iPeducation_level		IN	INT 		DEFAULT NULL,
    iPannual_income		IN	INT		DEFAULT NULL,
    iPgender			IN 	INT		DEFAULT NULL,
    iPethnicity			IN	INT		DEFAULT NULL,
    iPresidence_place		IN	INT		DEFAULT NULL,
    iPsite_id			IN	INT		DEFAULT 99
  );
   PROCEDURE UpdateCustomerProfile1 (
    cPshopper_id 		IN	CHAR,
    dtPbirthday			IN	CHAR		DEFAULT NULL,
    iPeducation_level		IN	INT 		DEFAULT NULL,
    iPannual_income		IN	INT		DEFAULT NULL,
    iPgender			IN 	INT		DEFAULT NULL,
    iPethnicity			IN	INT		DEFAULT NULL,
    iPresidence_place		IN	INT		DEFAULT NULL,
    iPsite_id			IN	INT		DEFAULT 99
  );

  PROCEDURE InsertCustomerProfileInfo (
    cPshopper_id 		IN	CHAR,
    iPsite_id			IN	INT,
    iPquestion_id		IN	INT,
    cPanswerCsv		 	IN	VARCHAR2
  );

  PROCEDURE InsertProfileInfoRemark (
    cPshopper_id 		IN	CHAR,
    iPsite_id			IN	INT,
    iPanswer_id		 	IN	INT,
    cPremark			IN	NVARCHAR2
  );

  PROCEDURE DeleteCustomerProfileInfo (
    cPshopper_id 		IN	CHAR,
    iPsite_id			IN	INT,
    iPquestion_id		IN	INT
  );

  PROCEDURE AddSurvey (
    iPsite_id 			IN 	INT,
    iPsurvey_code 		IN 	INT,
    cPsurvey_name 		IN 	VARCHAR2,
    cPemail 			IN 	VARCHAR2,
    cPquestion_id 		IN 	VARCHAR2,
    cPquestion_answer 		IN 	VARCHAR2,
    cPshopper_id 		IN 	CHAR
  );

  PROCEDURE UpdateSurveyStatus(
    cPshopper_id 		IN 	CHAR,
    iPsurvey_code 		IN 	INT,
    curPresult 			OUT 	refCur	
  );

 PROCEDURE GetSurveyStatusByShopperId (
    cPshopper_id		IN 	CHAR,
    curPresult 			OUT 	refCur
  );

 PROCEDURE GetSurveyStatusByQuestion (
    cPshopper_id		IN	CHAR,
    iPsurvey_code		IN	INT,
    iPresult			OUT	INT
  );
	
END Pkg_fe_CustomerProfileAccess;
/

CREATE OR REPLACE PACKAGE body Pkg_fe_CustomerProfileAccess
IS

  PROCEDURE GetCustomerProfileInfo (
    cPshopper_id 		IN	CHAR,
    iPquestion_id		IN	INT 		DEFAULT	NULL,
    curPanswer_id 		OUT 	refcur

  )
  AS
  BEGIN
    IF iPquestion_id is NULL THEN
        OPEN curPanswer_id FOR	
	SELECT answer_id, remark FROM ya_customer_profile_info WHERE shopper_id = cPshopper_id UNION
	SELECT DISTINCT lookup_id AS answer_id, null as remark FROM ya_customer_profile_lookup ycpl
	WHERE EXISTS (SELECT 1 FROM ya_customer_profile ycp WHERE 
		(ycp.shopper_id = cPshopper_id) AND 
			(
				ycp.education_level = ycpl.lookup_id 
				OR ycp.annual_income = ycpl.lookup_id 
				OR ycp.gender = ycpl.lookup_id 
				OR ycp.residence_place = ycpl.lookup_id
				OR ycp.ethnicity = ycpl.lookup_id
			)
		);
    ELSE
        OPEN curPanswer_id FOR
	SELECT answer_id, remark FROM ya_customer_profile_info WHERE shopper_id = cPshopper_id AND question_id = iPquestion_id;
    END IF;

  END GetCustomerProfileInfo;

  PROCEDURE GetCustomerProfile (
    cPshopper_id 		IN	CHAR,
    curPshopper_info 		OUT 	refcur
  )
  AS
  BEGIN
    OPEN curPshopper_info FOR
	SELECT 	p.birthday, p.education_level, p.annual_income, 
		p.gender, p.ethnicity, p.residence_place, 
		s.password, s.email, s.firstname, s.lastname, s.nickname 
	FROM ya_customer_profile p INNER JOIN ya_shopper s 
	ON p.shopper_id = s.shopper_id
	WHERE p.shopper_id = cPshopper_id;

  END GetCustomerProfile;


  PROCEDURE UpdateCustomerProfile (
    cPshopper_id 		IN	CHAR,
    dtPbirthday			IN	DATE		DEFAULT NULL,
    iPeducation_level		IN	INT 		DEFAULT NULL,
    iPannual_income		IN	INT		DEFAULT NULL,
    iPgender			IN 	INT		DEFAULT NULL,
    iPethnicity			IN	INT		DEFAULT NULL,
    iPresidence_place		IN	INT		DEFAULT NULL,
    iPsite_id			IN	INT		DEFAULT 99
  )
  AS
    iLProfileExist INT;
  BEGIN
    BEGIN
    	SELECT 1 INTO iLProfileExist FROM ya_customer_profile WHERE shopper_id = cPshopper_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      iLProfileExist := -1;
    END;   

    IF iLProfileExist > 0 THEN
      UPDATE ya_customer_profile SET
        birthday = dtPbirthday,
        education_level = iPeducation_level,
        annual_income = iPannual_income,
        gender = iPgender,
        ethnicity = iPethnicity,
        residence_place = iPresidence_place,
        updated_datetime = sysdate
      WHERE shopper_id = cPshopper_id;
      
    ELSE
      INSERT INTO ya_customer_profile
	(shopper_id, birthday, education_level, annual_income, gender, ethnicity,
         residence_place, register_site_id, created_datetime, updated_datetime)
      VALUES
        (cPshopper_id, dtPbirthday, iPeducation_level, iPannual_income, iPgender, iPethnicity,
         iPresidence_place, iPsite_id, sysdate(), sysdate());
    END IF;
  COMMIT;
  END UpdateCustomerProfile;
  
  PROCEDURE UpdateCustomerProfile1 (
    cPshopper_id 		IN	CHAR,
    dtPbirthday			IN	CHAR		DEFAULT NULL,
    iPeducation_level		IN	INT 		DEFAULT NULL,
    iPannual_income		IN	INT		DEFAULT NULL,
    iPgender			IN 	INT		DEFAULT NULL,
    iPethnicity			IN	INT		DEFAULT NULL,
    iPresidence_place		IN	INT		DEFAULT NULL,
    iPsite_id			IN	INT		DEFAULT 99
  )
  AS
    iLProfileExist INT;
  BEGIN
    BEGIN
    	SELECT 1 INTO iLProfileExist FROM ya_customer_profile WHERE shopper_id = cPshopper_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      iLProfileExist := -1;
    END;   

    IF iLProfileExist > 0 THEN
      UPDATE ya_customer_profile SET
        birthday = TO_DATE(dtPbirthday,'yyyy/mm/dd'),
        education_level = iPeducation_level,
        annual_income = iPannual_income,
        gender = iPgender,
        ethnicity = iPethnicity,
        residence_place = iPresidence_place,
        updated_datetime = sysdate
      WHERE shopper_id = cPshopper_id;
      
    ELSE
      INSERT INTO ya_customer_profile
	(shopper_id, birthday, education_level, annual_income, gender, ethnicity,
         residence_place, register_site_id, created_datetime, updated_datetime)
      VALUES
        (cPshopper_id, dtPbirthday, iPeducation_level, iPannual_income, iPgender, iPethnicity,
         iPresidence_place, iPsite_id, sysdate(), sysdate());
    END IF;
  COMMIT;
  END UpdateCustomerProfile1;

  PROCEDURE InsertCustomerProfileInfo (
    cPshopper_id 		IN	CHAR,
    iPsite_id			IN	INT,
    iPquestion_id		IN	INT,
    cPanswerCsv		 	IN	VARCHAR2
  )
  AS
    iLstartAnswerPos  		INT := 1;
    iLendAnswerPos  		INT;
    iLtemp 			INT;
    cLanswerCsv 		VARCHAR2(300);
  BEGIN
    iLtemp := LENGTH(RTRIM(cPanswerCsv));
    IF(iLtemp) > 0 THEN
    BEGIN
      DELETE FROM ya_customer_profile_info WHERE shopper_id = cPshopper_id AND site_id = iPsite_id AND question_id = iPquestion_id;
      iLendAnswerPos := INSTR(cPanswerCsv, ',');
      cLanswerCsv := cPanswerCsv;
      WHILE  iLendAnswerPos  >  0
      LOOP
        INSERT INTO ya_customer_profile_info
    	  (shopper_id, site_id, question_id, answer_id, remark)
        VALUES
	  ( cPshopper_id, 
	    iPsite_id, 
	    iPquestion_id, 
	    CAST(SUBSTR(cLanswerCsv, iLstartanswerPos, iLendanswerPos - iLstartanswerPos) as INT),
	    null);
        cLanswerCsv := SUBSTR(cLanswerCsv, iLendanswerPos + 1, LENGTH(RTRIM(cLanswerCsv)) - iLendanswerPos);
        iLendanswerPos := INSTR(cLanswerCsv, ',');
      END LOOP;
    END;
    END IF;
    COMMIT;
  END InsertCustomerProfileInfo;

  PROCEDURE InsertProfileInfoRemark (
    cPshopper_id 		IN	CHAR,
    iPsite_id			IN	INT,
    iPanswer_id		 	IN	INT,
    cPremark			IN	NVARCHAR2
  )
  AS
  BEGIN
      UPDATE ya_customer_profile_info SET
	remark = cPremark
      WHERE shopper_id = cPshopper_id AND site_id = iPsite_id AND answer_id = iPanswer_id;
  COMMIT;

  END InsertProfileInfoRemark;

  PROCEDURE DeleteCustomerProfileInfo (
    cPshopper_id 		IN	CHAR,
    iPsite_id			IN	INT,
    iPquestion_id		IN	INT
  )
  AS
  BEGIN
      DELETE FROM ya_customer_profile_info WHERE shopper_id = cPshopper_id AND site_id = iPsite_id AND question_id = iPquestion_id;
  COMMIT;

  END DeleteCustomerProfileInfo;


  PROCEDURE AddSurvey (
        iPsite_id 		IN 	INT,
	iPsurvey_code 		IN 	INT,
	cPsurvey_name 		IN 	VARCHAR2,
	cPemail 		IN 	VARCHAR2,
	cPquestion_id 		IN 	VARCHAR2,
	cPquestion_answer 	IN 	VARCHAR2,
	cPshopper_id 		IN 	CHAR
  )
  AS
  BEGIN
	INSERT INTO ya_survey_answer 
          (site_id, survey_code, survey_name, email, answer_datetime, question_id, question_answer, rowguid, shopper_id)
	VALUES 
          (iPsite_id, iPsurvey_code, cPsurvey_name, cPemail, sysdate, cPquestion_id, cPquestion_answer, sys_guid(), cPshopper_id);
  END AddSurvey;
	

  PROCEDURE UpdateSurveyStatus(
    cPshopper_id 		IN 	CHAR,
    iPsurvey_code 		IN 	INT,
    curPresult 			OUT 	refCur	
  )
  AS
  iLCompletedSurvey INT;
  BEGIN
     begin
      SELECT survey_code INTO iLCompletedSurvey FROM ya_survey_customer_list
      WHERE shopper_id=cPshopper_id AND survey_code=iPsurvey_code;
	  
    EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
        iLCompletedSurvey := -1;
      END;
    end;

    IF iLCompletedSurvey > 0 THEN
      BEGIN
	UPDATE ya_survey_customer_list
        SET completed = 'Y', updated_datetime = SYSDATE
	WHERE shopper_id = cPshopper_id AND survey_code = iPsurvey_code;
      END;
    ELSE
      BEGIN
        INSERT INTO ya_survey_customer_list
          (shopper_id, survey_code, completed, created_datetime, updated_datetime)
	VALUES
	  (cPshopper_id, iPsurvey_code,'Y',sysdate,sysdate);
	END;
    END IF;
    Pkg_FE_CouponAccess.CreateYSSurveyCoupon(cPshopper_id,curPresult);
  
  END UpdateSurveyStatus;

  PROCEDURE GetSurveyStatusByShopperId (
    cPshopper_id 		IN 	CHAR,
    curPresult 			OUT 	refCur
  )
  AS

  BEGIN
    OPEN curPresult FOR
      SELECT survey_code, completed 
      FROM ya_survey_customer_list 
      WHERE shopper_id = cPshopper_id;

  END GetSurveyStatusByShopperId;

  PROCEDURE GetSurveyStatusByQuestion (
    cPshopper_id		IN	CHAR,
    iPsurvey_code		IN	INT,
    iPresult			OUT	INT
  )
  AS
  BEGIN
    SELECT 1 INTO iPresult FROM ya_survey_customer_list 
    WHERE shopper_id = cPshopper_id AND survey_code = iPsurvey_code AND completed = 'N';
  EXCEPTION WHEN NO_DATA_FOUND THEN
      iPresult := 0;
 
  END GetSurveyStatusByQuestion;

END Pkg_fe_CustomerProfileAccess;
/