/* Formatted on 7/29/2013 12:45:22 PM (QP5 v5.139.911.3011) */
-- DROP TABLE t_ext_delivery_systems PURGE;
CREATE TABLE u_dw_ext_references.t_ext_delivery_systems
(
   delivery_system_id NUMBER ( 10, 0 )
   , delivery_system_code VARCHAR2 ( 100 )
   , delivery_system_desc VARCHAR2 ( 200 )
)
organization external
(
type oracle_loader
default directory ext_references
access parameters (records delimited by 0x'0D0A' 
    nobadfile nodiscardfile nologfile fields terminated by ',' missing field values are NULL (    delivery_system_id char(4), delivery_system_code CHAR ( 100 ), delivery_system_desc CHAR ( 200 )))
    location ('delivery_systems_source.csv')
)
reject limit unlimited;



--SELECT *
 -- FROM t_ext_delivery_systems;
  
create table cls_delivery_systems as 
select * from t_ext_delivery_systems;