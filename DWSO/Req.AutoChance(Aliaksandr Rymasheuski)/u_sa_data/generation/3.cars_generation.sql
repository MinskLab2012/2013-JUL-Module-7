CREATE TABLE tmp_cars
AS
   SELECT DISTINCT
          cr.car_id
        , cr.cat_stand_num
        , cr.mark_id as brand_id
        , cr.brand
        , cr.model_id
        , cr.model
        , cr.year_of_production
        , DECODE ( cr.color
                 , 1, 'Blue'
                 , 2, 'Black'
                 , 3, 'Bone'
                 , 4, 'Bronze'
                 , 5, 'Brown'
                 , 6, 'Cherry'
                 , 7, 'Cyber Yellow'
                 , 8, 'Dark Red'
                 , 9, 'Forest Green'
                 , 10, 'Deep Lemon' )
             AS color
        , cr.date_of_purchase
        , cnt.cntr_desc AS country
        , cr.cost
        , DECODE ( cr.status,  1, 'instock',  2, 'sold' ) AS status
     FROM (SELECT --+NO_MERGE
                 ROWNUM car_id
                , ROUND ( dbms_random.VALUE ( 1000000000
                                            , 9999999999 ) )
                     AS cat_stand_num
                     , mark_id
                , b.mark AS brand
                ,m.id as model_id
                , m.model
                , ROUND ( dbms_random.VALUE ( 1965
                                            , 2012 ) )
                     AS year_of_production
                , ROUND ( dbms_random.VALUE ( 1
                                            , 10 ) )
                     AS color
                , TO_DATE ( TRUNC ( dbms_random.VALUE ( 2452000
                                                      , 2456293 ) )
                          , 'j' )
                     AS date_of_purchase
                , ROUND ( dbms_random.VALUE ( 1000
                                            , 99990 )
                        , -1 )
                     AS cost
                , ROUND ( dbms_random.VALUE ( 1
                                            , 2 ) )
                     AS status
                , ROUND ( dbms_random.VALUE ( 1
                                            , 241 ) )
                     AS cntr_num
             FROM tmp_brands b
                , tmp_models m
                , (    SELECT ROWNUM
                         FROM DUAL
                   CONNECT BY ROWNUM <= 25)
            WHERE b.id = m.mark_id) cr
        , (SELECT ROWNUM AS rn
                , i.cntr_desc
             FROM (  SELECT cntr.region_desc cntr_desc
                       FROM u_dw_references.cu_countries cntr
                   ORDER BY region_desc) i) cnt
    WHERE cr.cntr_num = cnt.rn;
    commit;
    
 
