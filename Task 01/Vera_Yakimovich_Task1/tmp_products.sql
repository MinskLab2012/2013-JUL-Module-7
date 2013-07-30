DROP TABLE temp_products;

--products

CREATE TABLE temp_products
(
   prod_id        NUMBER ( 20 )
 , product_name   VARCHAR2 ( 50 )
 , sort_name      VARCHAR2 ( 50 )
 , measure        VARCHAR2 ( 50 )
 , quantity       NUMBER ( 10, 2 )
 , price          NUMBER ( 15, 2 )
)
TABLESPACE ts_references_ext_data_01;

INSERT INTO temp_products
   SELECT ROWNUM AS prod_id
        , brand_name
        , sort_name
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