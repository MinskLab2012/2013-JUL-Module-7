BEGIN

	pkg_etl_currency_dw.load_currency_types;
	pkg_etl_dim_currensy_dw.load_tmp_currensy;
	pkg_etl_dim_customers_dw.load_tmp_CUSTOMERS;
	pkg_etl_dim_operations_dw.load_tmp_methods;
	pkg_etl_dim_operations_dw.load_tmp_operations;
	pkg_etl_dim_tariffs_dw.load_tmp_tariffs;
	pkg_etl_geo_actions.load_geo_actions;
	pkg_etl_transactions_dw.load_transactions;
	pkg_etl_periods_dw.load_periods;

END;