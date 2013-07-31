  SELECT /*+ parallel(ff 8 prg 8)*/
        TRUNC ( ff.date_dt
              , 'mm' )
            AS event_dt
       , DECODE ( GROUPING ( ff.country ), 1, 'All countries', ff.country ) AS country
       , DECODE ( GROUPING ( prg.program_desc ), 1, 'All programs', prg.program_desc ) AS program
       , DECODE ( GROUPING ( fs.fin_source_name ), 1, 'All sources', fs.fin_source_name ) AS fin_source
       , SUM ( ff.amount ) AS fin_amount
    FROM fact_financing ff
       , (SELECT ROWNUM AS rn
               , program_code
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
       , CUBE ( ff.country, prg.program_desc, fs.fin_source_name )
  HAVING GROUPING_ID ( fs.fin_source_name ) < 1
ORDER BY 1
       , 2
       , 3