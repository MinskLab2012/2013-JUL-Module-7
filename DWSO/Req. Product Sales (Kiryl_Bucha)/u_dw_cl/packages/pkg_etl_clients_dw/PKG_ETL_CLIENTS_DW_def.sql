CREATE OR REPLACE PACKAGE U_DW_CL.pkg_etl_clients_dw
AS
   g_tbl_action   tbl_client_action := tbl_client_action ( );

   PROCEDURE load_cls_clients;

   PROCEDURE load_dim_merge_clients;

   PROCEDURE load_cls_clients_actions ( p_start_dt      DATE DEFAULT ADD_MONTHS ( TRUNC ( SYSDATE )
                                                                                , -3 )
                                      , p_end_dt        DATE DEFAULT TRUNC ( SYSDATE ) );

   PROCEDURE load_client_geo_sales_init ( p_end_dt DATE DEFAULT TRUNC ( SYSDATE ) );

   PROCEDURE load_client_geo_sales ( p_start_dt      DATE DEFAULT ADD_MONTHS ( TRUNC ( SYSDATE )
                                                                             , -3 )
                                   , p_end_dt        DATE DEFAULT TRUNC ( SYSDATE ) );

   FUNCTION show_tbl_acton
      RETURN tbl_client_action
      PIPELINED;
END pkg_etl_clients_dw;
/
