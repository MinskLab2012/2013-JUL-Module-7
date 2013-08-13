create or replace package body pkg_load_dim_ships
as
procedure load_dim_ships
as
cursor cur_c1 is
select st.ship_id, st.ship_code, st.weight, st.height, st.water_volume, st.max_cargo, dw.ship_id as ship from st.t_ships st  left join dw_star.dim_ships dw
on st.ship_id = dw.ship_id;

type ships_tab is table of cur_c1%rowtype;
teb ships_tab;

begin
open cur_c1;
fetch cur_c1 bulk collect into teb;
for i in teb.first..teb.last loop
if teb(i).ship is null
then 
insert into dw_star.dim_ships (ship_id, ship_code, ship_weight, ship_height, water_volume, max_cargo, last_insert_dt)
values (teb(i).ship_id, teb(i).ship_code, teb(i).weight, teb(i).height, teb(i).water_volume, teb(i).max_cargo, sysdate);
commit;
else 
update dw_star.dim_ships
set ship_code = teb(i).ship_code,
       ship_weight = teb(i).weight,
       ship_height = teb(i).height,
       water_volume = teb(i).water_volume,
       max_cargo = teb(i).max_cargo,
       last_update_dt = sysdate
       where ship_id = teb(i).ship_id and
       (ship_code = teb(i).ship_code or
       ship_weight = teb(i).weight or
       ship_height = teb(i).height or
       water_volume = teb(i).water_volume or
       max_cargo = teb(i).max_cargo);
       end if;
       end loop;
       commit;
       end load_dim_ships;
       end;
       
