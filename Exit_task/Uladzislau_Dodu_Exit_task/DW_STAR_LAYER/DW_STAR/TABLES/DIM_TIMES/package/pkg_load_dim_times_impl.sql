/* Formatted on 8/12/2013 5:45:48 PM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_dim_times
AS
   PROCEDURE load_dim_times
   AS
   BEGIN
      MERGE INTO dw_star.dim_times
           USING (SELECT TRUNC ( sd + rn ) time_id
                       , TO_CHAR ( sd + rn
                                 , 'D' )
                            day_number_in_week
                       , TO_CHAR ( sd + rn
                                 , 'DD' )
                            day_number_in_month
                       , TO_CHAR ( sd + rn
                                 , 'DDD' )
                            day_number_in_year
                       , TO_CHAR ( sd + rn
                                 , 'W' )
                            calendar_week_number
                       , ( CASE
                             WHEN TO_CHAR ( sd + rn
                                          , 'D' ) IN (1, 2, 3, 4, 5, 6) THEN
                                NEXT_DAY ( sd + rn
                                         , 'Saturday' )
                             ELSE
                                ( sd + rn )
                          END )
                            week_ending_date
                       , TO_CHAR ( sd + rn
                                 , 'MM' )
                            calendar_month_number
                       , TO_CHAR ( LAST_DAY ( sd + rn )
                                 , 'DD' )
                            days_in_cal_month
                       , LAST_DAY ( sd + rn ) end_of_cal_month
                       , TO_CHAR ( sd + rn
                                 , 'FMMonth' )
                            calendar_month_name
                       , TO_CHAR ( sd + rn
                                 , 'Q' )
                            calendar_quarter_number
                       , TO_CHAR ( sd + rn
                                 , 'YYYY' )
                            calendar_year
                       , TO_CHAR ( TO_DATE ( '12/31/'
                                             || TO_CHAR ( sd + rn
                                                        , 'YYYY' )
                                           , 'MM/DD/YYYY' )
                                 , 'MM/DD/YYYY' )
                            end_of_cal_year
                    FROM (    SELECT TO_DATE ( '12/31/2007'
                                             , 'MM/DD/YYYY' )
                                        sd
                                   , ROWNUM rn
                                FROM DUAL
                          CONNECT BY LEVEL <= 2000))
              ON ( event_dt = time_id )
      WHEN NOT MATCHED THEN
         INSERT            ( event_dt
                           , day_of_week
                           , day_num_cal_month
                           , day_num_cal_year
                           , cal_week_num
                           , end_of_week
                           , month_name
                           , days_in_month
                           , year_cal
                           , year_ends )
             VALUES ( time_id
                    , day_number_in_week
                    , day_number_in_month
                    , day_number_in_year
                    , calendar_week_number
                    , week_ending_date
                    , calendar_month_number
                    , days_in_cal_month
                    , calendar_year
                    , end_of_cal_year );

      COMMIT;
   END load_dim_times;
END;