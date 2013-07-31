/* Formatted on 7/30/2013 9:22:25 PM (QP5 v5.139.911.3011) */
CREATE TABLE suppliers
AS
   SELECT ROWNUM suppl_id
        , cu.des
        , cu.phone_number
        , cu.mail
        , pr.prod_category
        , cu.country_name
        , cu.geo_id
     FROM    (SELECT des
                   , phone_number
                   , cust_email mail
                   , ROUND ( dbms_random.VALUE ( 1
                                               , 5 ) )
                        cat
                   , country_name
                   , geo_id
                FROM (SELECT DISTINCT *
                        FROM (SELECT e.first_name || cu.cust_last_name || ' ' || 'Ltd' des
                                   , e.phone_number
                                   , cu.cust_email
                                   , cu.country_name
                                   , co.geo_id
                                FROM employees e
                                     JOIN cust cu
                                        ON cu.cust_last_name = e.last_name
                                     JOIN u_dw_references.lc_countries co
                                        ON co.country_desc = cu.country_name))) cu
          JOIN
             (SELECT ROWNUM nu
                   , prod_category
                FROM (SELECT DISTINCT prod_category
                        FROM prod)) pr
          ON pr.nu = cu.cat;