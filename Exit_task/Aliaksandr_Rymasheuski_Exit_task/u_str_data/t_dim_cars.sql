/* Formatted on 10.08.2013 14:02:32 (QP5 v5.139.911.3011) */
--DROP TABLE DIM_CARS;

CREATE TABLE dim_cars
(
   car_id         NUMBER ( 20 ) PRIMARY KEY
 , car_stand_num  VARCHAR2 ( 50 )
 , brand          VARCHAR2 ( 50 )
 , model          VARCHAR2 ( 50 )
 , color          VARCHAR2 ( 50 )
 , prod_year      NUMBER ( 10 )
 , purch_time     DATE
 , cost           NUMBER ( 20 )
 , status         VARCHAR2 ( 10 )
 , insert_dt      DATE
 , update_dt      DATE
);

INSERT INTO dim_cars
     VALUES ( -99
            , 'n.a.'
            , 'not available'
            , 'not available'
            , 'not available'
            , -99
            , NULL
            , -99
            , 'n.a.'
            , NULL
            , NULL );

COMMIT;
GRANT DELETE,INSERT,UPDATE,SELECT ON dim_cars TO u_sal_cl;