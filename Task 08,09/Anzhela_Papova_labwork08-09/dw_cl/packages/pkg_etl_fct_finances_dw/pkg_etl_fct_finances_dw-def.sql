/* Formatted on 07.08.2013 13:31:16 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE pkg_etl_fct_finances_dw
-- Package Reload Data about Managers, Programs  From Source table Programs
--
AS
   PROCEDURE load_gdp_countries ( p_date_from     DATE DEFAULT ADD_MONTHS ( TRUNC ( SYSDATE
                                                                                  , 'yyyy' )
                                                                          , -12 )
                                , p_date_to       DATE DEFAULT TRUNC ( SYSDATE
                                                                     , 'mm' ) );

   PROCEDURE load_finance_countries ( p_date_from     DATE DEFAULT ADD_MONTHS ( TRUNC ( SYSDATE
                                                                                  , 'yyyy' )
                                                                          , -12 )
                                , p_date_to       DATE DEFAULT TRUNC ( SYSDATE
                                                                     , 'mm' ) );

   PROCEDURE load_fact_financing ( p_date_from     DATE DEFAULT ADD_MONTHS ( TRUNC ( SYSDATE
                                                                                  , 'yyyy' )
                                                                          , -12 )
                                , p_date_to       DATE DEFAULT TRUNC ( SYSDATE
                                                                     , 'mm' ) );
END pkg_etl_fct_finances_dw;
/