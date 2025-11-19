CREATE OR REPLACE PROCEDURE hello_user
  (username VARCHAR2 := NULL)
AS
BEGIN
  IF username IS NOT NULL THEN
    HTP.PRINT('<p>Hello ' || username || '!');
    RETURN;
  END IF;
  IF (name IS NULL)
  THEN
    HTP.PRINT('<p><b>Please submit your username.</b>');
  END IF;
END;
/