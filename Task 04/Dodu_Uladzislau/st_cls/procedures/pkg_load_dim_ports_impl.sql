create or replace package body pkg_load_dim_ports
as
 procedure load_t_and_lc_ports
as
   temp number(1) := 1;
   sql_block varchar2(500);
   curloc    NUMBER(3);
   TYPE rec_type is record (
   port_identifier number(20)
                      ,pier_code number(20)
                      , cust_country varchar2(100)
                      , cust_city varchar2(100)
                      , cust_street varchar2(100)
                      , cust_tel varchar2(100)
                      , cnt_per varchar2(100));
                 
   Type cur_c3 is ref cursor return rec_type;
   cur_c1 cur_c3;
   cur_c2 cur_c3;
    TYPE t_customer is table of cur_c1%rowtype;

   in_t_cust         t_customer;
   not_t_cust t_customer;
BEGIN
      sql_block:='select localization_id from st.localization where localization_id = :curlocaliz';
execute immediate sql_block  into curloc using temp ;  
   OPEN cur_c1 for SELECT DISTINCT port_identifier
                      , pier_num
                      , cust_region
                      , cust_city
                      , cust_street
                      , cust_tel
                      , contact_person
          FROM u_dw_ext_references.ports
          where port_identifier not in (select distinct port_code from st.t_ports);
          

   FETCH cur_c1
   BULK COLLECT INTO not_t_cust;
   
OPEN cur_c2 for SELECT DISTINCT port_identifier
                      , pier_num
                      , cust_region
                      , cust_city
                      , cust_street
                      , cust_tel
                      , contact_person
          FROM u_dw_ext_references.ports
          where port_identifier in (select distinct port_code from st.t_ports);
          
             FETCH cur_c2
   BULK COLLECT INTO in_t_cust;

forall i in indices of not_t_cust
INSERT INTO st.t_ports t ( t.port_id
                                      , t.port_code
                                      , t.pier_code
                                      , t.contact_tel
                                      , t.last_insert_dt )
              VALUES ( st.seq_t_ports.NEXTVAL
                     , not_t_cust ( i ).port_identifier
                     , not_t_cust ( i ).pier_code
                     , not_t_cust ( i ).cust_tel
                     , SYSDATE );
                    commit; 
                    
forall j in  not_t_cust.first..not_t_cust.last                     
INSERT INTO st.lc_ports lc ( lc.port_id
                                        , lc.contact_person
                                        , lc.port_coutry
                                        , lc.port_city
                                        , lc.port_address
                                        , lc.localization_id
                                        , lc.last_insert_dt )
              VALUES ( (select port_id from st.t_ports where port_code=not_t_cust ( j ).port_identifier)
                     , not_t_cust ( j ).cnt_per
                     , not_t_cust ( j ).cust_country
                     , not_t_cust ( j ).cust_city
                     , not_t_cust ( j ).cust_street
                     , curloc
                     , SYSDATE );
             close cur_c1;
             commit;
          
   forall i in indices of in_t_cust
         UPDATE st.t_ports t
            SET t.port_code = in_t_cust ( i ).port_identifier
              , t.pier_code = in_t_cust ( i ).pier_code
              , t.contact_tel = in_t_cust ( i ).cust_tel
              , t.last_update_dt = SYSDATE
          WHERE t.port_id = (select port_id from st.t_ports where port_code=in_t_cust ( i ).port_identifier)
            AND  (t.pier_code != in_t_cust ( i ).pier_code
            OR t.contact_tel != in_t_cust ( i ).cust_tel);
   forall i in indices of in_t_cust
         UPDATE st.lc_ports lc
            SET lc.contact_person = in_t_cust ( i ).cnt_per
              , lc.port_coutry = in_t_cust ( i ).cust_country
              , lc.port_city = in_t_cust ( i ).cust_city
              , lc.port_address = in_t_cust ( i ).cust_street
              , lc.localization_id =
                   ( SELECT DISTINCT localization_id
                       FROM st.localization
                      WHERE localization_id = curloc )
              , lc.last_insert_dt = SYSDATE
          WHERE lc.port_id = (select port_id from st.t_ports where port_code=in_t_cust ( i ).port_identifier)
and lc.contact_person !=in_t_cust ( i ).cnt_per
              and  (lc.port_coutry != in_t_cust ( i ).cust_country
              or lc.port_city !=in_t_cust ( i ).cust_city
              or lc.port_address != in_t_cust ( i ).cust_street);
   CLOSE cur_c2;
   commit;
END load_t_and_lc_ports;
end;


