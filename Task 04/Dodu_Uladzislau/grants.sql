/* Formatted on 8/4/2013 12:51:55 PM (QP5 v5.139.911.3011) */
GRANT SELECT ON u_dw_ext_references.agr_trans TO cls_st;
GRANT SELECT ON u_dw_ext_references.t_trans TO cls_st;
GRANT SELECT ON u_dw_ext_references.ext_insurances TO cls_st;
GRANT SELECT ON u_dw_ext_references.ext_ship TO cls_st;
GRANT SELECT ON u_dw_ext_references.ext_prod_categories TO cls_st;
GRANT SELECT ON u_dw_ext_references.ports TO cls_st;
GRANT SELECT ON u_dw_ext_references.ext_products TO cls_st;
GRANT SELECT ON u_dw_ext_references.ext_customers TO cls_st;


GRANT SELECT, INSERT, UPDATE, DELETE ON st.localization TO cls_st;
GRANT SELECT, INSERT, UPDATE, DELETE ON st.t_categories TO cls_st;
GRANT SELECT, INSERT, UPDATE, DELETE ON st.t_customers TO cls_st;
GRANT SELECT, INSERT, UPDATE, DELETE ON st.t_insurance_type TO cls_st;
GRANT SELECT, INSERT, UPDATE, DELETE ON st.t_products TO cls_st;
GRANT SELECT, INSERT, UPDATE, DELETE ON st.t_insurance TO cls_st;
GRANT SELECT, INSERT, UPDATE, DELETE ON st.t_ports TO cls_st;
GRANT SELECT, INSERT, UPDATE, DELETE ON st.t_ships TO cls_st;
GRANT SELECT, INSERT, UPDATE, DELETE ON st.action_types TO cls_st;
GRANT SELECT, INSERT, UPDATE, DELETE ON st.prod_actions TO cls_st;
GRANT SELECT, INSERT, UPDATE, DELETE ON st.lc_categories TO cls_st;
GRANT SELECT, INSERT, UPDATE, DELETE ON st.lc_customers TO cls_st;
GRANT SELECT, INSERT, UPDATE, DELETE ON st.lc_insurances TO cls_st;
GRANT SELECT, INSERT, UPDATE, DELETE ON st.lc_ports TO cls_st;
GRANT SELECT, INSERT, UPDATE, DELETE ON st.lc_products TO cls_st;
GRANT SELECT, INSERT, UPDATE, DELETE ON st.t_trans TO cls_st;

GRANT SELECT  ON st.seq_localization TO cls_st;
GRANT SELECT ON st.seq_action_type TO cls_st;
GRANT SELECT ON st.prod_actions TO cls_st;
GRANT SELECT ON st.seq_t_categories TO cls_st;
GRANT SELECT ON st.seq_t_ships TO cls_st;
GRANT SELECT ON st.seq_t_customers TO cls_st;
GRANT SELECT ON st.seq_t_ports TO cls_st;
GRANT SELECT ON st.seq_t_insurance TO cls_st;
GRANT SELECT ON st.seq_t_products TO cls_st;