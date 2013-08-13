CREATE OR REPLACE PACKAGE pkg_load_fct_transactions_tmp
--
AS
   PROCEDURE load_fct_transactions_tmp ( tr_year IN NUMBER );
END;