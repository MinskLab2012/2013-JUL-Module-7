BEGIN
   pkg_etl_dim_fin_sources_sal.load_dim_fin_sources;
   pkg_etl_dim_gen_periods_sal.load_dim_gen_periods;
   pkg_etl_dim_time_mm_sal.load_dim_time_mm;
   pkg_etl_tmp_programs_sal_cl.load_tmp_programs;
   pkg_etl_dim_programs_scd_sal.load_dim_programs_scd;
   pkg_etl_tmp_countries_sal_cl.load_tmp_countries;
   pkg_etl_dim_countries_scd_sal.load_dim_countries_scd;
   pkg_etl_fct_fin_countries_sal.load_fct_fin_countries;
END;