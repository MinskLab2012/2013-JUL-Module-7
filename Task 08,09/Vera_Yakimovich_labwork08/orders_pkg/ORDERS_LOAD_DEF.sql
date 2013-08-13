/* Formatted on 12.08.2013 6:38:52 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE pkg_orders_load
AS
   PROCEDURE orders_load;

   PROCEDURE order_items_load;
END pkg_orders_load;
/