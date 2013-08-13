--drop trigger u_dw_references.bu_t_geo_system
--/
--
--alter table u_dw_references.lc_geo_systems
--   drop constraint FK_T_GEO_SYSTEMS2LC_GEO_SYSTEMS
--/
--
--alter table u_dw_references.t_geo_systems
--   drop constraint FK_T_GEO_OBJECTS2T_GEO_SYSTEMS
--/

drop table u_dw_stage.t_geo_systems cascade constraints
/

--==============================================================
-- Table: t_geo_systems                                         
--==============================================================
create table u_dw_stage.t_geo_systems 
(
   geo_id               NUMBER(22,0)         not null,
   geo_system_id        NUMBER(22,0)         not null,
   constraint PK_T_GEO_SYSTEMS primary key (geo_id)
)
organization index tablespace ts_dw_stage_data_01
/

comment on table u_dw_stage.t_geo_systems is
'Abstarct Referense store all Geography objects'
/

comment on column u_dw_stage.t_geo_systems.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_stage.t_geo_systems.geo_system_id is
'ID Code of Geography System Specifications'
/

alter table u_dw_stage.t_geo_systems
   add constraint FK_T_GEO_OBJECTS2T_GEO_SYSTEMS foreign key (geo_id)
      references u_dw_stage.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_stage.bu_t_geo_system before insert
on u_dw_stage.t_geo_systems for each row
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
               , 2 --SYSTEMS
               , :new.geo_system_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

