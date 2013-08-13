
DROP TABLE u_dw_cls_stage.cls_operations;

--==============================================================
-- Table: cls_operations
--==============================================================

CREATE TABLE u_dw_cls_stage.cls_operations
(
   event_dt       DATE
 , transaction_code NUMBER ( 10 )
 , restaurant_code NUMBER ( 10 )
 , dish_code      VARCHAR2 ( 15 )
 , unit_amount    NUMBER ( 20, 5 )
);

COMMENT ON TABLE u_dw_cls_stage.cls_operations IS
'Cleansing table for loading - Operations';