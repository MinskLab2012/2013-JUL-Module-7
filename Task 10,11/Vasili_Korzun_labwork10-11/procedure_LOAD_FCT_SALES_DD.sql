/* Formatted on 13.08.2013 15:39:57 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PROCEDURE load_fct_sales_dd
AS
BEGIN
sal_star.disable_constraints;

   insert into sal_star.fct_sales_dd (   transaction_id, event_dt, prod_id, geo_surr_id, payment_system_surr_id, delivery_system_id, ta_geo_id, ta_payment_system_id, quantity_sold , amount_sold, insert_dt)
   select sal_star.seq_fct_sales_dd.nextval, event_dt, prod_id, geo_surr_id, payment_system_surr_id, delivery_system_id, ta_geo_id, ta_payment_system_id, quantity_sold , amount_sold, sysdate
   from(
   select trunc(event_dt, 'dd') as event_dt, prod_Id,  geo_surr_id, payment_system_surr_id, delivery_system_id, ta_geo_id, ta_payment_system_id, count(amount_sold)  as quantity_sold ,sum(amount_sold) as amount_sold
from
(
SELECT /*+ USE_HASH(tt, gl, ps) */
event_dt, prod_id, gl.geo_surr_id, ps.payment_system_surr_id, delivery_system_id, amount_sold, status_id, gl.geo_id as ta_geo_id, ps.payment_system_id as ta_payment_system_id
  FROM transactions tt
         JOIN sal_star.DIM_GEO_LOCATIONS_SCD gl
          ON tt.country_geo_id = gl.geo_id
          --and tt.event_dt > gl.valid_from and tt.event_dt < gl.valid_to
          join  sal_star.dim_payment_systems_scd ps
          on tt.payment_system_id = ps.payment_system_id
          --and tt.event_dt > ps.valid_from and tt.event_dt < ps.valid_to
          /*
          -- This joins are not necessary because I alredy have valid PK for products and delivery systems.
       JOIN sal_star.dim_products pr
          ON tt.prod_id = pr.prod_id

          join sal_star.dim_delivery_systems ds
          on tt.delivery_system_id = ds.delivery_system_id
          */
          )
          group by trunc(event_dt, 'dd'), prod_id, geo_surr_id, payment_system_surr_id, delivery_system_id, ta_geo_id, ta_payment_system_id
          minus 
          select  /*+parallel(dim_t, 4) */
          event_dt, prod_id,  geo_surr_id, payment_system_surr_id, delivery_system_id, ta_geo_id, ta_payment_system_id, quantity_sold , amount_sold
          from sal_star.fct_sales_dd dim_t
          );
          sal_star.enable_constraints;
          commit;
END load_fct_sales_dd;


begin
load_fct_sales_dd;
end;


/*
-- I'm not using condition VALID_FROM < EVENT_DT < VALID_TO because my transactions are generated in 3 years and it's meaningless to apply this condition to test data.
select trunc(event_dt, 'dd') as event_dt, geo_surr_id, payment_system_surr_id, delivery_system_id, ta_geo_id, ta_payment_system_id, count(amount_sold)  as quantity_sold ,sum(amount_sold) as amount_sold
from
(
SELECT --+ USE_HASH(tt, gl, ps) 
event_dt, prod_id, gl.geo_surr_id, ps.payment_system_surr_id, delivery_system_id, amount_sold, status_id, gl.geo_id as ta_geo_id, ps.payment_system_id as ta_payment_system_id
  FROM transactions tt
         JOIN sal_star.DIM_GEO_LOCATIONS_SCD gl
          ON tt.country_geo_id = gl.geo_id
          --and tt.event_dt > gl.valid_from and tt.event_dt < gl.valid_to
          join  sal_star.dim_payment_systems_scd ps
          on tt.payment_system_id = ps.payment_system_id
          --and tt.event_dt > ps.valid_from and tt.event_dt < ps.valid_to

--           This joins are not necessary because I alredy have valid PK for products and delivery systems.
--       JOIN sal_star.dim_products pr
--          ON tt.prod_id = pr.prod_id
--          join sal_star.dim_delivery_systems ds
--          on tt.delivery_system_id = ds.delivery_system_id

          )
          group by trunc(event_dt, 'dd'), geo_surr_id, payment_system_surr_id, delivery_system_id, ta_geo_id, ta_payment_system_id
          minus 
          select  --+parallel(dim_t, 4) 
          event_dt, geo_surr_id, payment_system_surr_id, delivery_system_id, ta_geo_id, ta_payment_system_id, quantity_sold , amount_sold
          from sal_star.fct_sales_dd dim_t;
          
          */
