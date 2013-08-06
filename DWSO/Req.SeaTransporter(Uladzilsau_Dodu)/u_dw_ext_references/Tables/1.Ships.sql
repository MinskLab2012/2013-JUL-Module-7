/* Formatted on 7/29/2013 1:11:13 PM (QP5 v5.139.911.3011) */
CREATE TABLE ext_ship
AS
   SELECT *
     FROM (    SELECT ROWNUM * 1000 ship_unique_identifier
                    , ROUND ( dbms_random.VALUE ( 1000
                                                , 20000 ) )
                         weight
                    , ROUND ( dbms_random.VALUE ( 50
                                                , 200 ) )
                         height
                    , ROUND ( dbms_random.VALUE ( 5000
                                                , 10000 ) )
                         water_volume
                    , ROUND ( dbms_random.VALUE ( 5000
                                                , 20000 ) )
                         max_cargo
                 FROM DUAL
           CONNECT BY ROWNUM <= 1000)