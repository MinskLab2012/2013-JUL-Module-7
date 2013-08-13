
DROP TABLE u_dw_cls_stage.cls_dishes;

--==============================================================
-- Table: cls_dishes
--==============================================================

CREATE TABLE u_dw_cls_stage.cls_dishes
(
   dish_code      VARCHAR2 ( 20 )
 , dish_name      VARCHAR2 ( 400 )
 , dish_desc      VARCHAR2 ( 2000 )
 , dish_weight    NUMBER ( 10, 5 )
 , dish_type_name VARCHAR2 ( 50 )
 , dish_cuisine_name VARCHAR2 ( 50 )
 , dish_start_price_dol NUMBER ( 20, 5 )
);

COMMENT ON TABLE u_dw_cls_stage.cls_dishes IS
'Cleansing table for loading - Dishes';