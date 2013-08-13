/* Formatted on 10.08.2013 17:49:19 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_etl_dim_time_mm_sal
AS
   -- Procedure load Month sequence in Dimension entity SCD type 1
   PROCEDURE load_dim_time_mm
   AS
   BEGIN
      --Merge data
      MERGE INTO sal.dim_time_mm trg
           USING (SELECT time_id
                       , calendar_month_number
                       , days_in_cal_month
                       , end_of_cal_month
                       , calendar_month_name
                       , days_in_cal_quarter
                       , beg_of_cal_quarter
                       , end_of_cal_quarter
                       , calendar_quarter_number
                       , calendar_year
                       , days_in_cal_year
                       , beg_of_cal_year
                       , end_of_cal_year
                    FROM sal_dw_cl.v_time_mm) cls
              ON ( trg.time_id = cls.time_id )
      WHEN NOT MATCHED THEN
         INSERT            ( time_id
                           , calendar_month_number
                           , days_in_cal_month
                           , end_of_cal_month
                           , calendar_month_name
                           , days_in_cal_quarter
                           , beg_of_cal_quarter
                           , end_of_cal_quarter
                           , calendar_quarter_number
                           , calendar_year
                           , days_in_cal_year
                           , beg_of_cal_year
                           , end_of_cal_year )
             VALUES ( cls.time_id
                    , cls.calendar_month_number
                    , cls.days_in_cal_month
                    , cls.end_of_cal_month
                    , cls.calendar_month_name
                    , cls.days_in_cal_quarter
                    , cls.beg_of_cal_quarter
                    , cls.end_of_cal_quarter
                    , cls.calendar_quarter_number
                    , cls.calendar_year
                    , cls.days_in_cal_year
                    , cls.beg_of_cal_year
                    , cls.end_of_cal_year );

      --Commit Results
      COMMIT;
   END load_dim_time_mm;
END pkg_etl_dim_time_mm_sal;
/