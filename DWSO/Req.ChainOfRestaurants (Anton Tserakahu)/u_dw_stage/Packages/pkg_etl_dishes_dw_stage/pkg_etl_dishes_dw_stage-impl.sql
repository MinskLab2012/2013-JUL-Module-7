CREATE OR REPLACE PACKAGE BODY pkg_etl_dishes_dw_stage
AS

   -- Load All Dish Types
   PROCEDURE load_t_dish_types
   AS
   BEGIN
      DECLARE
	   CURSOR cur_dish_type
	   IS
	      SELECT t_stage.dish_type_id AS dish_type_id_stage
	           , t_source.dish_type_name AS dish_type_name_source
	           , t_stage.dish_type_name AS dish_type_name_stage
	           , 'Type of dish - ' || t_source.dish_type_name AS dish_type_desc_source
	           , t_stage.dish_type_desc AS dish_type_desc_stage
	        FROM    (SELECT DISTINCT dish_type_name
	                   FROM u_dw_cls_stage.cls_dishes) t_source
	             LEFT JOIN
	                t_dish_types t_stage
	             ON t_source.dish_type_name = t_stage.dish_type_name;
	
	   TYPE t_dish_type IS TABLE OF cur_dish_type%ROWTYPE;
	
	   record_dish_type t_dish_type;
	BEGIN
	   OPEN cur_dish_type;
	
	   FETCH cur_dish_type
	   BULK COLLECT INTO record_dish_type;
	
	   CLOSE cur_dish_type;
	
	   FOR i IN record_dish_type.FIRST .. record_dish_type.LAST LOOP
	      IF ( record_dish_type ( i ).dish_type_id_stage IS NULL ) THEN
	         INSERT INTO t_dish_types ( dish_type_id
	                                  , dish_type_name
	                                  , dish_type_desc
	                                  , insert_dt
	                                  , update_dt )
	              VALUES ( seq_t_dish_types.NEXTVAL
	                     , record_dish_type ( i ).dish_type_name_source
	                     , record_dish_type ( i ).dish_type_desc_source
	                     , SYSDATE
	                     , NULL );
	
	         COMMIT;
	      ELSIF ( record_dish_type ( i ).dish_type_desc_source <> record_dish_type ( i ).dish_type_desc_stage ) THEN
	         UPDATE t_dish_types
	            SET dish_type_desc = record_dish_type ( i ).dish_type_desc_source
	              , update_dt    = SYSDATE
	          WHERE t_dish_types.dish_type_id = record_dish_type ( i ).dish_type_id_stage;
	
	         COMMIT;
	      END IF;
	   END LOOP;
	END;



   END load_t_dish_types;


   -- Load All Dish Cuisines
   PROCEDURE load_t_dish_cuisines
   AS
   BEGIN
      
	DECLARE
	   CURSOR cur_dish_cuisine
	   IS
	      SELECT t_stage.dish_cuisine_id AS dish_cuisine_id_stage
	           , t_source.dish_cuisine_name AS dish_cuisine_name_source
	           , t_stage.dish_cuisine_name AS dish_cuisine_name_stage
	           , 'Cuisine of dish - ' || t_source.dish_cuisine_name AS dish_cuisine_desc_source
	           , t_stage.dish_cuisine_desc AS dish_cuisine_desc_stage
	        FROM    (SELECT DISTINCT dish_cuisine_name
	                   FROM u_dw_cls_stage.cls_dishes) t_source
	             LEFT JOIN
	                T_DISH_CUISINES t_stage
	             ON t_source.dish_cuisine_name = t_stage.dish_cuisine_name;
	
	   TYPE t_dish_cuisine IS TABLE OF cur_dish_cuisine%ROWTYPE;
	
	   record_dish_cuisine t_dish_cuisine;
	   
	BEGIN
	   OPEN cur_dish_cuisine;
	
	   FETCH cur_dish_cuisine
	   BULK COLLECT INTO record_dish_cuisine;
	
	   CLOSE cur_dish_cuisine;
	
	   FOR i IN record_dish_cuisine.FIRST .. record_dish_cuisine.LAST LOOP
	      IF ( record_dish_cuisine ( i ).dish_cuisine_id_stage IS NULL ) THEN
	         INSERT INTO T_DISH_CUISINES ( dish_cuisine_id
	                                  , dish_cuisine_name
	                                  , dish_cuisine_desc
	                                  , insert_dt
	                                  , update_dt )
	              VALUES ( seq_t_dish_cuisines.NEXTVAL
	                     , record_dish_cuisine ( i ).dish_cuisine_name_source
	                     , record_dish_cuisine ( i ).dish_cuisine_desc_source
	                     , SYSDATE
	                     , NULL );
	
	         COMMIT;
	      ELSIF ( record_dish_cuisine ( i ).dish_cuisine_desc_source <> record_dish_cuisine ( i ).dish_cuisine_desc_stage ) THEN
	         UPDATE T_DISH_CUISINES
	            SET dish_cuisine_desc = record_dish_cuisine ( i ).dish_cuisine_desc_source
	              , update_dt    = SYSDATE
	          WHERE T_DISH_CUISINES.dish_cuisine_id = record_dish_cuisine ( i ).dish_cuisine_id_stage;
	
	         COMMIT;
	      END IF;
	   END LOOP;
	END;

   END load_t_dish_cuisines;


   -- Load All Dishes 
   PROCEDURE load_t_dishes
   AS
   BEGIN
      
	DECLARE
	   CURSOR cur_dishes
	   IS
	      SELECT t_stage.dish_id AS dish_id_stage
	           , t_source.dish_code AS dish_code_source
	           , t_stage.dish_code AS dish_code_stage
	           , t_source.dish_name AS dish_name_source
	           , t_stage.dish_name AS dish_name_stage
	           , t_source.dish_desc AS dish_desc_source
	           , t_stage.dish_desc AS dish_desc_stage
	           , t_source.dish_weight AS dish_weight_source
	           , t_stage.dish_weight AS dish_weight_stage
	           , t_source.dish_type_id AS dish_type_id_source
	           , t_stage.dish_type_id AS dish_type_id_stage
	           , t_source.dish_cuisine_id AS dish_cuisine_id_source
	           , t_stage.dish_cuisine_id AS dish_cuisine_id_stage
	           , t_source.start_unit_price_dol AS start_unit_price_dol_source
	           , t_stage.start_unit_price_dol AS start_unit_price_dol_stage
	        FROM    (SELECT DISTINCT dish_code
	                               , dish_name
	                               , dish_desc
	                               , dish_weight
	                               , t_dish_cuisines.dish_cuisine_id
	                               , t_dish_types.dish_type_id
	                               , dish_start_price_dol AS start_unit_price_dol
	                   FROM u_dw_cls_stage.cls_dishes dishes
	                        LEFT JOIN t_dish_cuisines
	                           ON dishes.dish_cuisine_name = t_dish_cuisines.dish_cuisine_name
	                        LEFT JOIN t_dish_types
	                           ON dishes.dish_type_name = t_dish_types.dish_type_name) t_source
	             LEFT JOIN
	                t_dishes t_stage
	             ON t_source.dish_code = t_stage.dish_code;
	
	   TYPE type_dishes IS TABLE OF cur_dishes%ROWTYPE;
	
	   record_dishes  type_dishes;
	BEGIN
	   OPEN cur_dishes;
	
	   FETCH cur_dishes
	   BULK COLLECT INTO record_dishes;
	
	   CLOSE cur_dishes;
	
	   FOR i IN record_dishes.FIRST .. record_dishes.LAST LOOP
	      IF ( record_dishes ( i ).dish_id_stage IS NULL ) THEN
	         INSERT INTO t_dishes ( dish_id
	                              , dish_code
	                              , dish_name
	                              , dish_desc
	                              , dish_weight
	                              , dish_type_id
	                              , dish_cuisine_id
	                              , start_unit_price_dol )
	              VALUES ( seq_t_dishes.NEXTVAL
	                     , record_dishes ( i ).dish_code_source
	                     , record_dishes ( i ).dish_name_source
	                     , record_dishes ( i ).dish_desc_source
	                     , record_dishes ( i ).dish_weight_source
	                     , record_dishes ( i ).dish_type_id_source
	                     , record_dishes ( i ).dish_cuisine_id_source
	                     , record_dishes ( i ).start_unit_price_dol_source );
	
	         COMMIT;
	      ELSIF ( record_dishes ( i ).dish_name_source <> record_dishes ( i ).dish_name_stage
	          OR  record_dishes ( i ).dish_desc_source <> record_dishes ( i ).dish_desc_stage
	          OR  record_dishes ( i ).dish_weight_source <> record_dishes ( i ).dish_weight_stage
	          OR  record_dishes ( i ).dish_type_id_source <> record_dishes ( i ).dish_type_id_stage
	          OR  record_dishes ( i ).dish_cuisine_id_source <> record_dishes ( i ).dish_cuisine_id_stage
	          OR  record_dishes ( i ).start_unit_price_dol_source <> record_dishes ( i ).start_unit_price_dol_stage ) THEN
	         UPDATE t_dishes
	            SET dish_name    = record_dishes ( i ).dish_name_source
	              , dish_desc    = record_dishes ( i ).dish_desc_source
	              , dish_weight  = record_dishes ( i ).dish_weight_source
	              , dish_type_id = record_dishes ( i ).dish_type_id_source
	              , dish_cuisine_id = record_dishes ( i ).dish_cuisine_id_source
	              , start_unit_price_dol = record_dishes ( i ).start_unit_price_dol_source
	          WHERE t_dishes.dish_id = record_dishes ( i ).dish_id_stage;
	
	         COMMIT;
	      END IF;
	   END LOOP;
	END;

   END load_t_dishes;

   -- Load Actions
   PROCEDURE load_actions
   AS
   BEGIN


	MERGE INTO u_dw_stage.t_dish_actions trg
         USING (SELECT dish_stage.dish_id
     , act_data.price_new AS price_old
     , dish_cls.dish_start_price_dol AS price_new
  FROM u_dw_cls_stage.cls_dishes dish_cls
       LEFT JOIN t_dishes dish_stage
          ON dish_stage.dish_code = dish_cls.dish_code
       LEFT JOIN (SELECT t_dish_actions.action_id
                       , t.dish_id
                       , t_dish_actions.price_old
                       , t_dish_actions.price_new
                       , t.action_dt
                    FROM    (  SELECT dish_id
                                    , MAX ( action_dt ) AS action_dt
                                 FROM t_dish_actions
                             GROUP BY dish_id) t
                         LEFT JOIN
                            t_dish_actions
                         ON t.dish_id = t_dish_actions.dish_id
                        AND t.action_dt = t_dish_actions.action_dt) act_data
          ON dish_stage.dish_id = act_data.dish_id) cls
            ON ( trg.price_new = cls.price_new
            AND trg.dish_id = cls.dish_id )
    WHEN NOT MATCHED THEN
       INSERT            ( action_id
                         , dish_id
                         , price_old
                         , price_new
                         , action_dt )
           VALUES ( seq_t_dish_actions.NEXTVAL
                  , cls.dish_id
                  , cls.price_old
                  , cls.price_new
                  , SYSDATE );
    
           --Commit Resulst
    COMMIT;


   END load_actions;

END pkg_etl_dishes_dw_stage;
/