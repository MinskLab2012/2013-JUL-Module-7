--alter table "t_delivery"
--   drop constraint FK_T_DELIVE_REFERENCE_T_DEALER;

-- table "t_delivery"
--   drop constraint FK_T_DELIVE_REFERENCE_T_VEHICL;

--drop table "t_delivery" cascade constraints;

/*==============================================================*/
/* Table: "t_delivery"                                          */
/*==============================================================*/
create table t_delivery 
(
   event_dt           NUMBER(10),
   operation_id       NUMBER(10),
   delivery_id        NUMBER(10),
   dealer_id          NUMBER(10),
   vehicle_id         NUMBER(32),
   unit_price         NUMBER(12,2),
   unit_quantity      NUMBER(12,2),
   total_price        NUMBER(12,2)
  
);

alter table t_delivery
   add constraint FK_T_DELIVE_REFERENCE_T_DEALER foreign key (dealer_id)
      references t_dealers (dealer_id);

alter table t_delivery
   add constraint FK_T_DELIVE_REFERENCE_T_VEHICL foreign key (vehicle_id)
      references t_vehicles (vehicle_id);


GRANT DELETE,INSERT,UPDATE,SELECT ON t_delivery TO u_dw_cleansing;