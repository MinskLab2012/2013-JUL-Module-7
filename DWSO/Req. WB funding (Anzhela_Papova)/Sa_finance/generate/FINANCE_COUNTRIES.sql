---DROP TABLE finance_countries CASCADE CONSTRAINTS PURGE;

CREATE TABLE finance_countries
(
   year           VARCHAR2 ( 4 )
 , month          VARCHAR2 ( 30 )
 , country        VARCHAR2 ( 100 )
 , grp            VARCHAR2 ( 2 )
 , fin_item_id    NUMBER
 , amount         NUMBER
);

BEGIN
   FOR c IN 1 .. 100 LOOP
      dbms_random.initialize ( c * 2 );

      INSERT INTO finance_countries
         SELECT DISTINCT ROUND ( dbms_random.VALUE ( 1995
                                                   , 2012 ) )
                            AS year
                       , TO_CHAR ( sd + rn
                                 , 'FMMonth' )
                            AS month
                       , cntr.country_name AS country
                       , 'R' AS grp
                       , ROUND ( dbms_random.VALUE ( 1
                                                   , 6 ) )
                            AS fin_item_id
                       , ROUND ( dbms_random.VALUE ( 10000
                                                   , 50000 ) )
                            AS amount
           FROM hr.countries cntr
              , (    SELECT TO_DATE ( '12/31/1995'
                                    , 'MM/DD/YYYY' )
                               sd
                          , ROWNUM rn
                       FROM DUAL
                 CONNECT BY LEVEL <= 2100)
         UNION ALL
         SELECT DISTINCT ROUND ( dbms_random.VALUE ( 1995
                                                   , 2012 ) )
                            AS year
                       , TO_CHAR ( sd + rn
                                 , 'FMMonth' )
                            AS month
                       , cntr.country_name AS country
                       , 'E' AS grp
                       , ROUND ( dbms_random.VALUE ( 7
                                                   , 11 ) )
                            AS fin_item_id
                       , ROUND ( dbms_random.VALUE ( 10000
                                                   , 50000 ) )
                            AS amount
           FROM hr.countries cntr
              , (    SELECT TO_DATE ( '12/31/1995'
                                    , 'MM/DD/YYYY' )
                               sd
                          , ROWNUM rn
                       FROM DUAL
                 CONNECT BY LEVEL <= 2100);

      COMMIT;
   END LOOP;
END;