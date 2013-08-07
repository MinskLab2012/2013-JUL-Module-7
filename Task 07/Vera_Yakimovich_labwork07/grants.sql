GRANT CREATE MATERIALIZED VIEWS TO u_dw_ext_references;
GRANT ON COMMIT REFRESH TO u_dw_ext_references;
GRANT SELECT ON t_orders   TO u_dw_ext_references  WITH GRANT OPTION;