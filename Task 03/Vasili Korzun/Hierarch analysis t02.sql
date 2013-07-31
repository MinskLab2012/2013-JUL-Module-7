/* Formatted on 7/31/2013 2:03:31 PM (QP5 v5.139.911.3011) */
/*
I ran this script in U_DW_EXT_REFERENCES schema. Here are grants needed to execute query:
grant select on lc_geo_regions to t_geo_object_links;
grant select on lc_geo_regions to u_dw_ext_references;
grant select on lc_countries to u_dw_ext_references;
*/

SELECT DECODE ( gid,  1, 'Total for ' || country,  3, 'GRAND TOTAL',  country ) AS country
     , DECODE ( gid, 2, 'Total for ' || delivery_system_desc, delivery_system_desc ) AS delivery_system_desc
     , amount_sold
     , cnt
  FROM (  SELECT GROUPING_ID ( country
                             , delivery_system_desc )
                    AS gid
               , country
               , delivery_system_desc
               , SUM ( cost ) AS amount_sold
               , COUNT ( cost ) AS cnt
            FROM    (SELECT country_desc
                       FROM    (    SELECT child_geo_id AS geo_id
                                      FROM u_dw_references.t_geo_object_links
                                CONNECT BY PRIOR child_geo_id = parent_geo_id
                                START WITH parent_geo_id IN (SELECT geo_id
                                                               FROM u_dw_references.lc_geo_regions
                                                              WHERE region_desc = :p_region_desc -- Northern America
                                                                                                )) selected_countries
                            LEFT JOIN
                               u_dw_references.lc_countries
                            ON selected_countries.geo_id = lc_countries.geo_id)
                 LEFT JOIN
                    tmp_orders
                 ON country_desc = country
        GROUP BY CUBE ( country, delivery_system_desc )
        ORDER BY country ASC
               , gid ASC
               , amount_sold DESC);