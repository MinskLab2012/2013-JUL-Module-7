CREATE TABLE tmp_methods
(
   operation_method_id NUMBER
 , operation_method_name VARCHAR2 ( 20 )
 , operation_method_type VARCHAR2 ( 20 )
 , operation_method_type_id NUMBER
);


INSERT INTO tmp_methods
     VALUES ( 1
            , 'Credit Cards'
            , 'bank transaction'
            , 1 );

INSERT INTO tmp_methods
     VALUES ( 2
            , 'Bank Transfer'
            , 'bank transaction'
            , 1 );

INSERT INTO tmp_methods
     VALUES ( 3
            , 'WEBMONEY'
            , 'web payment system'
            , 2 );

INSERT INTO tmp_methods
     VALUES ( 4
            , 'QIWI'
            , 'web payment system'
            , 2 );

INSERT INTO tmp_methods
     VALUES ( 5
            , 'EasyPay'
            , 'web payment system'
            , 2 );

INSERT INTO tmp_methods
     VALUES ( 6
            , 'Cash'
            , 'bank transaction'
            , 1 );

INSERT INTO tmp_methods
     VALUES ( 7
            , 'Direct Deposit'
            , 'bank transaction'
            , 1 );