/* Formatted on 06.08.2013 11:13:52 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY exc_lab
AS
   PROCEDURE exc_outer ( numb IN NUMBER )
   AS
      n              NUMBER;
      out_exc_b      EXCEPTION;

      PROCEDURE exc_inner ( exc_num IN NUMBER )
      AS
         exc_a          EXCEPTION;
         exc_b          EXCEPTION;
         exc_c          EXCEPTION;
      BEGIN
         CASE
            WHEN exc_num = 1 THEN
               RAISE exc_a;
            WHEN exc_num = 0 THEN
               RAISE exc_b;
         END CASE;
      EXCEPTION
         WHEN exc_a THEN
            raise_application_error ( -20001
                                    , 'Error is placed on the stack of previous errors'
                                    , TRUE );
         WHEN exc_b THEN
            RAISE out_exc_b;
         WHEN case_not_found THEN
            raise_application_error ( -20001
                                    , 'Predefined Oracle Server Error, replace all'
                                    , FALSE );
      END exc_inner;
   BEGIN
      n           := numb;

      exc_inner ( n );

      dbms_output.put_line ( 'error occured ' || 500 / n );
   EXCEPTION
      WHEN ZERO_DIVIDE THEN
         raise_application_error ( -20001
                                 , 'Predefined Oracle Server Error, should be putted iin stack'
                                 , TRUE );
      WHEN out_exc_b THEN
         raise_application_error ( -20001
                                 , 'Error replaces all previous errors'
                                 , TRUE );
   END exc_outer;
END exc_lab;