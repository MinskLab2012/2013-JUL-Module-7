CREATE OR REPLACE PACKAGE BODY exc_training
AS
   
         p_exc exception;
   PROCEDURE outer_proc ( num NUMBER )
   IS
   o_exc_1        EXCEPTION;
      PROCEDURE inner_proc ( n NUMBER )
      IS
         i_num          NUMBER DEFAULT 0;
         i_exc_1        EXCEPTION;
         i_exc_2        EXCEPTION;
      BEGIN
      
         IF n = 1 THEN
            RAISE i_exc_1;
         ELSIF n = 2 THEN
            RAISE i_exc_2;
         ELSE

            NULL;
         END IF;
      EXCEPTION
         WHEN i_exc_1 THEN
            raise_application_error ( -20133                                    , 'Inner. Num = 1' );
         WHEN i_exc_2 THEN
            --raise_application_error ( -20133                                    , 'Inner. Num = 2' );
         raise o_exc_1;
         --raise p_exc;
      END inner_proc;
      
   BEGIN
      inner_proc ( num );
      --RAISE o_exc_1;
      --raise p_exc;
      
   EXCEPTION
      WHEN o_exc_1 THEN
         --raise_application_error(-20234, 'Outer procedure exception raised');
         RAISE p_exc;
        --when p_exc then       raise_application_error ( -20234                              , 'Packaised' );
   END outer_proc;
   
BEGIN
null;
    outer_proc ( 2 );
EXCEPTION
   WHEN p_exc THEN
      raise_application_error ( -20234                              , 'Package exception raised' );
END exc_training;


BEGIN

exc_training.outer_proc(2);
END;



/* Formatted on 8/5/2013 12:43:01 PM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE exc_training
AS
   --PROCEDURE inner_proc ( n NUMBER );
   PROCEDURE outer_proc ( num NUMBER );

END;
