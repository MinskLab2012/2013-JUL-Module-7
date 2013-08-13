BEGIN
   pkg_etl_act_programs_dw_cl.load_act_programs;
   pkg_etl_act_countries_dw_cl.load_act_countries;
   pkg_etl_act_fct_finances_dw_cl.load_act_fct_fin_countries;
END;