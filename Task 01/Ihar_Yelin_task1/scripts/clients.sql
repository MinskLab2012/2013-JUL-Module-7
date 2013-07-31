/* Formatted on 7/30/2013 9:24:46 PM (QP5 v5.139.911.3011) */
CREATE TABLE clients
AS
   SELECT cu.cust_id
        , cu.cust_first_name
        , cu.cust_last_name
        , cu.cust_gender
        , cu.cust_street_address
        , cu.cust_postal_code
        , cu.cust_city
        , cu.cust_main_phone_number
        , cu.cust_email
        , cu.cust_credit_limit
        , cu.country_name
        , co.geo_id
     FROM cust cu JOIN u_dw_references.lc_countries co ON co.country_desc = cu.country_name;