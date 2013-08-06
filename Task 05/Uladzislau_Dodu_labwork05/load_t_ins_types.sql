create or replace procedure load_t_insurance_type
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



