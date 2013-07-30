/* Formatted on 7/29/2013 1:58:24 PM (QP5 v5.139.911.3011) */
CREATE TABLE tmp_currency
(
   currency_code  NUMBER
 , currency_name  VARCHAR2 ( 5 )
 , currency_desc  VARCHAR2 ( 50 )
 , currency_to_dollar NUMBER
 , currency_type_name VARCHAR2 ( 50 )
 , currency_type_id NUMBER
);

INSERT INTO tmp_currency
     VALUES ( 840
            , 'USD'
            , 'United States dollar'
            , 1
            , 'CONVERTIBLE'
            , 1 );

INSERT INTO tmp_currency
     VALUES ( 978
            , 'EUR'
            , 'Euro'
            , 1.33
            , 'CONVERTIBLE'
            , 1 );

INSERT INTO tmp_currency
     VALUES ( 392
            , 'JPY'
            , 'Japanese Yen'
            , 98.79
            , 'CONVERTIBLE'
            , 1 );

INSERT INTO tmp_currency
     VALUES ( 826
            , 'GBP'
            , 'Pound sterling'
            , 1.538
            , 'CONVERTIBLE'
            , 1 );

INSERT INTO tmp_currency
     VALUES ( 756
            , 'CHF'
            , 'Swiss franc'
            , 1.076
            , 'CONVERTIBLE'
            , 1 );

INSERT INTO tmp_currency
     VALUES ( 124
            , 'CAD'
            , 'Canadian dollar'
            , 1.027
            , 'CONVERTIBLE'
            , 1 );

INSERT INTO tmp_currency
     VALUES ( 36
            , 'AUD'
            , 'Australian Dollar '
            , 1.08
            , 'CONVERTIBLE'
            , 1 );

INSERT INTO tmp_currency
     VALUES ( 554
            , 'NZD'
            , 'New Zealand Dollar'
            , 0.808
            , 'NOT CONVERTABLE'
            , 2 );



COMMIT;