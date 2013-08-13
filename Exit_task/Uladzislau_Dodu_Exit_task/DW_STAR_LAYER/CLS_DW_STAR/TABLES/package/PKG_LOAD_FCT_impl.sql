create or replace package body pkg_load_FCT
as
procedure LOAD_FCT_200X(year in date, var_par in varchar2)
as
stmt varchar2(500);
stmt1 varchar2(500);
stmt2 varchar2 (500);
begin
insert into fct_trans_monthly_2008
(select tr.*, sysdate, null from (select trunc(tr.tran_id,'MM'), tr.ship_id, tr.ar_time, tr.ar_port_id, tr.dep_time, tr.dep_port_id, tr.customer_id,tr.prod_id,  tr.insurance_id, avg(round(tr.dep_goods/tr.ar_goods*100,2)),sum( t.income_coef*dep_goods), count(tr.dep_goods)
from st.t_trans tr join st.t_products t
on tr.prod_id = t.prod_id
where trunc(tr.tran_id,'YYYY') = year
group by trunc(tr.tran_id,'MM'), tr.ship_id, tr.ar_time, tr.ar_port_id, tr.dep_time, tr.dep_port_id, tr.customer_id,tr.prod_id,  tr.insurance_id) tr
minus
select event_dt, ship_id, arr_time_dt, arr_port_id, dep_time_dt, dep_port_id, company_id, product_id, insurance_id, pct_goods, income, amount_tot, sysdate, null  from fct_trans_monthly_2008);
commit;
begin
stmt1 := 'alter table  dw_star.fct_trans_monthly exchange partition ';
stmt2 := ' with table  fct_trans_monthly_2008 without validation';
stmt := stmt1||var_par||stmt2;
execute immediate stmt;
end;
end load_FCT_200X;
end;
