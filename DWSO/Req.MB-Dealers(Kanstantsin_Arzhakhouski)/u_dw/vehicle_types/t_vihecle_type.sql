--alter table "t_vehicles"
--   drop constraint FK_T_VEHICL_REFERENCE_T_VIHECL;

--drop table "t_vihecle_types" cascade constraints;

/*==============================================================*/
/* Table: "t_vihecle_types"                                     */
/*==============================================================*/
create table t_vihecle_types 
(
   vehicle_type_id    NUMBER(32)           not null,
   vehicle_code NUMBER(32),
   vehicle_type_desc  VARCHAR2(32 BYTE),
   insert_dt          DATE,
   update_dt          DATE,
   constraint PK_T_VIHECLE_TYPES primary key (vehicle_type_id)
);

GRANT DELETE,INSERT,UPDATE,SELECT ON t_vihecle_types TO u_dw_cleansing;