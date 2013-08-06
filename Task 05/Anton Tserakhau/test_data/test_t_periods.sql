
( ( SELECT period_code
         , period_desc
         , start_dt
         , end_dt
      FROM t_periods )
 MINUS
 ( SELECT period_code
        , period_desc
        , start_dt
        , end_dt
     FROM u_dw_ext_references.cls_periods ) )
UNION ALL
( ( SELECT period_code
         , period_desc
         , start_dt
         , end_dt
      FROM u_dw_ext_references.cls_periods )
 MINUS
 ( SELECT period_code
        , period_desc
        , start_dt
        , end_dt
     FROM t_periods ) );