/* Formatted on 10.08.2013 13:54:20 (QP5 v5.139.911.3011) */
CREATE OR REPLACE VIEW v_gen_periods
AS
   SELECT period_id
        , period_code
        , period_desc
        , value_from_num
        , value_to_num
        , TO_DATE ( '01/01/1800'
                  , 'dd/mm/yyyy' )
             AS value_from_dt
        , TO_DATE ( '01/01/1800'
                  , 'dd/mm/yyyy' )
             AS value_to_dt
        , 'n.d.' AS value_from_char
        , 'n.d.' AS value_to_char
        , 'Deficit level' AS level_code
     FROM dw.t_gen_periods;