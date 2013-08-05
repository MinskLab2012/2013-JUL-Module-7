create or replace package body pkg_load_t_trans
as
 procedure load_t_trans
as
cursor cur_c1 is
SELECT /*+  parallel(tt, 4) parallel(tr, 4)*/ tt.tran_id, p.prod_id, po.port_id prod, por.port_id, INS.INSURANCE_ID, SH.SHIP_ID, CU.CUSTOMER_ID, TR.TRANSACTION_ID, TT.DEP_TIME, TT.AR_TIME, TT.DEP_GOODS, TT.AR_GOODS
  FROM u_dw_ext_references.t_trans tt
       JOIN st.t_products p
          ON ( tt.prod_id = p.prod_code )
       JOIN st.t_ports po
          ON ( tt.ar_port = po.port_code )
       JOIN st.t_ports por
          ON ( tt.dep_port = por.port_code )
       JOIN st.t_insurance ins
          ON ( tt.ins_id = ins.insurance_code )
       JOIN st.t_ships sh
          ON ( tt.ship_id = sh.ship_code )
       JOIN st.t_customers cu
          ON ( tt.cust_id = cu.customer_code )
       LEFT JOIN st.t_trans tr
          ON ( tt.tran_id = tr.tran_id );
          
     type temp_t is table of cur_c1%rowtype;
     temp temp_t;
     
     begin
     open cur_c1;
     fetch cur_c1 bulk collect into temp;
     for i in temp.first..temp.last loop
     if temp(i).transaction_id is null
     then
     insert into st.t_trans values (
     st.seq_t_trans.nextval,
     temp(i).tran_id,
     temp(i).ship_id,
     temp(i).insurance_id,
     temp(i).prod_id,
     temp(i).customer_id,
     temp(i).prod,
     temp(i).ar_time,
     temp(i).port_id,
     temp(i).dep_time,
     temp(i).dep_goods,
     temp(i).ar_goods,
     sysdate,
     null);
     end if;
     end loop;
     close cur_c1;
     commit;
     end load_t_trans;
     end;
