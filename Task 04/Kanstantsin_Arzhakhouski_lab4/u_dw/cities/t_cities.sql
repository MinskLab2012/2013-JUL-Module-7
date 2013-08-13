--alter table "t_cities"
--   drop constraint FK_T_CITIES_REFERENCE_T_GEO_OB;

--alter table "t_dealers"
--   drop constraint FK_T_DEALER_REFERENCE_T_CITIES;

--drop table "t_cities" cascade constraints;

/*==============================================================*/
/* Table: "t_cities"                                            */
/*==============================================================*/
create table t_cities 
(
   city_id            NUMBER(22)           not null,
   city_desc          VARCHAR2(200 BYTE),
   geo_id             NUMBER(22),
   insert_dt          DATE,
   update_dt          DATE,
   constraint PK_T_CITIES primary key (city_id)
);

alter table t_cities
   add constraint FK_T_CITIES_REFERENCE_T_GEO_OB foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id);

GRANT DELETE,INSERT,UPDATE,SELECT ON t_cities TO u_dw_cleansing;