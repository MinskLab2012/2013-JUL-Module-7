/* Formatted on 12.08.2013 17:31:01 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE pkg_etl_fct_fin_countries_sal
-- Package load Data into fact table
--
AS
   PROCEDURE load_fct_fin_countries ( p_date_from     DATE DEFAULT ADD_MONTHS ( TRUNC ( SYSDATE
                                                                                      , 'yyyy' )
                                                                              , -12 )
                                    , p_date_to       DATE DEFAULT TRUNC ( SYSDATE
                                                                         , 'mm' ) );
END pkg_etl_fct_fin_countries_sal;
/