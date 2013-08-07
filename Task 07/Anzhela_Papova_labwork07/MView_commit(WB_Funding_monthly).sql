/* Formatted on 07.08.2013 8:58:20 (QP5 v5.139.911.3011) */
ALTER SESSION SET query_rewrite_enabled = TRUE;
ALTER SESSION SET query_rewrite_integrity = enforced;

CREATE MATERIALIZED VIEW LOG ON  fact_financing
   WITH ROWID (date_dt, country,  program_code ,
  fin_source_id , amount, loan_charge,
  end_date)
   INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW LOG ON  programs
   WITH ROWID  (program_code, program_name, program_purpose ,
  manager_fn,  manager_ln,  start_date, end_date)
   INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW LOG ON  finance_sources
   WITH ROWID (fin_source_id, fin_source_name)
   INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW mv_funding_monthly
BUILD IMMEDIATE
REFRESH FAST ON COMMIT
ENABLE QUERY REWRITE
AS
  SELECT
        TRUNC ( ff.date_dt
              , 'mm' )
            AS event_dt
       ,  ff.country  AS country
       ,  prg.program_desc  AS program
       ,  fs.fin_source_name AS fin_source
       , SUM ( ff.amount ) AS fin_amount
       , COUNT (ff.amount) AS count_am
          FROM fact_financing ff
       , (SELECT program_code
               , program_name AS program_desc
               , manager_fn || ' ' || manager_ln AS manager_desc
              , start_date AS valid_from
             , end_date AS valid_to
            FROM programs) prg
       , finance_sources fs
   WHERE prg.program_code = ff.program_code
     AND ff.date_dt >= prg.valid_from
     AND ff.date_dt <= prg.valid_to
     AND ff.fin_source_id = fs.fin_source_id
GROUP BY TRUNC ( ff.date_dt
               , 'mm' )
       ,  ff.country, prg.program_desc, fs.fin_source_name
ORDER BY 1
       , 2
       , 3;