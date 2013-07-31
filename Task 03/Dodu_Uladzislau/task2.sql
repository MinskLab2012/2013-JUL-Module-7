/* Formatted on 7/31/2013 6:35:31 PM (QP5 v5.139.911.3011) */
CREATE TABLE prod_links
AS
   SELECT prod_id
        , prod_category_id
     FROM ext_products;


    SELECT LPAD ( ' '
                , LEVEL * 4 )
           || prod_name
              prod_heirarchy
         , DECODE ( CONNECT_BY_ISLEAF
                  , 1, '--'
                  , (    SELECT COUNT ( prod_id )
                           FROM prod_links
                     START WITH prod_category_id = co.prod_id
                     CONNECT BY prod_category_id = PRIOR prod_id ) )
              count_products_titles
         , prod_desc product_description
         , income_coef
      FROM (SELECT *
              FROM (SELECT fir.prod_id
                         , fir.prod_category_id
                         , sec.prod_name
                         , sec.prod_desc
                         , sec.income_coef
                      FROM    (SELECT *
                                 FROM prod_links
                               UNION
                               SELECT prod_category_id
                                    , NULL
                                 FROM prod_links) fir
                           JOIN
                              (SELECT prod_id
                                    , prod_name
                                    , prod_desc
                                    , income_coef
                                 FROM ext_products
                               UNION
                               SELECT prod_category_id
                                    , prod_category
                                    , NULL
                                    , NULL
                                 FROM ext_prod_categories) sec
                           ON fir.prod_id = sec.prod_id)) co
     WHERE LEVEL = 2
        OR  prod_id > 100
START WITH prod_id = prod_id
CONNECT BY prod_category_id = PRIOR prod_id;