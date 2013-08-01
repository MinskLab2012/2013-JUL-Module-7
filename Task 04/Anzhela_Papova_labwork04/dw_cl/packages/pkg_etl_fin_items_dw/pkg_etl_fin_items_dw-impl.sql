/* Formatted on 01.08.2013 16:48:43 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_fin_items_dw
AS
   -- Load Data From Sources table to DataBase - Finance Items
   PROCEDURE load_finance_items
   AS
      TYPE tmp_id IS TABLE OF NUMBER;

      TYPE tmp_name IS TABLE OF VARCHAR2 ( 100 );

      blk_id         tmp_id;
      blk_name       tmp_name;

      CURSOR c_fi
      IS
         SELECT DISTINCT fin_item_id
                       , fin_item_name
           FROM sa_finance.finance_items
          WHERE fin_item_name NOT IN (SELECT fin_item_desc
                                        FROM dw.t_finance_items);
   BEGIN
      --Insert Source data
      OPEN c_fi;

      LOOP
         FETCH c_fi
         BULK COLLECT INTO blk_id, blk_name
         LIMIT 1000;

         FORALL i IN 1 .. blk_id.COUNT
            INSERT INTO dw.t_finance_items ( fin_item_id
                                           , fin_item_code
                                           , fin_item_desc
                                           , insert_dt
                                           , update_dt )
                 VALUES ( fi_seq.NEXTVAL
                        , blk_id ( i )
                        , blk_name ( i )
                        , SYSDATE
                        , SYSDATE );

         EXIT WHEN c_fi%NOTFOUND;
      END LOOP;

      CLOSE c_fi;

      --Commit Result
      COMMIT;
   END load_finance_items;
END pkg_etl_fin_items_dw;
/

