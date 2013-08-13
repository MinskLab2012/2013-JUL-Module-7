--alter table "vehicle_actions"
--   drop constraint FK_VEHICLE__REFERENCE_ACTION_T;

--alter table "vehicle_actions"
--   drop constraint FK_VEHICLE__REFERENCE_T_VEHICL;

--drop table "vehicle_actions" cascade constraints;

/*==============================================================*/
/* Table: "vehicle_actions"                                     */
/*==============================================================*/
create table vehicle_actions 
(
   vehicle_id         NUMBER(20),
   action_date        DATE,
   action_type_id     NUMBER(20),
   old_price          NUMBER(20),
   new_price          NUMBER(20)
);

alter table vehicle_actions
   add constraint FK_VEHICLE__REFERENCE_ACTION_T foreign key (action_type_id)
      references action_types (action_type_id);

alter table vehicle_actions
   add constraint FK_VEHICLE__REFERENCE_T_VEHICL foreign key (vehicle_id)
      references t_vehicles (vehicle_id);

GRANT DELETE,INSERT,UPDATE,SELECT ON vehicle_actions TO u_dw_cleansing;