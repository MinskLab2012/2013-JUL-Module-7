CREATE OR REPLACE PACKAGE BODY pkg_load_dim_products_scd
as
procedure  load_t_and_lc_categories
as
v_sa number;
v_ext number; 
v_curloc number := 1;
cursor cur_1 is select distinct prod_category_id  from u_dw_ext_references.ext_prod_categories order by 1;
cursor cur_2 is select prod_category_code from st.t_categories;
begin 
delete from st.t_categories fir where fir.prod_category_code not in (select distinct sec.prod_category_id 
from u_dw_ext_references.ext_prod_categories sec);
delete from st.lc_categories tr where TR.PROD_CATEGORY_ID not in (select prod_category_id from st.t_categories);
open cur_1;
open cur_2;
loop
fetch cur_1 into v_ext;
fetch cur_2 into v_sa;
exit when cur_1%NOTFOUND;
if v_ext = v_sa
then update st.t_categories t
set (t.prod_category_code, last_update_dt)  = (select distinct   prod_category_id, (select distinct sysdate from dual) 
from u_dw_ext_references.ext_prod_categories
where prod_category_id = v_ext)
where t.prod_category_code = v_sa;
update st.lc_categories lc
set (LC.PROD_CATEGORY_NAME,lc.prod_category_desc, lc.last_update_dt, lc.localization_id) = (select distinct prod_category,prod_category_desc, (select distinct sysdate from dual), 
(select distinct localization_id from st.localization where localization_id = v_curloc)  from u_dw_ext_references.ext_prod_categories
where prod_category_id = v_ext)
where LC.PROD_CATEGORY_ID = (select distinct prod_category_id from st.t_categories where prod_category_code = v_sa)
and LC.PROD_CATEGORY_NAME != (select distinct   prod_category
from u_dw_ext_references.ext_prod_categories
where prod_category_id = v_ext) and
lc.prod_category_desc != (select distinct   prod_category_desc
from u_dw_ext_references.ext_prod_categories
where prod_category_id = v_ext);
else insert into st.t_categories (prod_category_id,prod_category_code, last_insert_dt)
 values(st.seq_t_categories.nextval, v_ext, sysdate);
 insert into ST.LC_CATEGORIES lc (lc.prod_category_id,LC.PROD_CATEGORY_NAME,lc.prod_category_desc, lc.last_insert_dt, lc.localization_id)
 (select st.seq_t_categories.currval, (select distinct prod_category  from u_dw_ext_references.ext_prod_categories
where prod_category_id = v_ext),(select distinct prod_category_desc
 from u_dw_ext_references.ext_prod_categories
where prod_category_id = v_ext), (select distinct  sysdate from dual), (select distinct localization_id from st.localization where localization_id = v_curloc)
from dual);
 end IF;
 end loop;
 close cur_1;
 close cur_2;
  commit;
 end load_t_and_lc_categories;
 
 procedure load_t_and_lc_products_act
as
temp_num number;
temp_sql varchar2(200);
ret number;
ret1 number;
TYPE rec_type is record (
  prod_id number(20)
                      ,income_coef number(20,4)
                      , prod_category_id number(20)
                      , prod_name varchar2(100)
                      , prod_desc varchar2(100)
);
type cur_type is ref cursor return rec_type;
curid cur_type;
sql_stmt varchar2 (500);
type prod_lst is table of curid%rowtype;
curnum number;
curnum1 number;
curloc number :=1;
in_prod prod_lst;
out_prod prod_lst;
begin
curnum:=DBMS_SQL.OPEN_CURSOR;
sql_stmt:= 'select prod_id,income_coef,prod_category_id, prod_name, prod_desc from u_dw_ext_references.ext_products where prod_id not in 
(select distinct prod_code from st.t_products)';
dbms_sql.parse (curnum, sql_stmt, dbms_sql.native);
ret:=dbms_sql.execute(curnum);
curid:=DBMS_SQL.TO_REFCURSOR(curnum);
fetch curid bulk collect into in_prod;

curnum1:=DBMS_SQL.OPEN_CURSOR;
sql_stmt:= 'select prod_id,income_coef,prod_category_id, prod_name, prod_desc from u_dw_ext_references.ext_products where prod_id in 
(select distinct prod_code from st.t_products)';
dbms_sql.parse (curnum1, sql_stmt, dbms_sql.native);
ret1:=dbms_sql.execute(curnum1);
curid:=DBMS_SQL.TO_REFCURSOR(curnum1);
fetch curid bulk collect into out_prod;
temp_sql := 'select count(action_type_id) from st.action_types ';
execute immediate temp_sql into temp_num;
if  (temp_num !='1') then
insert into  st.action_types (action_type_id, action_type_desc)
select 1,'income_coef' from dual;
end if;

forall i in indices of in_prod
insert into st.t_products (prod_id,
prod_code,
income_coef,
prod_category_id,
last_insert_dt
) values (st.seq_t_products.nextval,
in_prod(i).prod_id,
in_prod(i).income_coef,
(select distinct prod_category_id from st.t_categories 
where prod_category_code = in_prod(i).prod_category_id),
sysdate);
forall i in indices of in_prod
insert into ST.LC_PRODUCTS (prod_id,
prod_name,
prod_desc,
localization_id,
last_insert_dt
) values ((select distinct prod_id from st.t_products where prod_code = in_prod(i).prod_id),
in_prod(i).prod_name,
in_prod(i).prod_desc,
curloc,
sysdate);

forall i in indices of out_prod
UPDATE st.t_products t
            SET t.prod_code = out_prod ( i ).prod_id
              , t.income_coef = out_prod ( i ).income_coef
              , t.prod_category_id = 
              (select prod_category_id from st.t_categories where prod_category_code = out_prod(i).prod_category_id)
              , t.last_update_dt = SYSDATE
          WHERE t.prod_id = (select prod_id from st.t_products where prod_code=out_prod ( i ).prod_id)
            AND  t.prod_code != out_prod ( i ).prod_id
            AND t.income_coef != out_prod ( i ).income_coef
            and t.prod_category_id != out_prod(i).prod_category_id ;

forall i in indices of out_prod
merge into ST.PROD_ACTIONS
using (select x.prod_id prod,x.income_coef coef from st.t_products x where prod_code = out_prod(i).prod_id)
on (prod_id =prod and OLD_VALUE = coef) 
when not matched then insert  (
action_id,
action_date,
action_type_id,
prod_id,
old_value,
new_value) values(
st.seq_prod_actions.nextval,
sysdate,
(select distinct action_type_id from st.action_types where action_type_id = 1),
(select distinct prod_id from st.t_products where prod_code = out_prod(i).prod_id),
(select distinct income_coef from st.t_products where prod_code = out_prod(i).prod_id),
out_prod(i).income_coef);
            
            forall i in indices of out_prod
            UPDATE st.lc_products lc
            SET lc.prod_name = out_prod ( i ).prod_name
              , lc.prod_desc = out_prod ( i ).prod_desc
              ,lc.localization_id = (select localization_id from st.localization where localization_id = curloc) 
              , lc.last_update_dt = SYSDATE
          WHERE lc.prod_id = (select distinct  prod_id from st.t_products where prod_code=out_prod ( i ).prod_id)
            and  (lc.prod_name != out_prod ( i ).prod_name
            or lc.prod_desc != out_prod ( i ).prod_desc);
            commit;
close curid;
end load_t_and_lc_products_act;

 end;