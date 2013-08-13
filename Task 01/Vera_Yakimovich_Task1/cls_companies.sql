/* Formatted on 02.08.2013 21:11:31 (QP5 v5.139.911.3011) */
DROP TABLE  cls_companies;

CREATE TABLE cls_companies
(
   company_code   VARCHAR2 ( 20 )
 , company_name   VARCHAR2 ( 70 )
 , country_code   VARCHAR2 ( 20 )
 , country_desc   VARCHAR2 ( 70 )
 , comp_status_code VARCHAR ( 20 )
 , comp_status    VARCHAR2 ( 50 )
)
TABLESPACE ts_references_ext_data_01;


--companies

INSERT INTO cls_companies
   SELECT UPPER ( SUBSTR ( (   SUBSTR ( company_name
                                      , 1
                                      , 5 )
                            || SUBSTR ( company_name
                                      , -5
                                      , 5 )
                            || '_'
                            || ROWNUM )
                         , 1
                         , 20 ) )
        , company_name
        , country_code_a3
        , country_desc
        , UPPER ( ( SUBSTR ( comp_status
                           , 1
                           , 3 )
                   || SUBSTR ( comp_status
                             , -3
                             , 3 ) ) )
        , comp_status
     FROM (SELECT DISTINCT company_name
                         , country_desc
                         , country_code_a3
                         , 'subsidiary' AS comp_status
             FROM    (SELECT --+NO_MERGE
                            company_name
                           , ROUND ( dbms_random.VALUE ( 1
                                                       , 242 ) )
                                country_num
                        FROM ext_company
                           , (    SELECT ROWNUM
                                    FROM DUAL
                              CONNECT BY ROWNUM <= 15)) comp_t
                  INNER JOIN
                     (SELECT ROWNUM AS country_num
                           , country_desc
                           , country_code_a3
                        FROM (SELECT DISTINCT country_code_a3
                                            , country_desc
                                FROM u_dw_references.lc_countries)) coun_t
                  ON comp_t.country_num = coun_t.country_num);

COMMIT;

UPDATE cls_companies
   SET comp_status  = 'headquarters'
 WHERE company_code IN (SELECT comp
                          FROM (  SELECT company_name
                                       , MAX ( company_code ) AS comp
                                    FROM cls_companies
                                GROUP BY company_name));

UPDATE cls_companies
   SET comp_status_code = 'HAEERS'
 WHERE company_code IN (SELECT comp
                          FROM (  SELECT company_name
                                       , MAX ( company_code ) AS comp
                                    FROM cls_companies
                                GROUP BY company_name));



COMMIT;
