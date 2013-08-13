/* Formatted on 12.08.2013 13:26:14 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE BODY pkg_load_dim_customers
AS
   PROCEDURE load_dim_customers
   AS
      TYPE custrectyp IS RECORD
   (
      cust_id        NUMBER ( 8 )
    , passport_number VARCHAR2 ( 60 )
    , first_name     VARCHAR2 ( 60 )
    , last_name      VARCHAR2 ( 60 )
    , country        VARCHAR2 ( 60 )
    , city           VARCHAR2 ( 60 )
    , adress         VARCHAR2 ( 60 )
    , gender         VARCHAR2 ( 20 )
   );

      cust_cv        SYS_REFCURSOR;

      TYPE custset IS TABLE OF custrectyp;

      custcoll       custset;
   BEGIN
      OPEN cust_cv FOR
         SELECT cust.cust_id
              , cust.passport_number
              , cust.first_name
              , cust.last_name
              , NVL ( cc.region_desc, 'not defined' ) AS country
              , NVL ( ct.city_desc, 'not defined' ) AS city
              , cust.adress
              , cust.gender
           FROM u_dw.customers cust
                LEFT JOIN u_dw.cities ct
                   ON ( cust.city_id = ct.city_id )
                LEFT JOIN u_dw_references.cu_countries cc
                   ON ( ct.country_geo_id = cc.geo_id )
          WHERE cust.cust_id NOT IN (SELECT DISTINCT cust_id
                                       FROM u_str_data.dim_customers);

      FETCH cust_cv
      BULK COLLECT INTO custcoll;

      FORALL i IN INDICES OF custcoll
         INSERT INTO u_str_data.dim_customers
              VALUES ( custcoll ( i ).cust_id
                     , custcoll ( i ).passport_number
                     , custcoll ( i ).first_name
                     , custcoll ( i ).last_name
                     , custcoll ( i ).country
                     , custcoll ( i ).city
                     , custcoll ( i ).adress
                     , custcoll ( i ).gender
                     , SYSDATE
                     , NULL );

      COMMIT;

      OPEN cust_cv FOR
         SELECT cust.cust_id
              , cust.passport_number
              , cust.first_name
              , cust.last_name
              , NVL ( cc.region_desc, 'not defined' ) AS country
              , NVL ( ct.city_desc, 'not defined' ) AS city
              , cust.adress
              , cust.gender
           FROM u_dw.customers cust
                LEFT JOIN u_dw.cities ct
                   ON ( cust.city_id = ct.city_id )
                LEFT JOIN u_dw_references.cu_countries cc
                   ON ( ct.country_geo_id = cc.geo_id )
         MINUS
         SELECT cust_id
              , passport_number
              , first_name
              , last_name
              , country
              , city
              , adress
              , gender
           FROM u_str_data.dim_customers;

      FETCH cust_cv
      BULK COLLECT INTO custcoll;

      FORALL i IN INDICES OF custcoll
         UPDATE u_str_data.dim_customers
            SET passport_number = custcoll ( i ).passport_number
              , first_name   = custcoll ( i ).first_name
              , last_name    = custcoll ( i ).last_name
              , country      = custcoll ( i ).country
              , city         = custcoll ( i ).city
              , adress       = custcoll ( i ).adress
              , gender       = custcoll ( i ).gender
              , update_dt    = SYSDATE
          WHERE cust_id = custcoll ( i ).cust_id;

      COMMIT;
   END load_dim_customers;
END pkg_load_dim_customers;