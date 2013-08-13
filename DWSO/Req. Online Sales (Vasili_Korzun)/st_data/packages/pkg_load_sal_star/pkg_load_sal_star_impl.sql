create or replace package body pkg_load_sal_star
as

PROCEDURE load_dim_payment_systems
AS
BEGIN
insert into sal_star.dim_payment_systems_scd (payment_system_surr_id, payment_system_id,
          PAYMENT_SYSTEM_CODE,
          payment_system_desc,
          payment_system_type_id,
          payment_system_type_desc,
          valid_from, insert_dt)
          select sal_star.seq_dim_payment_systems.nextval, payment_system_id,
          payment_system_code,
          payment_system_desc,
          payment_system_type_id,
          payment_system_type_desc,
          action_dt, sysdate
          from(
       SELECT payment_system_id,
          payment_system_code,
          payment_system_desc,
          payment_system_type_id,
          payment_system_type_desc,
          action_dt
          from v_actual_payment_systems
          minus
          select payment_system_id,
          PAYMENT_SYSTEM_CODE,
          payment_system_desc,
          payment_system_type_id,
          payment_system_type_desc,
          valid_from
          from sal_star.dim_payment_systems_scd);
          commit;
          
          
             MERGE INTO sal_star.dim_payment_systems_scd dgl
        USING (SELECT payment_system_surr_id,
                      LEAD (valid_from, 1, '31-DEC-9999')
                         OVER (PARTITION BY payment_system_id ORDER BY valid_to ASC)
                         AS valid_to
                 FROM sal_star.dim_payment_systems_scd) UP
           ON (dgl.payment_system_surr_id = UP.payment_system_surr_id)
   WHEN MATCHED
   THEN
      UPDATE SET dgl.valid_to = UP.valid_to;
      commit;
END load_dim_payment_systems;


PROCEDURE load_dim_times
AS
BEGIN
   sal_star.truncate_dim_times;
-- I should've used INSERT here, but merge doing the same and I wont write it again...
   MERGE INTO sal_star.dim_times dt
        USING (SELECT TRUNC (sd + rn) time_id,
                      TO_CHAR (sd + rn, 'fmDay') day_name,
                      TO_CHAR (sd + rn, 'D') day_number_in_week,
                      TO_CHAR (sd + rn, 'DD') day_number_in_month,
                      TO_CHAR (sd + rn, 'DDD') day_number_in_year,
                      TO_CHAR (sd + rn, 'W') calendar_week_number,
                      (CASE
                          WHEN TO_CHAR (sd + rn, 'D') IN (1, 2, 3, 4, 5, 6)
                          THEN
                             NEXT_DAY (sd + rn, 'Saturday')
                          ELSE
                             (sd + rn)
                       END)
                         week_ending_date,
                      TO_CHAR (sd + rn, 'MM') calendar_month_number,
                      TO_CHAR (LAST_DAY (sd + rn), 'DD') days_in_cal_month,
                      LAST_DAY (sd + rn) end_of_cal_month,
                      TO_CHAR (sd + rn, 'FMMonth') calendar_month_name,
                      ( (CASE
                            WHEN TO_CHAR (sd + rn, 'Q') = 1
                            THEN
                               TO_DATE (
                                  '03/31/' || TO_CHAR (sd + rn, 'YYYY'),
                                  'MM/DD/YYYY')
                            WHEN TO_CHAR (sd + rn, 'Q') = 2
                            THEN
                               TO_DATE (
                                  '06/30/' || TO_CHAR (sd + rn, 'YYYY'),
                                  'MM/DD/YYYY')
                            WHEN TO_CHAR (sd + rn, 'Q') = 3
                            THEN
                               TO_DATE (
                                  '09/30/' || TO_CHAR (sd + rn, 'YYYY'),
                                  'MM/DD/YYYY')
                            WHEN TO_CHAR (sd + rn, 'Q') = 4
                            THEN
                               TO_DATE (
                                  '12/31/' || TO_CHAR (sd + rn, 'YYYY'),
                                  'MM/DD/YYYY')
                         END)
                       - TRUNC (sd + rn, 'Q')
                       + 1)
                         days_in_cal_quarter,
                      TRUNC (sd + rn, 'Q') beg_of_cal_quarter,
                      (CASE
                          WHEN TO_CHAR (sd + rn, 'Q') = 1
                          THEN
                             TO_DATE ('03/31/' || TO_CHAR (sd + rn, 'YYYY'),
                                      'MM/DD/YYYY')
                          WHEN TO_CHAR (sd + rn, 'Q') = 2
                          THEN
                             TO_DATE ('06/30/' || TO_CHAR (sd + rn, 'YYYY'),
                                      'MM/DD/YYYY')
                          WHEN TO_CHAR (sd + rn, 'Q') = 3
                          THEN
                             TO_DATE ('09/30/' || TO_CHAR (sd + rn, 'YYYY'),
                                      'MM/DD/YYYY')
                          WHEN TO_CHAR (sd + rn, 'Q') = 4
                          THEN
                             TO_DATE ('12/31/' || TO_CHAR (sd + rn, 'YYYY'),
                                      'MM/DD/YYYY')
                       END)
                         end_of_cal_quarter,
                      TO_CHAR (sd + rn, 'Q') calendar_quarter_number,
                      TO_CHAR (sd + rn, 'YYYY') calendar_year,
                      (TO_DATE ('12/31/' || TO_CHAR (sd + rn, 'YYYY'),
                                'MM/DD/YYYY')
                       - TRUNC (sd + rn, 'YEAR'))
                         days_in_cal_year,
                      TRUNC (sd + rn, 'YEAR') beg_of_cal_year,
                      TO_DATE ('12/31/' || TO_CHAR (sd + rn, 'YYYY'),
                               'MM/DD/YYYY')
                         end_of_cal_year
                 FROM (    SELECT TO_DATE ('01/01/2010', 'MM/DD/YYYY') sd,
                                  ROWNUM rn
                             FROM DUAL
                       CONNECT BY LEVEL <= 1200)) dc
           ON (dt.time_id = dc.time_id)
   WHEN NOT MATCHED
   THEN
      INSERT            (TIME_ID,
                         DAY_NAME,
                         DAY_NUMBER_IN_WEEK,
                         DAY_NUMBER_IN_MONTH,
                         DAY_NUMBER_IN_YEAR,
                         CALENDAR_WEEK_NUMBER,
                         WEEK_ENDING_DATE,
                         CALENDAR_MONTH_NUMBER,
                         DAYS_IN_CAL_MONTH,
                         END_OF_CAL_MONTH,
                         CALENDAR_MONTH_NAME,
                         CALENDAR_QUARTER_NUMBER,
                         DAYS_IN_CAL_QUARTER,
                         BEG_OF_CALENDAR_QUARTER,
                         END_OF_CALENDAR_QUARTER,
                         CALENDAR_YEAR,
                         DAYS_IN_CAL_YEAR,
                         BEG_OF_CAL_YEAR,
                         END_OF_CAL_YEAR)
          VALUES (dc.TIME_ID,
                  dc.DAY_NAME,
                  dc.DAY_NUMBER_IN_WEEK,
                  dc.DAY_NUMBER_IN_MONTH,
                  dc.DAY_NUMBER_IN_YEAR,
                  dc.CALENDAR_WEEK_NUMBER,
                  dc.WEEK_ENDING_DATE,
                  dc.CALENDAR_MONTH_NUMBER,
                  dc.DAYS_IN_CAL_MONTH,
                  dc.END_OF_CAL_MONTH,
                  dc.CALENDAR_MONTH_NAME,
                  dc.CALENDAR_QUARTER_NUMBER,
                  dc.DAYS_IN_CAL_QUARTER,
                  dc.beg_of_cal_quarter,
                  dc.end_of_cal_quarter,
                  dc.CALENDAR_YEAR,
                  dc.DAYS_IN_CAL_YEAR,
                  dc.BEG_OF_CAL_YEAR,
                  dc.END_OF_CAL_YEAR);

   COMMIT;
END load_dim_times;



PROCEDURE load_dim_products
AS
BEGIN
merge into sal_star.dim_products dp
using (SELECT PROD_ID,
       PROD_CODE,
       PROD_DESC,
       prod_subcategories.PROD_SUBCATEGORY_ID,
       prod_subcategory AS PROD_SUBCATEGORY_CODE,
       PROD_SUBCATEGORY_DESC,
       prod_categories.PROD_CATEGORY_ID,
       prod_category AS PROD_CATEGORY_CODE,
       PROD_CATEGORY_DESC
  FROM products
       JOIN prod_subcategories
          ON products.prod_subcategory_id =
                prod_subcategories.prod_subcategory_id
       JOIN prod_categories
          ON prod_subcategories.prod_category_id =
                prod_categories.prod_category_id) std
                on (dp.prod_id = std.prod_id)
                when not matched then insert
                ( PROD_ID,
       PROD_CODE,
       PROD_DESC,
      PROD_SUBCATEGORY_ID,
       PROD_SUBCATEGORY_CODE,
       PROD_SUBCATEGORY_DESC,
       PROD_CATEGORY_ID,
       PROD_CATEGORY_CODE,
       PROD_CATEGORY_DESC, insert_dt)
       values  (std.PROD_ID,
       std.PROD_CODE,
       std.PROD_DESC,
      std.PROD_SUBCATEGORY_ID,
       std.PROD_SUBCATEGORY_CODE,
       std.PROD_SUBCATEGORY_DESC,
       std.PROD_CATEGORY_ID,
       std.PROD_CATEGORY_CODE,
       std.PROD_CATEGORY_DESC, sysdate)
       when matched then update
       set prod_code = std.prod_code, prod_desc = std.prod_desc;
   COMMIT;
END load_dim_products;


procedure load_dim_delivery_systems
as

begin
merge into sal_star.dim_delivery_systems dds using (select DELIVERY_SYSTEM_ID ,       
DELIVERY_SYSTEM_CODE      ,  
DELIVERY_SYSTEM_DESC   from delivery_systems) std
on (dds.DELIVERY_SYSTEM_ID = std.DELIVERY_SYSTEM_ID and dds.DELIVERY_SYSTEM_ID = std.DELIVERY_SYSTEM_ID)
when not matched then insert (
DELIVERY_SYSTEM_ID ,       
DELIVERY_SYSTEM_CODE      ,  
DELIVERY_SYSTEM_DESC , insert_dt)
values (STD.DELIVERY_SYSTEM_ID ,       
STD.DELIVERY_SYSTEM_CODE      ,  
STD.DELIVERY_SYSTEM_DESC , sysdate)
when matched then update
set DELIVERY_SYSTEM_DESC = std.DELIVERY_SYSTEM_DESC;
commit;
end load_dim_delivery_systems;


PROCEDURE load_fct_sales_dd
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
end pkg_load_sal_star;