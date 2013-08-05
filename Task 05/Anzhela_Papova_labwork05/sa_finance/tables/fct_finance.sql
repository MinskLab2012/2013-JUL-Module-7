/* Formatted on 04.08.2013 19:46:44 (QP5 v5.139.911.3011) */
CREATE TABLE fct_finance
AS
     SELECT tmp.country AS country
          , TO_CHAR (  tmp.event_dt
                            , 'yyyy'  )
               AS year
          , 'Q'||TO_CHAR (  tmp.event_dt
                            , 'Q'  )
               AS quarter
          , SUM ( tmp.gdp ) AS gdp
          , SUM ( tmp.bud_revenues ) AS bud_revenues
          , SUM ( tmp.bud_expences ) AS bud_expences
          , SUM ( tmp.fin_amount ) AS fin_amount
       FROM (SELECT /*+ parallel(ff 8)*/
                   TRUNC ( ff.date_dt
                         , 'mm' )
                       AS event_dt
                  , ff.country
                  , 0 AS gdp
                  , 0 AS bud_revenues
                  , 0 AS bud_expences
                  , ff.amount AS fin_amount
               FROM fact_financing ff
             UNION ALL
             SELECT /*+ parallel(gdp 8)*/
                   TO_DATE ( '01/' || gdp.month || '/' || gdp.year
                           , 'dd/mm/yyyy' )
                       AS event_dt
                  , gdp.country
                  , gdp.gdp AS gdp
                  , 0 AS bud_revenues
                  , 0 AS bud_expences
                  , 0 AS fin_amount
               FROM gdp_countries gdp
             UNION ALL
             SELECT /*+ parallel(fcntr 8)*/
                   TO_DATE ( '01/' || fcntr.month || '/' || fcntr.year
                           , 'dd/mm/yyyy' )
                       AS event_dt
                  , fcntr.country
                  , 0 AS gdp
                  , DECODE ( fcntr.grp, 'R', fcntr.amount, 0 ) AS bud_revenues
                  , DECODE ( fcntr.grp, 'E', fcntr.amount, 0 ) AS bud_expences
                  , 0 AS fin_amount
               FROM finance_countries fcntr) tmp
   GROUP BY country
          , TO_CHAR (  tmp.event_dt
                            , 'yyyy'  )
          , TO_CHAR (  tmp.event_dt
                            , 'Q'  )