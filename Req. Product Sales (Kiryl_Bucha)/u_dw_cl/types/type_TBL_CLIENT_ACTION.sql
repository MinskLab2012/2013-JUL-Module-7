
CREATE OR REPLACE TYPE r_client_action AS OBJECT
   ( event_dt DATE
   , cnt_opers NUMBER
   , country_id NUMBER
   , client_id NUMBER );
   
CREATE OR REPLACE TYPE  tbl_client_action is table of r_client_action;