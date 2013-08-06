DECLARE
str NUMBER;
BEGIN
str := :g;
exc_lab.exc_outer(str);
END;