/* Formatted on 12.08.2013 13:21:57 (QP5 v5.139.911.3011) */
BEGIN
   --Transport Countries
   pkg_load_ext_ref_geography.load_cls_languages_alpha3;
   pkg_load_ext_ref_geography.load_cls_languages_alpha2;
   pkg_load_ext_ref_geography.load_ref_geo_countries;
   --Cleansing
   pkg_load_ext_ref_geography.load_cls_geo_structure;
   pkg_load_ext_ref_geography.load_cls_geo_structure2cntr;
   --Geo Data
   pkg_load_ext_ref_geography.load_ref_geo_parts;
   pkg_load_ext_ref_geography.load_ref_geo_regions;
   --Transport Links
   pkg_load_ext_ref_geography.load_lnk_geo_structure;
   pkg_load_ext_ref_geography.load_lnk_geo_countries;
   --Product Categireis
   prod_load.prod_categ_load;
   prod_load.measure_load;
   prod_load.ins_upd;
   --Customer Data
   customers_load.stat_load;
   customers_load.ins_upd;
   --Orders and Orders Items
   pkg_orders_load.orders_load;
   pkg_orders_load.order_items_load;
END;