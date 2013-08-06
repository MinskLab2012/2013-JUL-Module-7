create table t_weeks as (
SELECT week_id
     , TO_CHAR ( week_id
               , 'W' )
          calendar_week_number
          , week_id + 6 week_ending_date
          , TRUNC ( week_id
             , 'YYYY' )
          year_id
  FROM (SELECT DISTINCT ( CASE
                            WHEN TO_CHAR ( sd + rn
                                         , 'D' ) IN (1, 2, 3, 4, 5, 6) THEN
                               NEXT_DAY ( sd + rn
                                        , 'SATURDAY' )
                            ELSE
                               ( sd + rn )
                         END )
                        - 6
                           week_id
          FROM (    SELECT TO_DATE ( '12/31/1999'
                                   , 'MM/DD/YYYY' )
                              sd
                         , ROWNUM AS rn
                      FROM DUAL
                CONNECT BY LEVEL <= 7300)));
  
ALTER TABLE T_WEEKS
ADD CONSTRAINT TW_PK PRIMARY KEY (WEEK_ID);

ALTER TABLE T_WEEKS
ADD CONSTRAINT TW_FK1 FOREIGN KEY (YEAR_ID) REFERENCES T_YEARS (YEAR_ID);
