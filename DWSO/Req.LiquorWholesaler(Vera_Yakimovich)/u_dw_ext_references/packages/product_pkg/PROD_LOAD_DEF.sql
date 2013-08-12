/* Formatted on 12.08.2013 6:24:41 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE prod_load
AS
   PROCEDURE ins_upd;

   PROCEDURE prod_categ_load;

   PROCEDURE measure_load;
END prod_load;
/