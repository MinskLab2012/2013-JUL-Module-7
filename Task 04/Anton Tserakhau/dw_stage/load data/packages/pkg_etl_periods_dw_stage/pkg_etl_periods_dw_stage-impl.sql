/* Formatted on 02.08.2013 14:46:36 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_periods_dw_stage
AS

   -- Load All Period Types
   PROCEDURE load_t_period_types
   AS
   BEGIN
      DECLARE
	   TYPE t_cur_type_period IS REF CURSOR ;
	
	   TYPE t_type_record_n IS TABLE OF number(10);  
	   TYPE t_type_record_v IS TABLE OF varchar2(150);
	
	   cur_type_period t_cur_type_period;
	   
	   record_period_type_id_stage t_type_record_n;
	   record_period_type_name_source t_type_record_v;
	   record_period_type_name_stage t_type_record_v;
	   record_period_type_desc_source t_type_record_v;
	   record_period_type_desc_stage t_type_record_v;
	BEGIN
	   OPEN cur_type_period FOR
	       SELECT t_stage.period_type_id AS period_type_id_stage
	             , t_source.period_type_name AS period_type_name_source
	             , t_stage.period_type_name AS period_type_name_stage
	             , t_source.period_type_desc AS period_type_desc_source
	             , t_stage.period_type_desc AS period_type_desc_stage
	          FROM    (SELECT DISTINCT period_type_name
	                                 , period_type_desc
	                     FROM u_dw_ext_references.cls_periods) t_source
	               LEFT JOIN
	                  t_type_periods t_stage
	               ON t_stage.period_type_name = t_source.period_type_name ;
	
	   FETCH cur_type_period
	   BULK COLLECT INTO record_period_type_id_stage, record_period_type_name_source, record_period_type_name_stage, record_period_type_desc_source, record_period_type_desc_stage;
	
	   CLOSE cur_type_period;
	
	   FOR i IN record_period_type_id_stage.FIRST .. record_period_type_id_stage.LAST LOOP
	      IF ( record_period_type_id_stage ( i ) IS NULL ) THEN
	         INSERT INTO t_type_periods ( period_type_id
	                                    , period_type_name
	                                    , period_type_desc
	                                    , insert_dt
	                                    , update_dt )
	              VALUES ( seq_t_type_periods.NEXTVAL
	                     , record_period_type_name_source ( i )
	                     , record_period_type_desc_source ( i )
	                     , SYSDATE
	                     , NULL );
	
	         COMMIT;
	      ELSIF ( record_period_type_desc_source ( i )<> record_period_type_desc_stage ( i )) THEN
	         UPDATE t_type_periods
	            SET period_type_desc = record_period_type_desc_source ( i )
	              , update_dt    = SYSDATE
	          WHERE t_type_periods.period_type_id = record_period_type_id_stage ( i );
	
	         COMMIT;
	      END IF;
	   END LOOP;
	END;
   END load_t_period_types;


   -- Load All Periods 
   PROCEDURE load_t_periods
   AS
   BEGIN
      DECLARE
	   TYPE t_cur_period IS REF CURSOR;
	
	   TYPE t_type_record_n IS TABLE OF NUMBER ( 10 );
	
	   TYPE t_type_record_v IS TABLE OF VARCHAR2 ( 150 );
	
	   TYPE t_type_record_d IS TABLE OF DATE;
	
	   cur_period     t_cur_period;
	
	   record_period_id_stage t_type_record_n;
	
	   record_period_code_source t_type_record_v;
	   record_period_code_stage t_type_record_v;
	
	   record_period_desc_source t_type_record_v;
	   record_period_desc_stage t_type_record_v;
	
	   record_period_type_id_source t_type_record_n;
	   record_period_type_id_stage t_type_record_n;
	
	   record_start_dt_source t_type_record_d;
	   record_start_dt_stage t_type_record_d;
	
	   record_end_dt_source t_type_record_d;
	   record_end_dt_stage t_type_record_d;
	BEGIN
	   OPEN cur_period FOR
	      SELECT t_stage.period_id AS period_id_stage
	           , t_source.period_code AS period_code_source
	           , t_stage.period_code AS period_code_stage
	           , t_source.period_desc AS period_desc_source
	           , t_stage.period_desc AS period_desc_stage
	           , t_type_periods.period_type_id AS period_type_id_source
	           , t_stage.period_type_id AS period_type_id_stage
	           , t_source.start_dt AS start_dt_source
	           , t_stage.start_dt AS start_dt_stage
	           , t_source.end_dt AS end_dt_source
	           , t_stage.end_dt AS end_dt_stage
	        FROM (SELECT DISTINCT period_code
	                            , period_desc
	                            , start_dt
	                            , end_dt
	                            , period_type_name
	                FROM u_dw_ext_references.cls_periods) t_source
	             LEFT JOIN t_type_periods
	                ON t_type_periods.period_type_name = t_source.period_type_name
	             LEFT JOIN t_periods t_stage
	                ON t_source.period_code = t_stage.period_code;
	
	   FETCH cur_period
	   BULK COLLECT INTO record_period_id_stage
	                   , record_period_code_source
	                   , record_period_code_stage
	                   , record_period_desc_source
	                   , record_period_desc_stage
	                   , record_period_type_id_source
	                   , record_period_type_id_stage
	                   , record_start_dt_source
	                   , record_start_dt_stage
	                   , record_end_dt_source
	                   , record_end_dt_stage;
	
	   CLOSE cur_period;
	
	   FOR i IN record_period_id_stage.FIRST .. record_period_id_stage.LAST LOOP
	      IF ( record_period_id_stage ( i ) IS NULL ) THEN
	         INSERT INTO t_periods ( period_id
	                               , period_code
	                               , period_desc
	                               , period_type_id
	                               , start_dt
	                               , end_dt
	                               , insert_dt
	                               , update_dt )
	              VALUES ( seq_t_periods.NEXTVAL
	                     , record_period_code_source ( i )
	                     , record_period_desc_source ( i )
	                     , record_period_type_id_source ( i )
	                     , record_start_dt_source ( i )
	                     , record_end_dt_source ( i )
	                     , SYSDATE
	                     , NULL );
	
	         COMMIT;
	      ELSIF ( record_period_desc_source ( i ) <> record_period_desc_stage ( i )
	          OR  record_period_type_id_source ( i ) <> record_period_type_id_stage ( i )
	          OR  record_start_dt_source ( i ) <> record_start_dt_stage ( i )
	          OR  record_end_dt_source ( i ) <> record_end_dt_stage ( i ) ) THEN
	         UPDATE t_periods
	            SET period_desc  = record_period_desc_source ( i )
	              , period_type_id = record_period_type_id_source ( i )
	              , start_dt     = record_start_dt_source ( i )
	              , end_dt       = record_end_dt_source ( i )
	              , update_dt    = SYSDATE
	          WHERE t_periods.period_id = record_period_id_stage ( i );
	
	         COMMIT;
	      END IF;
	   END LOOP;
	END;

   END load_t_periods;
END pkg_etl_periods_dw_stage;
/