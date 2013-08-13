--drop trigger u_dw_references.bi_t_geo_parts
--/

--alter table u_dw_references.lc_geo_parts
  -- drop constraint FK_LC_CONTINENTS
--/

--alter table u_dw_references.t_geo_parts
--   drop constraint FK_T_GEO_OBJECTS2PARTS
--/

drop table u_dw_stage.t_geo_parts cascade constraints;
--
--==============================================================
-- Table: t_geo_parts                                           
--==============================================================
create table u_dw_stage.t_geo_parts 
(
   geo_id               NUMBER(22,0)         not null,
   part_id              NUMBER(22,0)         not null,
   constraint PK_T_GEO_PARTS primary key (geo_id)
)
organization index tablespace ts_dw_stage_data_01
/

comment on table u_dw_stage.t_geo_parts is
'Referense store: Geographical Parts of Worlds'
/

comment on column u_dw_stage.t_geo_parts.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_stage.t_geo_parts.part_id is
'ID Code of Geographical Part of World'
/

alter table u_dw_stage.t_geo_parts
   add constraint FK_T_GEO_OBJECTS2PARTS foreign key (geo_id)
      references u_dw_stage.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_stage.bi_t_geo_parts before insert
on u_dw_stage.t_geo_parts for each row
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
               , 10 --Part of World
               , :new.part_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/
  