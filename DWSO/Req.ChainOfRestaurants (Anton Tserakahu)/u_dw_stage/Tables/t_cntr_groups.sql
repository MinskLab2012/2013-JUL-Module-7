--drop trigger u_dw_references.bi_t_cntr_groups
--/
--
--alter table u_dw_references.t_cntr_groups
--   drop constraint FK_T_GEO_OBJECTS2CNTR_GROUPS
--/
--
drop table u_dw_stage.t_cntr_groups cascade constraints
/

--==============================================================
-- Table: t_cntr_groups                                         
--==============================================================
create table u_dw_stage.t_cntr_groups 
(
   geo_id               NUMBER(22,0)         not null,
   group_id             NUMBER(22,0)         not null,
   constraint PK_T_CNTR_GROUPS primary key (geo_id)
)
organization index tablespace ts_dw_stage_data_01
/

comment on table u_dw_stage.t_cntr_groups is
'Referense store: Grouping Countries - Groups'
/

comment on column u_dw_stage.t_cntr_groups.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_stage.t_cntr_groups.group_id is
'ID Code of Countries Groups'
/

alter table u_dw_stage.t_cntr_groups
   add constraint FK_T_GEO_OBJECTS2CNTR_GROUPS foreign key (geo_id)
      references u_dw_stage.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_stage.bi_t_cntr_groups before insert
on u_dw_stage.t_cntr_groups for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    lc_geo_id      NUMBER := 0;
BEGIN
   IF :new.geo_id IS NOT NULL THEN
      raise_application_error ( -20000
                              , 'Geo_id have to be ''NULL''. New Values will be generated by triger.' );
   END IF;

   INSERT INTO w_geo_objects ( geo_id
                             , geo_type_id
                             , geo_code_id )
        VALUES ( sq_geo_t_id.NEXTVAL
               , 51 --Countries Groups
               , :new.group_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/
