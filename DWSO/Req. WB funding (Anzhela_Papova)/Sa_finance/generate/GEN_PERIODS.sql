--DROP TABLE gen_periods CASCADE CONSTRAINTS;

CREATE TABLE gen_periods
(
   period_id      NUMBER
 , period_code    VARCHAR2 ( 30 )
 , period_desc    VARCHAR2 ( 50 )
 , value_from_num NUMBER
 , value_to_num   NUMBER
 , value_from_dt  DATE
 , value_to_dt    DATE
 , value_from_char VARCHAR2 ( 20 )
 , value_to_char  VARCHAR2 ( 20 )
 , level_code     VARCHAR2 ( 20 )
);  