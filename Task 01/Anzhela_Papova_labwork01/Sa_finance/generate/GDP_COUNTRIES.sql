--DROP TABLE gdp_countries CASCADE CONSTRAINTS;

CREATE TABLE gdp_countries
(
   year           VARCHAR2 ( 4 )
 , month          VARCHAR2 ( 30 )
 , country        VARCHAR2 ( 100 )
 , gdp            NUMBER
);

BEGIN
   FOR c IN 1 .. 100 LOOP
      dbms_random.initialize ( c * 2 );

      INSERT INTO gdp_countries
         SELECT DISTINCT ROUND ( dbms_random.VALUE ( 1995
                                                   , 2012 ) )
                            AS year
                       , TO_CHAR ( sd + rn
                                 , 'FMMonth' )
                            AS month
                       , cntr.country_name AS country
                       , ROUND ( dbms_random.VALUE ( 80000
                                                   , 150000 ) )
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