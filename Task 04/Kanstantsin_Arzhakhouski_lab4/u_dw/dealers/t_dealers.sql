--alter table "t_dealers"
--   drop constraint FK_T_DEALER_REFERENCE_T_CITIES;

--alter table "t_delivery"
--   drop constraint FK_T_DELIVE_REFERENCE_T_DEALER;

--drop table "t_dealers" cascade constraints;

/*==============================================================*/
/* Table: "t_dealers"                                           */
/*==============================================================*/
create table t_dealers
(
   dealer_id          NUMBER(10)           not null,
   dealer_code  NUMBER(10),
   city_id           NUMBER(22),
   dealer_name        VARCHAR2(32 BYTE),
   dealer_address     VARCHAR2(32 BYTE),
   insert_dt          DATE,
   update_dt          DATE,
   constraint PK_T_DEALERS primary key (dealer_id)
);

alter table t_dealers
   add constraint FK_T_DEALER_REFERENCE_T_CITIES foreign key (city_id)
      references t_cities (city_id);

GRANT DELETE,INSERT,UPDATE,SELECT ON t_dealers TO u_dw_cleansing;