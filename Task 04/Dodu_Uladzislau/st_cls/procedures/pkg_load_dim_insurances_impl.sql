create or replace package body pkg_load_dim_insurances
as
procedure load_t_and_lc_insurances
as
temp varchar2(100) :=  '1';
sql_stmt varchar2(2000) :=
'select distinct INS.UNIQUE_IDENTIFIER, INS.RISK_TYPE,INS.INS_COST, INS.COMPANY_NAME, T.INSURANCE_ID  from U_DW_EXT_REFERENCES.EXT_INSURANCES ins
left join st.t_insurance t 
on INS.UNIQUE_IDENTIFIER = T.INSURANCE_code
left join st.t_insurance_type inst
on T.INSURANCE_TYPE_ID = INST.INSURANCE_TYPE_ID';
curid number;
colcnt number;
desctab DBMS_SQL.DESC_TAB;
type cur_c1 is ref cursor ;
curs cur_c1;
varnum number;
ins_type varchar2(50);
ins_c number;
ins_comp varchar(50);
inst_id number;

begin

open curs for sql_stmt;
curid :=DBMS_SQL.TO_CURSOR_NUMBER(curs);
dbms_sql.describe_columns(curid, colcnt,desctab);


dbms_sql.define_column(curid,1,varnum);
dbms_sql.define_column(curid, 2,ins_type,50);
DBMS_SQL.DEFINE_COLUMN(curid,3,ins_c);
dbms_sql.define_column(curid,4,ins_comp,50);
dbms_sql.define_column(curid,5,inst_id);

while DBMS_SQL.FETCH_ROWS(curid)>0 
loop
dbms_sql.column_value(curid,1,varnum);
dbms_sql.column_value(curid,2,ins_type);
DBMS_SQL.COLUMN_VALUE(curid,3,ins_c);
dbms_sql.column_value(curid,4,ins_comp);
dbms_sql.column_value(curid,5,inst_id);
if inst_id is null
then
insert into st.t_insurance t (t.insurance_id,t.insurence_type_id, t.insurance_code,t.insurence_cost, t.last_insert_dt) values(
st.seq_t_insurance.nextval,
(select insurance_type_id from st.t_insurance_type where insurance_type = ins_type),
varnum,
ins_c,
sysdate);
insert into st.lc_insurances (insurance_id, company_name, localization_id, last_insert_dt) values
(st.seq_t_insurance.currval,
ins_comp,
(select localization_id from st.localization where localization_id =1),
sysdate);
else
update st.t_insurance 
set insurence_type_id = (select insurance_id from st.t_insurance_type where insurance_type = ins_type), 
insurance_code = varnum,
insurence_cost = ins_c, 
last_update_dt = sysdate
where insurance_id = (select insurance_id from st.t_insurance where insurance_code = varnum) and
(insurance_code != varnum or
insurence_cost != ins_c);
update st.lc_insurances
set company_name = ins_comp,
last_update_dt = sysdate
where insurance_id = (select insurance_id from st.t_insurance where insurance_code = varnum) and
company_name != ins_comp;
end if;
end loop;
commit;
end load_t_and_lc_insurances;

procedure load_t_insurance_type
as
varid varchar2(50);
cursor cur_c1 is
select distinct risk_type from U_DW_EXT_REFERENCES.EXT_INSURANCES minus select distinct insurance_type from st.t_insurance_type;
begin
open cur_c1;

loop

fetch cur_c1 into varid;
exit when cur_c1%notfound;
insert into st.t_insurance_type(insurance_type_id,insurance_type, localization_id, last_insert_dt) values
(st.seq_t_insurance_type.nextval,
varid,
(select localization_id from st.localization where localization_id =1),
sysdate);
end loop;
commit;
close cur_c1;
end load_t_insurance_type;
end;



 
