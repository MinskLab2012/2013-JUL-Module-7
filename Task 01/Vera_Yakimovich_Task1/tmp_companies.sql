DROP TABLE  temp_companies;

CREATE TABLE temp_companies
(
   company_code   NUMBER ( 20 )
 , company_name   VARCHAR2 ( 70 )
 , country_desc   VARCHAR2 ( 70 )
 , comp_status    VARCHAR2 ( 50 )
)
TABLESPACE ts_references_ext_data_01;


--companies

INSERT INTO temp_companies
   SELECT ROWNUM
        , company_name
        , country_desc
        , comp_status
     FROM (SELECT DISTINCT company_name
                         , country_desc
                         , 'subsidiary' AS comp_status
             FROM    (SELECT --+NO_MERGE
                            company_name
                           , ROUND ( dbms_random.VALUE ( 1
                                                       , 241 ) )
                                country_num
                        FROM ext_company
                           , (    SELECT ROWNUM
                                    FROM DUAL
                              CONNECT BY ROWNUM <= 15)) comp_t
                  INNER JOIN
                     (SELECT ROWNUM AS country_num
                           , country_desc
                        FROM (SELECT country_id
                                   , country_desc
                                FROM u_dw_references.lc_countries)) coun_t
                  ON comp_t.country_num = coun_t.country_num);

COMMIT;

UPDATE temp_companies
   SET comp_status  = 'headquarters'
 WHERE company_code IN (SELECT comp
                          FROM (  SELECT company_name
                                       , MAX ( company_code ) AS comp
                                    FROM temp_companies
                                GROUP BY company_name));



COMMIT;