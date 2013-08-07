
UPDATE u_dw_ext_references.cls_operations
   SET total_price_dol = total_price_dol / 2
 WHERE restaurant_code IN (SELECT DISTINCT rest.restaurant_code
                             FROM    u_dw_ext_references.cls_operations oper
                                  LEFT JOIN
                                     u_dw_ext_references.cls_restaurants rest
                                  ON rest.restaurant_code = oper.restaurant_code
                            WHERE rest.restaurant_country_name = 'Germany'
                              AND rest.restaurant_city = 'Chemnitz');