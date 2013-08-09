declare
   BEGIN
merge into u_dw_references.actions fir
using(select * from t_geo_object_links where link_type_id<4) sec
 on ( fir.geo_id = sec.child_geo_id and fir.value_new = sec.parent_geo_id)
 when not matched then
 insert  (fir.action_id, fir.geo_id, fir.type_id, fir.value_new, action_dt)
values (u_dw_references.act_seq.nextval, sec.child_geo_id,null,sec.parent_geo_id, sysdate);
commit;
end;
 
