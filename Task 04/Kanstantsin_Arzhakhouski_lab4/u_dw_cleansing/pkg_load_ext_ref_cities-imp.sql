/* Formatted on 8/13/2013 12:54:28 PM (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_ext_ref_cities
AS
   PROCEDURE load_cities
   AS
      TYPE arectype IS RECORD
   (
      load_city      VARCHAR2 ( 50 )
    , geo_id         NUMBER ( 22 )
   );

      city_cv        SYS_REFCURSOR;

      TYPE citiesset IS TABLE OF arectype;

      acitiescol     citiesset;
      bcitiescol     citiesset;
   BEGIN
      OPEN city_cv FOR
         SELECT DISTINCT cc.capital AS load_city
                       , geo.geo_id
           FROM    u_sa_data.tmp_capitals cc
                JOIN
                   (SELECT geo_id
                         , country_desc
                      FROM u_dw_references.lc_countries) geo
                ON ( cc.country = geo.country_desc )
          WHERE cc.capital NOT IN (SELECT DISTINCT city_desc
                                     FROM u_dw.t_cities);

      FETCH city_cv
      BULK COLLECT INTO acitiescol;

      FORALL i IN INDICES OF acitiescol
         INSERT INTO u_dw.t_cities ( city_id
                                   , city_desc
                                   , geo_id
                                   , insert_dt )
              VALUES ( u_dw.sq_city_id.NEXTVAL
                     , acitiescol ( i ).load_city
                     , acitiescol ( i ).geo_id
                     , SYSDATE );

      OPEN city_cv FOR
         SELECT DISTINCT cc.capital AS load_city
                       , geo.geo_id
           FROM    u_sa_data.tmp_capitals cc
                JOIN
                   (SELECT geo_id
                         , country_desc
                      FROM u_dw_references.lc_countries) geo
                ON ( cc.country = geo.country_desc )
          WHERE cc.capital IN (SELECT DISTINCT city_desc
                                 FROM u_dw.t_cities);

      FETCH city_cv
      BULK COLLECT INTO bcitiescol;



      FORALL j IN INDICES OF bcitiescol
         UPDATE u_dw.t_cities ct
            SET ct.geo_id    = bcitiescol ( j ).geo_id
              , ct.update_dt = SYSDATE
          WHERE bcitiescol ( j ).geo_id != ct.geo_id
            AND bcitiescol ( j ).load_city = ct.city_desc;

      COMMIT;
   END load_cities;
END pkg_load_ext_ref_cities;