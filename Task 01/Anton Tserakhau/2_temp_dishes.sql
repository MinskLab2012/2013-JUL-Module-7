/* Formatted on 30.07.2013 16:06:16 (QP5 v5.139.911.3011) */
DROP TABLE u_dw_ext_references.temp_dishes PURGE;

CREATE TABLE u_dw_ext_references.temp_dishes
(
   dish_code      VARCHAR2 ( 20 CHAR )
 , dish_name      VARCHAR2 ( 400 CHAR )
 , dish_region    VARCHAR2 ( 60 CHAR )
 , dish_type      VARCHAR2 ( 100 CHAR )
 , dish_desc      VARCHAR2 ( 2000 CHAR )
)
TABLESPACE ts_references_ext_temp_data_01;


INSERT INTO u_dw_ext_references.temp_dishes ( dish_code
                                            , dish_name
                                            , dish_region
                                            , dish_type
                                            , dish_desc )
   SELECT dish_code
        , dish_name
        , dish_region
        , dish_type
        , dish_desc
     FROM u_dw_ext_references.t_ext_dishes;

COMMIT;