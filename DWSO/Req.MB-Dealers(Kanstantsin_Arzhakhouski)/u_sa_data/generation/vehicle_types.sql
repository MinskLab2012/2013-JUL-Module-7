--------------------------------------------------------
--  File created - Wednesday-August-07-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table TMP_VEHICLE_TYPES
--------------------------------------------------------

  CREATE TABLE "TMP_VEHICLE_TYPES" 
   (	"VEHICLE_TYPE_ID" NUMBER, 
	"VEHICLE_TYPE_DESC" VARCHAR2(32 BYTE)
   ) ;
/
REM INSERTING into TMP_VEHICLE_TYPES
SET DEFINE OFF;
Insert into TMP_VEHICLE_TYPES (VEHICLE_TYPE_ID,VEHICLE_TYPE_DESC) values (1,'A-Class');
Insert into TMP_VEHICLE_TYPES (VEHICLE_TYPE_ID,VEHICLE_TYPE_DESC) values (2,'B-Class');
Insert into TMP_VEHICLE_TYPES (VEHICLE_TYPE_ID,VEHICLE_TYPE_DESC) values (3,'C-Class');
Insert into TMP_VEHICLE_TYPES (VEHICLE_TYPE_ID,VEHICLE_TYPE_DESC) values (4,'CL-Class');
Insert into TMP_VEHICLE_TYPES (VEHICLE_TYPE_ID,VEHICLE_TYPE_DESC) values (5,'CLA-Class');
Insert into TMP_VEHICLE_TYPES (VEHICLE_TYPE_ID,VEHICLE_TYPE_DESC) values (6,'CLS-Class');
Insert into TMP_VEHICLE_TYPES (VEHICLE_TYPE_ID,VEHICLE_TYPE_DESC) values (7,'E-Class');
Insert into TMP_VEHICLE_TYPES (VEHICLE_TYPE_ID,VEHICLE_TYPE_DESC) values (8,'G-Class');
Insert into TMP_VEHICLE_TYPES (VEHICLE_TYPE_ID,VEHICLE_TYPE_DESC) values (9,'GL-Class');
Insert into TMP_VEHICLE_TYPES (VEHICLE_TYPE_ID,VEHICLE_TYPE_DESC) values (10,'GLK-Class');
Insert into TMP_VEHICLE_TYPES (VEHICLE_TYPE_ID,VEHICLE_TYPE_DESC) values (11,'M-Class');
Insert into TMP_VEHICLE_TYPES (VEHICLE_TYPE_ID,VEHICLE_TYPE_DESC) values (12,'S-Class');
Insert into TMP_VEHICLE_TYPES (VEHICLE_TYPE_ID,VEHICLE_TYPE_DESC) values (13,'SL-Class');
Insert into TMP_VEHICLE_TYPES (VEHICLE_TYPE_ID,VEHICLE_TYPE_DESC) values (14,'SLK-Class');
Insert into TMP_VEHICLE_TYPES (VEHICLE_TYPE_ID,VEHICLE_TYPE_DESC) values (15,'SLS-AMG');
commit;
