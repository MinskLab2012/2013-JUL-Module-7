/* Formatted on 10.08.2013 14:16:12 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE pkg_etl_act_fct_finances_dw_cl
-- Package load Fact data for rewriting from DW Layer
--
AS
   PROCEDURE load_act_fct_fin_countries ( p_date_from     DATE DEFAULT ADD_MONTHS ( TRUNC ( SYSDATE
                                                                                  , 'yyyy' )
                                                                          , -12 )
                                , p_date_to       DATE DEFAULT TRUNC ( SYSDATE
                                                                     , 'mm' ) );
END  pkg_etl_act_fct_finances_dw_cl;
/