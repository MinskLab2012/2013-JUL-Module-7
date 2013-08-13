I used u_dw_reference schema with physical
 geo objects instead of creating same tables and procedures in st_data.
In fact, st_data and u_dw_references are stage level schemas.
Because of that, I had to grant privileges on
 U_DW_REFERENCES to st_data and U_DW_EXT_REFERENCES schemas (grant_select_on_tables_to_schema procedure).
I'ts obvious that DIM_GEO_COUNTRIES table is loaded from U_DW_REFERENCES schema (LOAD_DIM_GEO_COUNTRIES procedure).
The procedure itself is called from ST_DATA (load_sal_star.sql).

Sorry for possible complication...