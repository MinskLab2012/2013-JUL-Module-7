
DROP TABLE cls_periods CASCADE CONSTRAINT;

--==============================================================
-- Table: T_PERIODS
--==============================================================

CREATE TABLE cls_periods
(
   period_code    VARCHAR2 ( 150 )
 , period_desc    VARCHAR2 ( 500 )
 , period_type_name VARCHAR2 ( 150 )
 , period_type_desc VARCHAR2 ( 50 )
 , start_dt       DATE
 , end_dt         DATE
)