/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     8/1/2013 4:15:42 PM                          */
/*==============================================================*/


alter table "lc_countries"
   drop constraint FK_LC_COUNT_REFERENCE_T_COUNTR;

alter table "lc_geo_parts"
   drop constraint FK_LC_GEO_P_REFERENCE_T_GEO_PA;

alter table "lc_geo_regions"
   drop constraint FK_LC_GEO_R_REFERENCE_T_GEO_RE;

alter table "payment_systems_actions"
   drop constraint FK_PAYMENT__REFERENCE_PAYMENT_;

alter table "prod_subcategories"
   drop constraint FK_PROD_SUB_REFERENCE_PROD_CAT;

alter table "t_countries"
   drop constraint FK_T_COUNTR_REFERENCE_T_GEO_OB;

alter table "t_geo_object_links"
   drop constraint FK_GEO_LINK_CHILD;

alter table "t_geo_object_links"
   drop constraint FK_GEO_LINK_PARENT;

alter table "t_geo_parts"
   drop constraint FK_T_GEO_PA_REFERENCE_T_GEO_OB;

alter table "t_geo_regions"
   drop constraint FK_T_GEO_RE_REFERENCE_T_GEO_OB;

alter table "transactions"
   drop constraint FK_TRANSACT_REFERENCE_PAYMENT_;

alter table "transactions"
   drop constraint FK_TRANSACT_REFERENCE_CUSTOMER;

alter table "transactions"
   drop constraint FK_TRANSACT_REFERENCE_PRODUCTS;

alter table "transactions"
   drop constraint FK_TRANSACT_REFERENCE_DELIVERY;

drop table "customers" cascade constraints;

drop table "delivery_systems" cascade constraints;

drop table "lc_countries" cascade constraints;

drop table "lc_geo_parts" cascade constraints;

drop table "lc_geo_regions" cascade constraints;

drop table "lc_geo_systems" cascade constraints;

drop table "payment_systems" cascade constraints;

drop table "payment_systems_action_types" cascade constraints;

drop table "payment_systems_actions" cascade constraints;

drop table "payment_systems_types" cascade constraints;

drop table "prod_categories" cascade constraints;

drop table "prod_subcategories" cascade constraints;

drop table "products" cascade constraints;

drop table "t_countries" cascade constraints;

drop table "t_geo_object_links" cascade constraints;

drop index "ui_geo_objects_codes";

drop table "t_geo_objects" cascade constraints;

drop table "t_geo_parts" cascade constraints;

drop table "t_geo_regions" cascade constraints;

drop table "t_geo_systems" cascade constraints;

drop table "t_geo_types" cascade constraints;

drop table "transactions" cascade constraints;

start u_dw_references.sql;

start customers.sql;

start delivery_systems.sql;

start t_geo_types.sql;

start t_geo_objects.sql;

start t_countries.sql;

start lc_countries.sql;

start t_geo_parts.sql;

start lc_geo_parts.sql;

start t_geo_regions.sql;

start lc_geo_regions.sql;

start t_geo_systems.sql;

start lc_geo_systems.sql;

start payment_systems_types.sql;

start payment_systems.sql;

start payment_systems_action_types.sql;

start payment_systems_actions.sql;

start prod_categories.sql;

start prod_subcategories.sql;

start products.sql;

start t_geo_object_links.sql;

start transactions.sql;

