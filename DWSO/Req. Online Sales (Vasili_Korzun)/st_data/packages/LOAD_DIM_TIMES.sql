/* Formatted on 13.08.2013 0:00:26 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PROCEDURE load_dim_times
AS
BEGIN
   sal_star.truncate_dim_times;

   MERGE INTO sal_star.dim_times dt
        USING (SELECT TRUNC (sd + rn) time_id,
                      TO_CHAR (sd + rn, 'fmDay') day_name,
                      TO_CHAR (sd + rn, 'D') day_number_in_week,
                      TO_CHAR (sd + rn, 'DD') day_number_in_month,
                      TO_CHAR (sd + rn, 'DDD') day_number_in_year,
                      TO_CHAR (sd + rn, 'W') calendar_week_number,
                      (CASE
                          WHEN TO_CHAR (sd + rn, 'D') IN (1, 2, 3, 4, 5, 6)
                          THEN
                             NEXT_DAY (sd + rn, 'Saturday')
                          ELSE
                             (sd + rn)
                       END)
                         week_ending_date,
                      TO_CHAR (sd + rn, 'MM') calendar_month_number,
                      TO_CHAR (LAST_DAY (sd + rn), 'DD') days_in_cal_month,
                      LAST_DAY (sd + rn) end_of_cal_month,
                      TO_CHAR (sd + rn, 'FMMonth') calendar_month_name,
                      ( (CASE
                            WHEN TO_CHAR (sd + rn, 'Q') = 1
                            THEN
                               TO_DATE (
                                  '03/31/' || TO_CHAR (sd + rn, 'YYYY'),
                                  'MM/DD/YYYY')
                            WHEN TO_CHAR (sd + rn, 'Q') = 2
                            THEN
                               TO_DATE (
                                  '06/30/' || TO_CHAR (sd + rn, 'YYYY'),
                                  'MM/DD/YYYY')
                            WHEN TO_CHAR (sd + rn, 'Q') = 3
                            THEN
                               TO_DATE (
                                  '09/30/' || TO_CHAR (sd + rn, 'YYYY'),
                                  'MM/DD/YYYY')
                            WHEN TO_CHAR (sd + rn, 'Q') = 4
                            THEN
                               TO_DATE (
                                  '12/31/' || TO_CHAR (sd + rn, 'YYYY'),
                                  'MM/DD/YYYY')
                         END)
                       - TRUNC (sd + rn, 'Q')
                       + 1)
                         days_in_cal_quarter,
                      TRUNC (sd + rn, 'Q') beg_of_cal_quarter,
                      (CASE
                          WHEN TO_CHAR (sd + rn, 'Q') = 1
                          THEN
                             TO_DATE ('03/31/' || TO_CHAR (sd + rn, 'YYYY'),
                                      'MM/DD/YYYY')
                          WHEN TO_CHAR (sd + rn, 'Q') = 2
                          THEN
                             TO_DATE ('06/30/' || TO_CHAR (sd + rn, 'YYYY'),
                                      'MM/DD/YYYY')
                          WHEN TO_CHAR (sd + rn, 'Q') = 3
                          THEN
                             TO_DATE ('09/30/' || TO_CHAR (sd + rn, 'YYYY'),
                                      'MM/DD/YYYY')
                          WHEN TO_CHAR (sd + rn, 'Q') = 4
                          THEN
                             TO_DATE ('12/31/' || TO_CHAR (sd + rn, 'YYYY'),
                                      'MM/DD/YYYY')
                       END)
                         end_of_cal_quarter,
                      TO_CHAR (sd + rn, 'Q') calendar_quarter_number,
                      TO_CHAR (sd + rn, 'YYYY') calendar_year,
                      (TO_DATE ('12/31/' || TO_CHAR (sd + rn, 'YYYY'),
                                'MM/DD/YYYY')
                       - TRUNC (sd + rn, 'YEAR'))
                         days_in_cal_year,
                      TRUNC (sd + rn, 'YEAR') beg_of_cal_year,
                      TO_DATE ('12/31/' || TO_CHAR (sd + rn, 'YYYY'),
                               'MM/DD/YYYY')
                         end_of_cal_year
                 FROM (    SELECT TO_DATE ('01/01/2010', 'MM/DD/YYYY') sd,
                                  ROWNUM rn
                             FROM DUAL
                       CONNECT BY LEVEL <= 1200)) dc
           ON (dt.time_id = dc.time_id)
   WHEN NOT MATCHED
   THEN
      INSERT            (TIME_ID,
                         DAY_NAME,
                         DAY_NUMBER_IN_WEEK,
                         DAY_NUMBER_IN_MONTH,
                         DAY_NUMBER_IN_YEAR,
                         CALENDAR_WEEK_NUMBER,
                         WEEK_ENDING_DATE,
                         CALENDAR_MONTH_NUMBER,
                         DAYS_IN_CAL_MONTH,
                         END_OF_CAL_MONTH,
                         CALENDAR_MONTH_NAME,
                         CALENDAR_QUARTER_NUMBER,
                         DAYS_IN_CAL_QUARTER,
                         BEG_OF_CALENDAR_QUARTER,
                         END_OF_CALENDAR_QUARTER,
                         CALENDAR_YEAR,
                         DAYS_IN_CAL_YEAR,
                         BEG_OF_CAL_YEAR,
                         END_OF_CAL_YEAR)
          VALUES (dc.TIME_ID,
                  dc.DAY_NAME,
                  dc.DAY_NUMBER_IN_WEEK,
                  dc.DAY_NUMBER_IN_MONTH,
                  dc.DAY_NUMBER_IN_YEAR,
                  dc.CALENDAR_WEEK_NUMBER,
                  dc.WEEK_ENDING_DATE,
                  dc.CALENDAR_MONTH_NUMBER,
                  dc.DAYS_IN_CAL_MONTH,
                  dc.END_OF_CAL_MONTH,
                  dc.CALENDAR_MONTH_NAME,
                  dc.CALENDAR_QUARTER_NUMBER,
                  dc.DAYS_IN_CAL_QUARTER,
                  dc.beg_of_cal_quarter,
                  dc.end_of_cal_quarter,
                  dc.CALENDAR_YEAR,
                  dc.DAYS_IN_CAL_YEAR,
                  dc.BEG_OF_CAL_YEAR,
                  dc.END_OF_CAL_YEAR);

   COMMIT;
END load_dim_times;

BEGIN
   load_dim_times;
END;


select min(event_dt), max(event_dt),  max(event_dt)-  min(event_dt)
from transactions;