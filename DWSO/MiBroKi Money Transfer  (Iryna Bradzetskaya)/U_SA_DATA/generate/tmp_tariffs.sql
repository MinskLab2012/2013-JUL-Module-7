CREATE TABLE tmp_tariffs
(
   tariff_code    VARCHAR2 ( 5 )
 , tariff_name    VARCHAR2 ( 20 )
 , tariff_type    VARCHAR2 ( 30 )
 , tariff_payment_sum NUMBER
 , tariff_min_payment NUMBER
 , tariff_max_payment NUMBER
);



INSERT INTO tmp_tariffs
     VALUES ( 'IMT'
            , 'Major Transfer'
            , 'International Transfer'
            , 15
            , 75000
            , 100000 );

INSERT INTO tmp_tariffs
     VALUES ( 'ITT'
            , 'Temperate Transfer'
            , 'International Transfer'
            , 12
            , 10000
            , 74999 );

INSERT INTO tmp_tariffs
     VALUES ( 'ITS'
            , 'Small Transfer'
            , 'International Transfer'
            , 10
            , 50
            , 9999 );

INSERT INTO tmp_tariffs
     VALUES ( 'LMT'
            , 'Major Transfer'
            , 'Local Transfer'
            , 10
            , 75000
            , 100000 );

INSERT INTO tmp_tariffs
     VALUES ( 'LTT'
            , 'Temperate Transfer'
            , 'Local Transfer'
            , 9
            , 10000
            , 74999 );

INSERT INTO tmp_tariffs
     VALUES ( 'LTS'
            , 'Small Transfer'
            , 'Local Transfer'
            , 8
            , 50
            , 9999 );


  INSERT INTO tmp_tariffs
     VALUES ( 'DPS'
            , 'DEPOSIT'
            , 'DEPOSIT'
            , 0
            , 10
            , 1000000 );
            
            
            INSERT INTO tmp_tariffs
     VALUES ( 'WDW'
            , 'WITHDRAWAL'
            , 'WITHDRAWAL'
            , 0
            , 10
            , 1000000 );