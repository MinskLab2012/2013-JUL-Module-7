/* Formatted on 03.08.2013 20:19:01 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE pkg_etl_dim_programs_dw
-- Package Reload Data about Managers, Programs  From Source table Programs
--
AS
   PROCEDURE load_managers;

   PROCEDURE load_programs;

   PROCEDURE load_program_manager;
END pkg_etl_dim_programs_dw;
/