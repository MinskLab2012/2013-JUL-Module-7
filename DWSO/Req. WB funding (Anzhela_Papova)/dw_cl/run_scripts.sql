BEGIN
   pkg_etl_dim_fin_sources_dw.load_finance_sources;
   pkg_etl_fin_groups_dw.load_finance_groups;
   pkg_etl_fin_items_dw.load_finance_items;
   pkg_etl_gen_periods_dw.load_gen_periods;
END;





