
DROP TABLE u_dw_cls_star.cls_dim_dishes_scd CASCADE CONSTRAINT;

/*==============================================================*/
/* Table: DIM_DISHES_SCD                                        */
/*==============================================================*/

CREATE TABLE u_dw_cls_star.cls_dim_dishes_scd
(
   dish_sur_id    NUMBER ( 15 ) NOT NULL
 , dish_id        NUMBER ( 15 ) NOT NULL
 , dish_code      VARCHAR2 ( 15 ) NOT NULL
 , dish_name      VARCHAR2 ( 400 ) NOT NULL
 , dish_desc      VARCHAR2 ( 2000 ) NOT NULL
 , dish_weight    NUMBER ( 10, 5 ) NOT NULL
 , dish_type_id   NUMBER ( 3 ) NOT NULL
 , dish_type_name VARCHAR2 ( 50 ) NOT NULL
 , dish_type_desc VARCHAR2 ( 500 ) NOT NULL
 , dish_cuisine_id NUMBER ( 3 ) NOT NULL
 , dish_cuisine_name VARCHAR2 ( 50 ) NOT NULL
 , dish_cuisine_desc VARCHAR2 ( 500 ) NOT NULL
 , start_unit_price_dol NUMBER ( 15, 5 ) NOT NULL
 , from_dt        DATE 
 , to_dt          DATE 
 , is_valid       VARCHAR2 ( 25 ) NOT NULL
 , insert_dt      DATE NOT NULL
 , CONSTRAINT pk_dim_dishes_scd PRIMARY KEY ( dish_sur_id )
);