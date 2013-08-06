declare
varprod number;
begin
select count(*) into varprod from (select t.prod_code, lc.prod_name, lc.prod_desc, t.income_coef, cat.prod_category_code from st.t_products t join st.lc_products lc
on t.prod_id = lc.prod_id
join st.t_categories cat on T.PROD_CATEGORY_ID = cat.prod_category_id
minus
select * from U_DW_EXT_REFERENCES.EXT_PRODUCTS);
DBMS_OUTPUT.PUT_LINE('Count different lines for products '||varprod);

select count(*) into varprod from (select t.prod_category_code, lc.prod_category_name, lc.prod_category_desc from st.t_categories t join st.lc_categories lc
on t.prod_category_id = lc.prod_category_id
minus
select * from U_DW_EXT_REFERENCES.ext_prod_categories);
DBMS_OUTPUT.PUT_LINE('Count different lines for product categories '||varprod);

select count(*) into varprod from (select t.ship_code, t.weight, t.height, t.water_volume, t.max_cargo from st.t_ships t
minus
select * from U_DW_EXT_REFERENCES.ext_ship);
DBMS_OUTPUT.PUT_LINE('Count different lines for ships '||varprod);

select count(*) into varprod from (select t.port_code, t.pier_code,lc.contact_person,T.CONTACT_TEL,LC.PORT_COUTRY,LC.PORT_CITY,LC.PORT_ADDRESS from st.t_ports t join st.lc_ports lc
on t.port_id = lc.port_id
minus
select port_identifier, round(pier_num), contact_person, cust_tel, cust_region, cust_city, cust_street from U_DW_EXT_REFERENCES.ports);
DBMS_OUTPUT.PUT_LINE('Count different lines for ports '||varprod);

select count(*) into varprod from (select t.customer_code,lc.company_name,LC.customer_country,LC.customer_CITY,LC.customer_ADDRESS,t.customer_fax,t.customer_tel,
LC.CUSTOMER_EMAIL, lc.contact_person
from st.t_customers t join st.lc_customers lc
on t.customer_id = lc.customer_id
minus
select customer_identifier, company_name, cust_region, cust_city,cust_street, cust_fax,cust_tel,cust_email,contact_person  from U_DW_EXT_REFERENCES.ext_customers);
DBMS_OUTPUT.PUT_LINE('Count different lines for customers '||varprod);

select count(*) into varprod from (select t.insurance_code,  TY.INSURANCE_TYPE, t.insurence_cost, lc.company_name
from st.t_insurance t join st.lc_insurances lc
on t.insurance_id = lc.insurance_id
join st.t_insurance_type ty
on (t.insurance_type_id = ty.insurance_type_id)
minus
select *  from U_DW_EXT_REFERENCES.ext_insurances);
DBMS_OUTPUT.PUT_LINE('Count different lines for insurances '||varprod);

select count(*) into varprod from (select t.tran_id, sh.ship_code, prod.prod_code, insurance_code, customer_code, t.ar_time, POR.PORT_CODE, t.dep_time, PO.PORT_CODE, t.ar_goods, T.DEP_GOODS
from st.t_trans t join st.t_insurance ins
on t.insurance_id = ins.insurance_id
join st.t_ports por
on (t.ar_port_id = por.port_id)
join st.t_ports po
on(t.dep_port_id = po.port_id)
join st.t_ships sh
on (t.ship_id = sh.ship_id)
join st.t_customers cust
on (t.customer_id = cust.customer_id)
join st.t_products prod
on (t.prod_id = prod.prod_id)
minus
select *  from U_DW_EXT_REFERENCES.t_trans);
DBMS_OUTPUT.PUT_LINE('Count different lines for transaction table '||varprod);

end;





