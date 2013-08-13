DROP TABLE sales_dd_temp CASCADE CONSTRAINTS;
CREATE TABLE sales_dd_temp
(
   event_dt       DATE NOT NULL
 , periods_surr_id NUMBER ( 8 )
 , contract_number VARCHAR2 ( 50 )
 , car_id         NUMBER ( 20 )
 , geo_surr_id    NUMBER ( 20 )
 , ta_geo_id      NUMBER ( 20 )
 , cust_id        NUMBER ( 8 )
 , emp_surr_id    NUMBER ( 20 )
 , amount_sold    NUMBER ( 20 )
 , profit         NUMBER ( 20 )
 , insert_dt      DATE
);
