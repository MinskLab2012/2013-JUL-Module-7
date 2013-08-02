--DROP TABLE gen_periods CASCADE CONSTRAINTS;

CREATE TABLE gen_periods
(
   period_code    VARCHAR2 ( 30 )
 , period_desc    VARCHAR2 ( 50 )
 , value_from_num NUMBER
 , value_to_num   NUMBER
 );  