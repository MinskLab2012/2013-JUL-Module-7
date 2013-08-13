
DROP TABLE temp_periods;

CREATE TABLE temp_periods
(
   period_desc    VARCHAR2 ( 500 ) NOT NULL
 , period_code    VARCHAR2 ( 50 ) NOT NULL
 , start_dt       DATE NOT NULL
 , end_dt         DATE NOT NULL
 , period_type_desc VARCHAR2 ( 50 ) NOT NULL
 , period_type_name VARCHAR2 ( 150 ) NOT NULL
);

INSERT INTO temp_periods
     VALUES ( 'Period A'
            , 'A'
            , TO_DATE ( '15.01.2012'
                      , 'DD.MM.YYYY' )
            , TO_DATE ( '15.05.2012'
                      , 'DD.MM.YYYY' )
            , 'Main period'
            , 'Main' );

INSERT INTO temp_periods
     VALUES ( 'Period B'
            , 'B'
            , TO_DATE ( '16.05.2012'
                      , 'DD.MM.YYYY' )
            , TO_DATE ( '25.05.2012'
                      , 'DD.MM.YYYY' )
            , 'Main period'
            , 'Main' );

INSERT INTO temp_periods
     VALUES ( 'Period C'
            , 'C'
            , TO_DATE ( '26.05.2012'
                      , 'DD.MM.YYYY' )
            , TO_DATE ( '15.09.2012'
                      , 'DD.MM.YYYY' )
            , 'Main period'
            , 'Main' );

INSERT INTO temp_periods
     VALUES ( 'Period D'
            , 'D'
            , TO_DATE ( '16.09.2012'
                      , 'DD.MM.YYYY' )
            , TO_DATE ( '15.12.2012'
                      , 'DD.MM.YYYY' )
            , 'Main period'
            , 'Main' );

INSERT INTO temp_periods
     VALUES ( 'Period E'
            , 'E'
            , TO_DATE ( '16.12.2012'
                      , 'DD.MM.YYYY' )
            , TO_DATE ( '31.12.2012'
                      , 'DD.MM.YYYY' )
            , 'Main period'
            , 'Main' );

COMMIT;