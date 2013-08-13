/* Formatted on 08.08.2013 16:41:58 (QP5 v5.139.911.3011) */
CREATE OR REPLACE VIEW v_time_mm
AS
   SELECT month_id AS time_id
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
     FROM dw.t_months
        , dw.t_quarters
        , dw.t_years
    WHERE dw.t_months.quarter_id = dw.t_quarters.quarter_id
      AND dw.t_months.year_id = dw.t_years.year_id;