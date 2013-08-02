/* Formatted on 01.08.2013 14:46:33 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_fin_groups_dw
AS
   -- Load Data From Sources table to DataBase - Finance Groups
   PROCEDURE load_finance_groups
   AS
      CURSOR c_fg
      IS
         SELECT DISTINCT grp
           FROM sa_finance.finance_countries where grp not in (select fin_group_desc from dw.t_finance_groups);
   BEGIN
      --Insert Source data
      FOR i IN c_fg LOOP
         INSERT INTO dw.t_finance_groups ( fin_group_id
                                         , fin_group_desc
                                         , insert_dt
                                         , update_dt )
              VALUES ( fg_seq.NEXTVAL
                     , i.grp
                     , SYSDATE
                     , SYSDATE );

         EXIT WHEN c_fg%NOTFOUND;
      END LOOP;
      --Commit Result
      COMMIT;
   END load_finance_groups;
END pkg_etl_fin_groups_dw;
/
