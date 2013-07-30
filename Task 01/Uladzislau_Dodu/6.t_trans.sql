/* Formatted on 7/29/2013 7:10:46 PM (QP5 v5.139.911.3011) */
CREATE TABLE t_trans
(
   tran_id        DATE
 , ship_id        NUMBER ( 10 )
 , prod_id        NUMBER ( 10 )
 , ins_id         NUMBER ( 10 )
 , cust_id        NUMBER ( 10 )
 , ar_time        DATE
 , ar_port        NUMBER ( 10 )
 , dep_time       DATE
 , dep_port       NUMBER ( 10 )
 , ar_goods       NUMBER ( 10 )
 , dep_goods      NUMBER ( 10 )
);

truncate table t_trans

INSERT INTO t_trans
   SELECT TRUNC ( SYSDATE )
          - dbms_random.VALUE ( 1
                              , 5000 )
             tran_id
        , ROUND ( dbms_random.VALUE ( 1
                                    , 1000 ) )
          * 1000
             ship_id
        , ROUND ( dbms_random.VALUE ( 1
                                    , 72 ) )
             prod_id
        , ROUND ( dbms_random.VALUE ( 1
                                    , 1000 ) )
          * 1000
             ins_id
        , ROUND ( dbms_random.VALUE ( 1
                                    , 30597 ) )
             cust_id
        , SYSDATE
          - ROUND ( dbms_random.VALUE ( 1
                                      , 1000 ) )
             ar_time
        , ROUND ( dbms_random.VALUE ( 1
                                    , 30597 ) )
             ar_port
        , SYSDATE
          - ROUND ( dbms_random.VALUE ( 1
                                      , 1000 ) )
             dep_time
        , ROUND ( dbms_random.VALUE ( 1
                                    , 15000 ) )*2
             dep_port
        , dbms_random.VALUE ( 10000
                            , 20000 )
             ar_goods
        , dbms_random.VALUE ( 10000
                            , 18000 )
             dep_goods
     FROM (    SELECT ROWNUM
                 FROM DUAL
           CONNECT BY ROWNUM <= 1000000);

COMMIT;

