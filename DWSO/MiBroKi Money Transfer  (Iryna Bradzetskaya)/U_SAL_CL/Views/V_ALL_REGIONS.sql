CREATE VIEW V_ALL_REGIONS AS SELECT geo.region_geo_id
              , NVL ( reg.src_continent_id, -99 ) AS src_continent_id
              , NVL ( reg.region_code, 'n.d.' ) AS region_code
              , NVL ( reg.region_desc, 'n.d.' ) AS region_desc
              , NVL ( geo.contenet_geo_id, -99 ) AS contenet_geo_id
              , NVL ( prt.part_id, -99 ) AS part_id
              , NVL ( prt.part_code, 'n.d.' ) AS part_code
              , NVL ( prt.part_desc, 'n.d.' ) AS part_desc
           FROM (  SELECT region_geo_id
                        , SUM ( contenet ) AS contenet_geo_id
                     FROM (    SELECT CONNECT_BY_ROOT ( child_geo_id ) AS region_geo_id
                                    , parent_geo_id
                                    , link_type_id
                                    , DECODE ( link_type_id, 2, parent_geo_id ) AS contenet
                                 FROM u_dw_references.w_geo_object_links
                           CONNECT BY PRIOR parent_geo_id = child_geo_id
                           START WITH child_geo_id IN (SELECT DISTINCT geo_id
                                                         FROM u_dw_references.cu_geo_regions))
                 GROUP BY region_geo_id) geo
                LEFT JOIN u_dw_references.cu_geo_regions reg
                   ON ( geo.region_geo_id = reg.geo_id )
                LEFT JOIN u_dw_references.cu_geo_parts prt
                   ON ( geo.contenet_geo_id = prt.geo_id );