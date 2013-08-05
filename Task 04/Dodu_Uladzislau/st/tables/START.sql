/* Formatted on 8/4/2013 1:10:55 PM (QP5 v5.139.911.3011) */
/*==============================================================*/

/* DBMS name:      ORACLE Version 11g                           */

/* Created on:     8/1/2013 2:30:12 PM                          */

/*==============================================================*/

DROP SEQUENCE seq_t_trans;
DROP SEQUENCE seq_t_ports;
DROP SEQUENCE seq_t_ships;
DROP SEQUENCE seq_t_products;
DROP SEQUENCE seq_t_categories;
DROP SEQUENCE seq_t_insurance_type;
DROP SEQUENCE seq_t_insurance;
DROP SEQUENCE seq_action_type;
DROP SEQUENCE seq_prod_actions;
DROP SEQUENCE seq_localization;

ALTER TABLE lc_categories
   DROP CONSTRAINT fk_lc_categ_reference_t_catego;

ALTER TABLE lc_products
   DROP CONSTRAINT fk_lc_produ_reference_t_produc;

ALTER TABLE prod_actions
   DROP CONSTRAINT fk_prod_act_reference_t_produc;

DROP TABLE action_types CASCADE CONSTRAINTS;

DROP TABLE lc_categories CASCADE CONSTRAINTS;

DROP TABLE lc_customers CASCADE CONSTRAINTS;

DROP TABLE lc_insurances CASCADE CONSTRAINTS;

DROP TABLE lc_ports CASCADE CONSTRAINTS;

DROP TABLE lc_products CASCADE CONSTRAINTS;

DROP TABLE localization CASCADE CONSTRAINTS;

DROP TABLE prod_actions CASCADE CONSTRAINTS;

DROP TABLE t_categories CASCADE CONSTRAINTS;

DROP TABLE t_customers CASCADE CONSTRAINTS;

DROP TABLE t_insurance CASCADE CONSTRAINTS;

DROP TABLE t_insurance_type CASCADE CONSTRAINTS;

DROP TABLE t_ports CASCADE CONSTRAINTS;

DROP TABLE t_products CASCADE CONSTRAINTS;

DROP TABLE t_ships CASCADE CONSTRAINTS;

DROP TABLE t_trans CASCADE CONSTRAINTS;

START ACTION_TYPES.sql;

START T_CATEGORIES.sql;

START LOCALIZATION.sql;

START LC_CATEGORIES.sql;

START T_CUSTOMERS.sql;

START LC_CUSTOMERS.sql;

START T_INSURANCE_TYPE.sql;

START T_INSURANCE.sql;

START LC_INSURANCES.sql;

START T_PORTS.sql;

START LC_PORTS.sql;

START T_PRODUCTS.sql;

START LC_PRODUCTS.sql;

START PROD_ACTIONS.sql;

START T_SHIPS.sql;

START T_TRANS.sql;