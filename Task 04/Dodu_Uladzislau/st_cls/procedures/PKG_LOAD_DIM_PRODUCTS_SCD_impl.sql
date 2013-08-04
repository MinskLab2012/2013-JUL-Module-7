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
 end;