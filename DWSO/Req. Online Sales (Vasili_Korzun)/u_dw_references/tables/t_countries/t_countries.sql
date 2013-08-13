drop trigger u_dw_references.bu_t_countries
/
--
alter table u_dw_references.lc_countries
  drop constraint FK_LC_COUNTRIES
/
--
alter table u_dw_references.t_countries
  drop constraint FK_T_GEO_OBJECTS2COUNTRIES
/
--
drop table u_dw_references.t_countries cascade constraints
/

--==============================================================
-- Table: t_countries                                           
--==============================================================
create table u_dw_references.t_countries 
(
   geo_id               NUMBER(22,0)         not null,
   country_id           NUMBER(22,0)         not null,
   constraint PK_T_COUNTRIES primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
/

comment on table u_dw_references.t_countries is
'Referense store: Geographical Countries'
/

comment on column u_dw_references.t_countries.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_references.t_countries.country_id is
'ID Code of Country'
/

alter table u_dw_references.t_countries
   add constraint FK_T_GEO_OBJECTS2COUNTRIES foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_references.bu_t_countries before insert
on u_dw_references.t_countries for each row
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
               , 12 --Country
               , :new.country_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/
