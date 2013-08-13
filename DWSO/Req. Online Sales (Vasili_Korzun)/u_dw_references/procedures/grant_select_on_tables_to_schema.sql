/* Formatted on 8/5/2013 3:15:46 PM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PROCEDURE grant_select_tables_to_schema
AS
   CURSOR cur_t
   IS
      SELECT table_name
        FROM user_tables
       WHERE table_name LIKE 'T%'
          OR  table_name LIKE 'LC%';

   schema_name    VARCHAR2 ( 40 );
   grant_statement varchar2(200) default null;
BEGIN
   schema_name := 'u_dw_ext_references';

   FOR tab IN cur_t LOOP
   grant_statement := 'grant select on '|| tab.table_name||' to ' || schema_name ;
     EXECUTE IMMEDIATE grant_statement;
    --dbms_output.put_line(grant_statement);
   END LOOP;
   exception when others
   then raise;
END grant_select_tables_to_schema;


begin
grant_select_tables_to_schema;
end;

