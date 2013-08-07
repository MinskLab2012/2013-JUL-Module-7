
CREATE OR REPLACE PACKAGE BODY pkg_etl_operations_dw_stage
AS

   -- Load All Operations
   PROCEDURE load_t_operations
   AS
   BEGIN
      
	BEGIN
	   MERGE INTO t_operations t_source
	        USING (SELECT oper.event_dt
	                    , oper.transaction_code
	                    , t_restaurants.restaurant_id
	                    , t_dishes.dish_id
	                    , oper.unit_price_dol
	                    , oper.unit_amount
	                    , oper.total_price_dol
	                 FROM u_dw_ext_references.cls_operations oper
	                      LEFT JOIN t_dishes
	                         ON oper.dish_code = t_dishes.dish_code
	                      LEFT JOIN t_restaurants
	                         ON t_restaurants.restaurant_code = oper.restaurant_code) t_stage
	           ON ( t_source.transaction_id = t_stage.transaction_code )
	   WHEN NOT MATCHED THEN
	      INSERT            ( operation_id
	                        , transaction_id
	                        , event_dt
	                        , restaurant_id
	                        , dish_id
	                        , unit_price_dol
	                        , unit_amount
	                        , total_price_dol
	                        , insert_dt
	                        , update_dt )
	          VALUES ( seq_t_operations.NEXTVAL
	                 , t_stage.transaction_code
	                 , t_stage.event_dt
	                 , t_stage.restaurant_id
	                 , t_stage.dish_id
	                 , t_stage.unit_price_dol
	                 , t_stage.unit_amount
	                 , t_stage.total_price_dol
	                 , SYSDATE
	                 , NULL )
	   WHEN MATCHED THEN
	      UPDATE SET event_dt     = t_stage.event_dt
	               , restaurant_id = t_stage.restaurant_id
	               , dish_id      = t_stage.dish_id
	               , unit_price_dol = t_stage.unit_price_dol
	               , unit_amount  = t_stage.unit_amount
	               , total_price_dol = t_stage.total_price_dol
	               , update_dt    = SYSDATE
	              WHERE t_stage.event_dt <> t_source.event_dt
	                 OR  t_stage.restaurant_id <> t_source.restaurant_id
	                 OR  t_stage.dish_id <> t_source.dish_id
	                 OR  t_stage.unit_price_dol <> t_source.unit_price_dol
	                 OR  t_stage.unit_amount <> t_source.unit_amount
	                 OR  t_stage.total_price_dol <> t_source.total_price_dol;
	
	
	   COMMIT;
	END;

   END load_t_operations;


END pkg_etl_operations_dw_stage;
/