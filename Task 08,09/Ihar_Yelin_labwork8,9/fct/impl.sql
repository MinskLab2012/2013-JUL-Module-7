CREATE OR REPLACE PACKAGE BODY pkg_load_fct
AS
 procedure load_facts
   as
   begin
      --truncate cleansing tables
      execute immediate 'TRUNCATE TABLE fct_sales_dd';

      --Extract data
      insert into fct_sales_dd
       select op.event_dt, cl.client_surr_id, su.suppl_surr_id, pr.prod_surr_id, st.struct_surr_id,
del.del_surr_id, op.sold,ge.geo_surr_id  from u_dw_references.operations op
left join dm_clients cl
on op.client_id=cl.client_id
left join dm_delivery del
on del.deliv_id=op.deliv_id
left join dm_products pr
on pr.prod_id=op.prod_id
left join dm_structures st
on op.employee_id=st.employee_id or op.department_id=st.department_id
left join dm_suppliers su
on su.suppl_id=op.suppl_id
left join dm_geo ge
on st.geo_id=ge.country_geo_id;
      --Commit Data
      commit;
   end load_facts;
   END pkg_load_fct;