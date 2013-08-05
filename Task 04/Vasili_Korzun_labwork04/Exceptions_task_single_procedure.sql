--good manual about error handling I've read on http://docs.oracle.com/cd/B10501_01/appdev.920/a96624/07_errs.htm

DECLARE
   num            NUMBER;
   first_exc      EXCEPTION;
   second_exc     EXCEPTION;
   others_exc     EXCEPTION;
BEGIN
   num         := :p_num;
   DECLARE
      exc_1          EXCEPTION;
      exc_2          EXCEPTION;
      exc_3          EXCEPTION;
   BEGIN
      -- exceptions FIRST_EXC and SECOND_EXC are raised throug inner block exceptions EXC_1 and EXC_2
      -- exception OTHERS_EXC is raised directly
      IF num = 1 THEN
         RAISE exc_1;
      ELSIF num = 2 THEN
         RAISE exc_2;
      ELSIF num = 3 THEN
         RAISE exc_3;
      ELSE
         RAISE others_exc;
      END IF;
   EXCEPTION
      WHEN exc_1 THEN
         RAISE first_exc;
         num         := 0;
      WHEN exc_2 THEN
         RAISE second_exc;
      WHEN exc_3 THEN
         RAISE exc_3; -- re-raising the same exception
      WHEN others_exc THEN
         RAISE others_exc;
      WHEN OTHERS THEN
         raise_application_error ( -20111                                 , 'This exception should not be raised' );
   END;
EXCEPTION
   WHEN first_exc THEN
      raise_application_error ( -20111                              , 'Value ''1'' entered' );
   WHEN second_exc THEN
      raise_application_error ( -20112                              , 'Value ''2'' entered' );
   WHEN others_exc THEN
      raise_application_error ( -20111                              , 'Unknown value entered' );
END;


