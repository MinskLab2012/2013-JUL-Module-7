create or replace procedure load_dim_delivery_systems
as

begin
merge into sal_star.dim_delivery_systems dds using (select DELIVERY_SYSTEM_ID ,       
DELIVERY_SYSTEM_CODE      ,  
DELIVERY_SYSTEM_DESC   from delivery_systems) std
on (dds.DELIVERY_SYSTEM_ID = std.DELIVERY_SYSTEM_ID and dds.DELIVERY_SYSTEM_ID = std.DELIVERY_SYSTEM_ID)
when not matched then insert (
DELIVERY_SYSTEM_ID ,       
DELIVERY_SYSTEM_CODE      ,  
DELIVERY_SYSTEM_DESC , insert_dt)
values (STD.DELIVERY_SYSTEM_ID ,       
STD.DELIVERY_SYSTEM_CODE      ,  
STD.DELIVERY_SYSTEM_DESC , sysdate)
when matched then update
set DELIVERY_SYSTEM_DESC = std.DELIVERY_SYSTEM_DESC;
commit;
end load_dim_delivery_systems;

begin
load_dim_delivery_systems;
end;