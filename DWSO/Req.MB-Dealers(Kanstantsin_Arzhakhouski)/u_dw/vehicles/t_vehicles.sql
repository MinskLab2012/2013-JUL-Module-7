--alter table "t_delivery"
--   drop constraint FK_T_DELIVE_REFERENCE_T_VEHICL;

--alter table "t_vehicles"
--   drop constraint FK_T_VEHICL_REFERENCE_T_VIHECL;

--drop table "t_vehicles" cascade constraints;

/*==============================================================*/
/* Table: "t_vehicles"                                          */
/*==============================================================*/
create table t_vehicles
(
   vehicle_id         NUMBER(32)           not null,
   vehicle_code   NUMBER(32),
   vehicle_type_id    NUMBER(32),
   vehicle_desc       VARCHAR2(200 BYTE),
   vehicle_price      NUMERIC(9,2),
   insert_dt          DATE,
   update_dt          DATE,
   constraint PK_T_VEHICLES primary key (vehicle_id)
);

alter table t_vehicles
   add constraint FK_T_VEHICL_REFERENCE_T_VIHECL foreign key (vehicle_type_id)
      references t_vihecle_types (vehicle_type_id);

GRANT DELETE,INSERT,UPDATE,SELECT ON t_vehicles TO u_dw_cleansing;