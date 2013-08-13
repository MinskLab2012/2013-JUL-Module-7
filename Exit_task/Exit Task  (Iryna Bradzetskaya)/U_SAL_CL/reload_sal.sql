BEGIN

	pkg_etl_dim_customers_sal.load_DIM_CUSTOMERS;
	pkg_etl_dim_tariffs_sal.load_dim_tarrifs;
	pkg_etl_operations_sal.load_dim_operations;
	pkg_load_dim_currency_sal.load_currency;
	pkg_load_dim_location.load_location;
	pkg_etl_periods_sal.load_dim_periods;
	pkg_load_fct_transactions_tmp.load_fct_transactions_tmp( 2013 );
	pkg_load_fct_transactions_tmp.load_fct_transactions_tmp( 2012 );
	pkg_load_fct_transactions_tmp.load_fct_transactions_tmp( 2011 );
	pkg_load_fct_transactions_tmp.load_fct_transactions_tmp( 2010 );
	pkg_load_fct_transactions_tmp.load_fct_transactions_tmp( 2009 );
	pkg_load_fct_transactions_tmp.load_fct_transactions_tmp( 2008 );
	pkg_load_fct_transactions_tmp.load_fct_transactions_tmp( 2007 );
	pkg_load_fct_transactions_tmp.load_fct_transactions_tmp( 2006 );
	pkg_load_fct_transactions_tmp.load_fct_transactions_tmp( 2005 );
	pkg_load_fct_transactions_tmp.load_fct_transactions_tmp( 2004 );
	pkg_load_fct_transactions_tmp.load_fct_transactions_tmp( 2003 );
	pkg_load_fct_transactions_tmp.load_fct_transactions_tmp( 2002 );
	pkg_load_fct_transactions_tmp.load_fct_transactions_tmp( 2001 );
	pkg_load_fct_transactions_tmp.load_fct_transactions_tmp( 2000 );
	pkg_load_fct_transactions_tmp.load_fct_transactions_tmp( 1999 );

END;