CREATE OR REPLACE PACKAGE pkg_etl_dim_operations_dw
--
AS
   PROCEDURE load_tmp_operations;

   PROCEDURE load_tmp_methods;
END;