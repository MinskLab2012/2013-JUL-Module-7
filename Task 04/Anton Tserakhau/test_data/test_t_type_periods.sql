/* Formatted on 04.08.2013 17:04:18 (QP5 v5.139.911.3011) */
( ( SELECT PERIOD_TYPE_NAME
         , PERIOD_TYPE_DESC
      FROM T_TYPE_PERIODS )
 MINUS
 ( SELECT PERIOD_TYPE_NAME
        , PERIOD_TYPE_DESC
     FROM u_dw_ext_references.cls_periods ) )
UNION ALL
( ( SELECT PERIOD_TYPE_NAME
        , PERIOD_TYPE_DESC
     FROM u_dw_ext_references.cls_periods )
 MINUS
 ( SELECT PERIOD_TYPE_NAME
         , PERIOD_TYPE_DESC
      FROM T_TYPE_PERIODS  ) );