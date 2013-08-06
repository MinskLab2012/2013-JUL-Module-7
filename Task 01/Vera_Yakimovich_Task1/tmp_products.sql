/* Formatted on 02.08.2013 21:11:10 (QP5 v5.139.911.3011) */
DROP TABLE temp_products;

--products

CREATE TABLE temp_products
(
   product_code   VARCHAR2 ( 15 )
 , product_name   VARCHAR2 ( 50 )
 , sort_code      VARCHAR2 ( 15 )
 , sort_name      VARCHAR2 ( 50 )
 , measure_code   VARCHAR2 ( 15 )
 , measure        VARCHAR2 ( 50 )
 , quantity       NUMBER ( 10, 2 )
 , price          NUMBER ( 15, 2 )
)
TABLESPACE ts_references_ext_data_01;

INSERT INTO temp_products
   SELECT UPPER (   SUBSTR ( brand_name
                           , 1
                           , 3 )
                 || SUBSTR ( sort_name
                           , -3
                           , 3 )
                 || '_'
                 || quantity * 2 )
             c
        , brand_name
        , UPPER ( SUBSTR ( sort_name
                         , 1
                         , 3 )
                 || SUBSTR ( sort_name
                           , -3
                           , 3 ) )
        , sort_name
        , UPPER ( SUBSTR ( ( (   SUBSTR ( measure
                                        , 1
                                        , 3 )
                              || SUBSTR ( measure
                                        , -1
                                        , 1 )
                              || '_'
                              || quantity * 2 ) )
                         , 1
                         , 15 ) )
        , measure
        , quantity
        , price
     FROM (SELECT DISTINCT brand_name
                         , sort_name
                         , measure
                         , quantity
                         , ROUND ( dbms_random.VALUE ( 10
                                                     , 400 )
                                 , 2 )
                              AS price
             FROM (SELECT DISTINCT brand_name
                                 , sort_name
                                 , measure
                                 , quantity
                     FROM (SELECT --+NO_MERGE
                                 brand_name
                                , ROUND ( dbms_random.VALUE ( 1
                                                            , 10 ) )
                                     AS sort_id
                                , ROUND ( dbms_random.VALUE ( 1
                                                            , 8 ) )
                                     AS meas_id
                             FROM ext_prod_brand
                                , (    SELECT ROWNUM
                                         FROM DUAL
                                   CONNECT BY ROWNUM <= 100)) br
                          INNER JOIN (SELECT ROWNUM AS sort_id
                                           , sort_name
                                        FROM ext_prod_sorts) sr
                             ON br.sort_id = sr.sort_id
                          INNER JOIN (SELECT ROWNUM AS m_id
                                           , measure
                                           , quantity
                                        FROM (SELECT 'liters' AS measure
                                                   , 0.3 AS quantity
                                                FROM DUAL
                                              UNION
                                              SELECT 'liters' AS measure
                                                   , 0.5 AS quantity
                                                FROM DUAL
                                              UNION
                                              SELECT 'liters' AS measure
                                                   , 1 AS quantity
                                                FROM DUAL
                                              UNION
                                              SELECT 'liters' AS measure
                                                   , 1.5 AS quantity
                                                FROM DUAL
                                              UNION
                                              SELECT 'liters' AS measure
                                                   , 2 AS quantity
                                                FROM DUAL
                                              UNION
                                              SELECT 'liters' AS measure
                                                   , 5 AS quantity
                                                FROM DUAL
                                              UNION
                                              SELECT 'liters' AS measure
                                                   , 10 AS quantity
                                                FROM DUAL
                                              UNION
                                              SELECT 'liters' AS measure
                                                   , 20 AS quantity
                                                FROM DUAL)) meas_t
                             ON meas_t.m_id = br.meas_id));

COMMIT;