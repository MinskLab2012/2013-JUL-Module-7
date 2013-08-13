CREATE TABLE tmp_operations
(
   operation_id   NUMBER
 , operation_name VARCHAR2 ( 20 )
 , operation_max_amount NUMBER
 , operation_min_amount NUMBER
);

INSERT INTO tmp_operations
     VALUES ( 1
            , 'DEPOSIT'
            , 1000000
            , 10 );


INSERT INTO tmp_operations
     VALUES ( 1
            , 'WITHDRAWAL'
            , 1000000
            , 10 );


INSERT INTO tmp_operations
     VALUES ( 1
            , 'TRANSFER'
            , 100000
            , 50 );