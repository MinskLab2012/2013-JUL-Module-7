CREATE OR REPLACE PACKAGE BODY pkg_etl_dishes_dw_stage
AS

   -- Load All Dish Types
   PROCEDURE load_t_dish_types
   AS
   BEGIN
      
	DECLARE
	   TYPE var_cur IS REF CURSOR;
	
	
	   TYPE t_rec_dish_type IS RECORD
	   (
	      dish_type_id_stage NUMBER ( 3 )
	    , dish_type_name_source VARCHAR2 ( 50 )
	    , dish_type_name_stage VARCHAR2 ( 50 )
	    , dish_type_desc_source VARCHAR2 ( 500 )
	    , dish_type_desc_stage VARCHAR2 ( 500 )
	   );
	
	   TYPE t_dish_type IS TABLE OF t_rec_dish_type;
	
	   cur_dish_type  var_cur;
	   record_dish_type t_dish_type;
	   curid          NUMBER ( 25 );
	BEGIN
	   OPEN cur_dish_type FOR
	      SELECT t_stage.dish_type_id AS dish_type_id_stage
	           , t_source.dish_type_name AS dish_type_name_source
	           , t_stage.dish_type_name AS dish_type_name_stage
	           , 'Type of dish - ' || t_source.dish_type_name AS dish_type_desc_source
	           , t_stage.dish_type_desc AS dish_type_desc_stage
	        FROM    (SELECT DISTINCT dish_type_name
	                   FROM u_dw_ext_references.cls_dishes) t_source
	             LEFT JOIN
	                t_dish_types t_stage
	             ON t_source.dish_type_name = t_stage.dish_type_name;
	
	
	
	   FETCH cur_dish_type
	   BULK COLLECT INTO record_dish_type;
	
	   curid       := dbms_sql.to_cursor_number ( cur_dish_type );
	   dbms_sql.close_cursor ( curid );
	
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
	   TYPE var_cur IS REF CURSOR;
	
	
	   TYPE t_rec_dish_cuisine IS RECORD
	   (
	      dish_cuisine_id_stage NUMBER ( 3 )
	    , dish_cuisine_name_source VARCHAR2 ( 50 )
	    , dish_cuisine_name_stage VARCHAR2 ( 50 )
	    , dish_cuisine_desc_source VARCHAR2 ( 500 )
	    , dish_cuisine_desc_stage VARCHAR2 ( 500 )
	   );
	
	   TYPE t_dish_cuisine IS TABLE OF t_rec_dish_cuisine;
	
	   cur_dish_cuisine var_cur;
	   record_dish_cuisine t_dish_cuisine;
	   curid          NUMBER ( 25 );
	BEGIN
	   OPEN cur_dish_cuisine FOR
	      SELECT t_stage.dish_cuisine_id AS dish_cuisine_id_stage
	           , t_source.dish_cuisine_name AS dish_cuisine_name_source
	           , t_stage.dish_cuisine_name AS dish_cuisine_name_stage
	           , 'Cuisine of dish - ' || t_source.dish_cuisine_name AS dish_cuisine_desc_source
	           , t_stage.dish_cuisine_desc AS dish_cuisine_desc_stage
	        FROM    (SELECT DISTINCT dish_cuisine_name
	                   FROM u_dw_ext_references.cls_dishes) t_source
	             LEFT JOIN
	                t_dish_cuisines t_stage
	             ON t_source.dish_cuisine_name = t_stage.dish_cuisine_name;
	
	
	
	   FETCH cur_dish_cuisine
	   BULK COLLECT INTO record_dish_cuisine;
	
	   curid       := dbms_sql.to_cursor_number ( cur_dish_cuisine );
	   dbms_sql.close_cursor ( curid );
	
	   FOR i IN record_dish_cuisine.FIRST .. record_dish_cuisine.LAST LOOP
	      IF ( record_dish_cuisine ( i ).dish_cuisine_id_stage IS NULL ) THEN
	         INSERT INTO t_dish_cuisines ( dish_cuisine_id
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
	         UPDATE t_dish_cuisines
	            SET dish_cuisine_desc = record_dish_cuisine ( i ).dish_cuisine_desc_source
	              , update_dt    = SYSDATE
	          WHERE t_dish_cuisines.dish_cuisine_id = record_dish_cuisine ( i ).dish_cuisine_id_stage;
	
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
	   TYPE var_cur IS REF CURSOR;
	
	
	   TYPE t_rec_dish IS RECORD
	   (
	      dish_id_stage  NUMBER ( 15 )
	    , dish_code_source VARCHAR2 ( 15 )
	    , dish_code_stage VARCHAR2 ( 15 )
	    , dish_name_source VARCHAR2 ( 400 )
	    , dish_name_stage VARCHAR2 ( 400 )
	    , dish_desc_source VARCHAR2 ( 2000 )
	    , dish_desc_stage VARCHAR2 ( 2000 )
	    , dish_weight_source NUMBER ( 10, 5 )
	    , dish_weight_stage NUMBER ( 10, 5 )
	    , dish_type_id_source NUMBER ( 5 )
	    , dish_type_id_stage NUMBER ( 5 )
	    , dish_cuisine_id_source NUMBER ( 5 )
	    , dish_cuisine_id_stage NUMBER ( 5 )
	    , start_unit_price_dol_source NUMBER ( 10, 5 )
	    , start_unit_price_dol_stage NUMBER ( 10, 5 )
	   );
	
	   TYPE t_dish_type IS TABLE OF t_rec_dish;
	
	   cur_dishes     var_cur;
	   record_dishes  t_dish_type;
	   curid          NUMBER ( 25 );
	BEGIN
	   OPEN cur_dishes FOR
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
	                   FROM u_dw_ext_references.cls_dishes dishes
	                        LEFT JOIN t_dish_cuisines
	                           ON dishes.dish_cuisine_name = t_dish_cuisines.dish_cuisine_name
	                        LEFT JOIN t_dish_types
	                           ON dishes.dish_type_name = t_dish_types.dish_type_name) t_source
	             LEFT JOIN
	                t_dishes t_stage
	             ON t_source.dish_code = t_stage.dish_code;
	
	
	
	   FETCH cur_dishes
	   BULK COLLECT INTO record_dishes;
	
	   curid       := dbms_sql.to_cursor_number ( cur_dishes );
	   dbms_sql.close_cursor ( curid );
	
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

END pkg_etl_dishes_dw_stage;
/