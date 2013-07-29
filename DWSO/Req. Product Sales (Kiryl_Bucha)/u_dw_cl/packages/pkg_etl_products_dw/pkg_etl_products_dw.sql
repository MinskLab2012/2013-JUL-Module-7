CREATE OR REPLACE PACKAGE u_dw_cl.pkg_etl_products_dw
AS
   PROCEDURE load_cls_product_brands;

   PROCEDURE load_dw_product_brands;

   PROCEDURE load_cls_product_groups;

   PROCEDURE load_dw_product_groups;

   PROCEDURE load_cls_product_links;

   PROCEDURE load_dw_products;

   PROCEDURE load_dw_product_links;
END pkg_etl_products_dw;
/