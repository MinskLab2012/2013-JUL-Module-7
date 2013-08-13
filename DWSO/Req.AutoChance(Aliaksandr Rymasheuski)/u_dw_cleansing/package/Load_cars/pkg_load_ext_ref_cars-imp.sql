/* Formatted on 8/6/2013 9:37:52 AM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_ext_ref_cars
AS
   --load brands (Merge)
   PROCEDURE load_brands
   AS
   BEGIN
      --Merge Source data
      MERGE INTO u_dw.brands br
           USING (  SELECT DISTINCT id AS brand_id
                                  , mark AS brand
                      FROM u_sa_data.tmp_brands
                  ORDER BY mark) cls
              ON ( br.brand_code = cls.brand_id )
      WHEN NOT MATCHED THEN
         INSERT            ( br.brand_id
                           , br.brand_code
                           , br.brand_desc
                           , br.insert_dt )
             VALUES ( u_dw.sq_brands_id.NEXTVAL
                    , cls.brand_id
                    , cls.brand
                    , SYSDATE )
      WHEN MATCHED THEN
         UPDATE SET br.brand_desc = cls.brand
                  , br.update_dt = SYSDATE
                 WHERE br.brand_desc != cls.brand;

      COMMIT;
   END load_brands;


   --load models(Explicit Cursor)
   PROCEDURE load_models
   AS
      CURSOR c1
      IS
         SELECT DISTINCT cn.id AS model_id
                       , br.brand_id
                       , cn.model
                       , omod.model_code
                       , omod.model_desc
           FROM u_sa_data.tmp_models cn
                JOIN u_dw.brands br
                   ON ( cn.mark_id = br.brand_code )
                LEFT JOIN u_dw.models omod
                   ON ( cn.id = omod.model_code );
   BEGIN
      FOR i IN c1 LOOP
         IF i.model_id = i.model_code THEN
            UPDATE u_dw.models md
               SET md.model_desc = i.model
                 , md.update_dt = SYSDATE
             WHERE i.model_id = md.model_code
               AND i.model != md.model_desc;
         ELSIF i.model_id != NVL ( i.model_code, -99 ) THEN
            INSERT INTO u_dw.models ( model_id
                                    , model_code
                                    , brand_id
                                    , model_desc
                                    , insert_dt )
                 VALUES ( u_dw.sq_models_id.NEXTVAL
                        , i.model_id
                        , i.brand_id
                        , i.model
                        , SYSDATE );
         END IF;
      END LOOP;

      COMMIT;
   END load_models;

   --load cars (Explicit Cursor and FORALL Bulk Insertion)
   PROCEDURE load_cars
   AS
      CURSOR c1 --dataset with brand new values, that we should insert
      IS
         SELECT DISTINCT cn.car_id
              , cn.cat_stand_num
              , md.model_id
              , cn.year_of_production
              , cn.color
              , cn.date_of_purchase
              , cn.country
              , cn.cost
              , cn.status
  FROM u_sa_data.tmp_cars cn JOIN u_dw.models md ON ( cn.model_id = md.model_code )
 WHERE ( cn.car_id, cn.cat_stand_num ) NOT IN (SELECT DISTINCT car_code
                                                             , car_stand_number
                                                 FROM u_dw.cars);

      CURSOR c2 --dataset with the same id, we should update if different desc
      IS
         ( SELECT DISTINCT car_id
                         , status
             FROM u_sa_data.tmp_cars
          MINUS
          SELECT DISTINCT car_code
                        , status
            FROM u_dw.cars );

      TYPE carset1 IS TABLE OF c1%ROWTYPE;

      TYPE carset2 IS TABLE OF c2%ROWTYPE;

      carcoll1       carset1; -- nested table of records
      carcoll2       carset2;
   BEGIN
      OPEN c1;



      FETCH c1
      BULK COLLECT INTO carcoll1;



      FORALL i IN INDICES OF carcoll1
         INSERT INTO u_dw.cars ( car_id
                               , car_code
                               , car_stand_number
                               , year_of_production
                               , model_id
                               , color
                               , date_of_purchase
                               , country
                               , cost
                               , status
                               , insert_dt )
              VALUES ( u_dw.sq_cars_id.NEXTVAL
                     , carcoll1 ( i ).car_id
                     , carcoll1 ( i ).cat_stand_num
                     , carcoll1 ( i ).year_of_production
                     , carcoll1 ( i ).model_id
                     , carcoll1 ( i ).color
                     , carcoll1 ( i ).date_of_purchase
                     , carcoll1 ( i ).country
                     , carcoll1 ( i ).cost
                     , carcoll1 ( i ).status
                     , SYSDATE );

      OPEN c2;

      FETCH c2
      BULK COLLECT INTO carcoll2;

      FORALL j IN INDICES OF carcoll2
         UPDATE u_dw.cars cr
            SET cr.status    = carcoll2 ( j ).status
              , cr.update_dt = SYSDATE
          WHERE carcoll2 ( j ).car_id = cr.car_code;

      COMMIT;
   END load_cars;
END pkg_load_ext_ref_cars;