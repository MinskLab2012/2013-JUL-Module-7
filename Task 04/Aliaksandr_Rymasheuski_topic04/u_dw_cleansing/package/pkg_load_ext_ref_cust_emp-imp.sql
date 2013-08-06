/* Formatted on 8/6/2013 9:32:56 AM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_ext_ref_cust_emp
AS
   --load cities (Variable Cursor and FORALL Bulk Insertion )
   PROCEDURE load_cities
   AS
      TYPE cityrectyp IS RECORD
   (
      customer_city  VARCHAR2 ( 50 )
    , geo_id         NUMBER ( 22 )
   );

      city_cv        SYS_REFCURSOR;

      TYPE cityset IS TABLE OF cityrectyp;

      citycoll1      cityset;
      citycoll2      cityset;
   BEGIN
      OPEN city_cv FOR --dataset with brand new cities (should insert)
         SELECT DISTINCT cc.capital AS customer_city
                       , geo.geo_id
           FROM    u_sa_data.tmp_countries_city cc
                JOIN
                   (SELECT geo_id
                         , country_desc
                      FROM u_dw_references.lc_countries) geo
                ON ( cc.country = geo.country_desc )
          WHERE cc.capital NOT IN (SELECT DISTINCT city_desc
                                     FROM u_dw.cities);

      FETCH city_cv
      BULK COLLECT INTO citycoll1;

      FORALL i IN INDICES OF citycoll1
         INSERT INTO u_dw.cities ( city_id
                                 , city_desc
                                 , country_geo_id
                                 , insert_dt )
              VALUES ( u_dw.sq_cities_id.NEXTVAL
                     , citycoll1 ( i ).customer_city
                     , citycoll1 ( i ).geo_id
                     , SYSDATE );

      OPEN city_cv FOR --dataset with the same cities names (should  update if geo_id was changed)
         SELECT DISTINCT cc.capital AS customer_city
                       , geo.geo_id
           FROM    u_sa_data.tmp_countries_city cc
                JOIN
                   (SELECT geo_id
                         , country_desc
                      FROM u_dw_references.lc_countries) geo
                ON ( cc.country = geo.country_desc )
          WHERE cc.capital IN (SELECT DISTINCT city_desc
                                 FROM u_dw.cities);

      FETCH city_cv
      BULK COLLECT INTO citycoll2;



      FORALL j IN INDICES OF citycoll2
         UPDATE u_dw.cities ct
            SET ct.country_geo_id = citycoll2 ( j ).geo_id
              , ct.update_dt = SYSDATE
          WHERE citycoll2 ( j ).geo_id != ct.country_geo_id
            AND citycoll2 ( j ).customer_city = ct.city_desc;

      COMMIT;
   END load_cities;

  END pkg_load_ext_ref_cust_emp;