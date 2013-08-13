/* Formatted on 8/11/2013 9:11:11 PM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_dim_products
AS
   PROCEDURE load_dim_products
   AS
      -----current procedure tracks changes for only one field. It is my own business request - CHECK CHANGES OF INCOME COEFFICIENT-------------------------------
      CURSOR cur_c1
      IS
         SELECT t.prod_id
              , t.prod_code
              , lc.prod_name
              , lc.prod_desc
              , t.income_coef
              , cat.prod_category_id
              , lca.prod_category_name
              , lca.prod_category_desc
              , action_date
           FROM st.t_products t
                JOIN st.lc_products lc
                   ON t.prod_id = lc.prod_id
                JOIN st.t_categories cat
                   ON t.prod_category_id = cat.prod_category_id
                JOIN st.lc_categories lca
                   ON cat.prod_category_id = lca.prod_category_id
                JOIN (SELECT *
                        FROM st.prod_actions
                       WHERE ( prod_id, action_date ) IN (  SELECT prod_id
                                                                 , MAX ( action_date )
                                                              FROM st.prod_actions
                                                          GROUP BY prod_id)) act
                   ON t.prod_id = act.prod_id
         MINUS
         SELECT prod_id
              , prod_code
              , prod_name
              , prod_desc
              , income_coef
              , prod_category_id
              , prod_category_name
              , prod_category_desc
              , actual_from
           FROM dw_star.dim_products_scd;

      TYPE prod IS TABLE OF cur_c1%ROWTYPE;

      temp           prod;
   BEGIN
      OPEN cur_c1;

      FETCH cur_c1
      BULK COLLECT INTO temp;
      FORALL i IN INDICES OF temp
         INSERT into  dw_star.dim_products_scd( prod_id
                                              , prod_code
                                              , prod_name
                                              , prod_desc
                                              , income_coef
                                              , prod_category_id
                                              , prod_category_name
                                              , prod_category_desc
                                              , actual_from )
              VALUES ( temp ( i ).prod_id
                     , temp ( i ).prod_code
                     , temp ( i ).prod_name
                     , temp ( i ).prod_desc
                     , temp ( i ).income_coef
                     , temp ( i ).prod_category_id
                     , temp ( i ).prod_category_name
                     , temp ( i ).prod_category_desc
                     , temp ( i ).action_date );

      COMMIT;

      FORALL i IN INDICES OF temp
         UPDATE dw_star.dim_products_scd
            SET actual_to     =
                   ( SELECT LEAD ( actual_from
                                 , '31-DEC-2999' )
                            OVER (PARTITION BY prod_id ORDER BY actual_from)
                       FROM dw_star.dim_products_scd
                      WHERE prod_id = temp ( i ).prod_id )
          WHERE prod_id = temp ( i ).prod_id;

      COMMIT; 
      CLOSE cur_c1;
   END load_dim_products;
   
   procedure update_dim_products
   as
 cursor cur_c1
 is
 SELECT t.prod_id
              , t.prod_code
              , lc.prod_name
              , lc.prod_desc
              , t.income_coef
              , cat.prod_category_id
              , lca.prod_category_name
              , lca.prod_category_desc
           FROM st.t_products t
                JOIN st.lc_products lc
                   ON t.prod_id = lc.prod_id
                JOIN st.t_categories cat
                   ON t.prod_category_id = cat.prod_category_id
                JOIN st.lc_categories lca
                   ON cat.prod_category_id = lca.prod_category_id;
                   type prod_tab is table of cur_c1%rowtype;
                   temp prod_tab;
                  begin
                  open cur_c1;
                  fetch cur_c1 bulk collect into temp;
                  for i in temp.first..temp.last
                  loop
                  update dw_star.dim_products_scd
                  set prod_name = temp(i).prod_name,
                  prod_desc = temp(i).prod_desc,
                  prod_category_id = temp(i).prod_category_id,
                  prod_category_name = temp(i).prod_category_name,
                  prod_category_desc = temp(i).prod_category_desc
                  where prod_id = temp(i).prod_id and
                  (prod_name !=temp(i).prod_name or
                  prod_desc != temp(i).prod_desc or
                  prod_category_id != temp(i).prod_category_id or
                  prod_category_name != temp(i).prod_category_name or
                  prod_category_desc !=temp(i).prod_category_desc);
                  commit;
                  end loop;
                  end update_dim_products;                   
   end pkg_load_dim_products;