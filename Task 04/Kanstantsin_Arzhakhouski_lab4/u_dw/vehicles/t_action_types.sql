--alter table "vehicle_actions"
--   drop constraint FK_VEHICLE__REFERENCE_ACTION_T;

--drop table "action_types" cascade constraints;

/*==============================================================*/
/* Table: "action_types"                                        */
/*==============================================================*/
create table action_types 
(
   action_type_id     NUMBER(20)           not null,
   action_desc        VARCHAR2(50 CHAR),
   constraint PK_ACTION_TYPES primary key (action_type_id)
);

GRANT DELETE,INSERT,UPDATE,SELECT ON action_types TO u_dw_cleansing;