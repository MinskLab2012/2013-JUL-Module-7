/* Formatted on 7/29/2013 12:13:55 PM (QP5 v5.139.911.3011) */
CREATE TABLE u_dw_ext_references.t_ext_payment_systems
(
   payment_system_id NUMBER ( 10, 0 )
 , payment_system_desc VARCHAR2 ( 200 )
 , payment_system_type VARCHAR2 ( 100 )
)
organization external
(
type oracle_loader
default directory ext_references
access parameters (records delimited by 0x'0D0A' 
    nobadfile nodiscardfile nologfile fields terminated by ',' missing field values are NULL (  payment_system_id char (4), payment_system_desc char( 200 ) , payment_system_type char( 100 )) )
    location ('payment_systems_source.csv')
)
reject limit unlimited;

drop table t_ext_payment_systems purge;

create table cls_payment_systems as 
select * from u_dw_ext_references.t_ext_payment_systems;