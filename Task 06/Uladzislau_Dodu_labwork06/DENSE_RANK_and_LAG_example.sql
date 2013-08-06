/* Formatted on 8/6/2013 2:11:36 PM (QP5 v5.139.911.3011) */
SELECT DISTINCT company_name companies_with_same_names
  FROM (SELECT company_name
             , cust_city
             , RANK
             , LAG ( RANK
                   , 1
                   , 0 )
               OVER (ORDER BY company_name)
                  LAG
          FROM (  SELECT DISTINCT company_name
                                , cust_city
                                , DENSE_RANK ( ) OVER (ORDER BY company_name) RANK
                    FROM u_dw_ext_references.agr_trans
                ORDER BY 1))
 WHERE RANK = LAG;