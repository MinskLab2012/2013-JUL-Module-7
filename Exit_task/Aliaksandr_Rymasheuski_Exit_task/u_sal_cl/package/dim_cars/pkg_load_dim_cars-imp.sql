/* Formatted on 12.08.2013 18:51:33 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_dim_cars
AS
   PROCEDURE load_dim_cars
   AS
   BEGIN
      MERGE INTO u_str_data.dim_cars dc
           USING (SELECT cr.car_id
                       , cr.car_stand_number
                       , NVL ( br.brand_desc, 'not defined' ) AS brand_desc
                       , NVL ( md.model_desc, 'not defined' ) AS model_desc
                       , cr.color
                       , cr.year_of_production
                       , cr.date_of_purchase
                       , cr.cost
                       , cr.status
                    FROM u_dw.cars cr
                         LEFT JOIN u_dw.models md
                            ON ( cr.model_id = md.model_id )
                         LEFT JOIN u_dw.brands br
                            ON ( md.brand_id = br.brand_id )) dwc
              ON ( dc.car_id = dwc.car_id )
      WHEN NOT MATCHED THEN
         INSERT            ( dc.car_id
                           , dc.car_stand_num
                           , dc.brand
                           , dc.model
                           , dc.color
                           , dc.prod_year
                           , dc.purch_time
                           , dc.cost
                           , dc.status
                           , dc.insert_dt )
             VALUES ( dwc.car_id
                    , dwc.car_stand_number
                    , dwc.brand_desc
                    , dwc.model_desc
                    , dwc.color
                    , dwc.year_of_production
                    , dwc.date_of_purchase
                    , dwc.cost
                    , dwc.status
                    , SYSDATE )
      WHEN MATCHED THEN
         UPDATE SET dc.status    = dwc.status
                  , dc.model     = dwc.model_desc
                  , dc.brand     = dwc.brand_desc
                  , dc.color     = dwc.color
                  , dc.update_dt = SYSDATE
                 WHERE dc.status != dwc.status
                    OR  dc.model != dwc.model_desc
                    OR  dc.brand != dwc.brand_desc
                    OR  dc.color != dwc.color;

      COMMIT;
   END load_dim_cars;
END pkg_load_dim_cars;