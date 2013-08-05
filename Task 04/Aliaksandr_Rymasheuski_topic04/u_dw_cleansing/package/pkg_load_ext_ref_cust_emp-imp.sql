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
         SELECT cc.customer_city
              , geo.geo_id
           FROM    (SELECT DISTINCT customer_city
                                  , customer_country
                      FROM u_sa_data.contracts
                    UNION
                    SELECT DISTINCT office_city
                                  , office_country
                      FROM u_sa_data.contracts) cc
                JOIN
                   (SELECT geo_id
                         , country_desc
                      FROM u_dw_references.lc_countries) geo
                ON ( cc.customer_country = geo.country_desc )
          WHERE cc.customer_city NOT IN (SELECT DISTINCT city_desc
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
         SELECT cc.customer_city
              , geo.geo_id
           FROM    (SELECT DISTINCT customer_city
                                  , customer_country
                      FROM u_sa_data.contracts
                    UNION
                    SELECT DISTINCT office_city
                                  , office_country
                      FROM u_sa_data.contracts) cc
                JOIN
                   (SELECT geo_id
                         , country_desc
                      FROM u_dw_references.lc_countries) geo
                ON ( cc.customer_country = geo.country_desc )
          WHERE cc.customer_city IN (SELECT DISTINCT city_desc
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