rem
rem Header: hr_main.sql 09-jan-01
rem
rem Copyright (c) 2001, Oracle Corporation.  All rights reserved.  
rem
rem Owner  : ahunold
rem
rem NAME
rem   hr_main.sql - Main script for HR schema
rem
rem DESCRIPTON
rem   HR (Human Resources) is the smallest and most simple one 
rem   of the Sample Schemas
rem   
rem NOTES
rem   Run as SYS or SYSTEM
rem
rem MODIFIED   (MM/DD/YY)
rem   ahunold   07/13/01 - NLS Territory
rem   ahunold   04/13/01 - parameter 5, notes, spool
rem   ahunold   03/29/01 - spool
rem   ahunold   03/12/01 - prompts
rem   ahunold   03/07/01 - hr_analz.sql
rem   ahunold   03/03/01 - HR simplification, REGIONS table
rem   ngreenbe  06/01/00 - created

SET ECHO OFF

REM PROMPT 
REM PROMPT specify password for HR as parameter 1:
REM DEFINE pass     = &1
REM PROMPT 
REM PROMPT specify default tablespeace for HR as parameter 2:
REM DEFINE tbs      = &2
REM PROMPT 
REM PROMPT specify temporary tablespace for HR as parameter 3:
REM DEFINE ttbs     = &3
REM PROMPT 
REM PROMPT specify password for SYS as parameter 4:
REM DEFINE pass_sys = &4
REM PROMPT 
REM PROMPT specify log path as parameter 5:
REM DEFINE log_path = &5
REM PROMPT

-- The first dot in the spool command below is 
-- the SQL*Plus concatenation character

REM DEFINE spool_file = c:\oracle\hr_main.log
--SPOOL c:\oracle\hr_spool

REM =======================================================
REM cleanup section
REM =======================================================

DROP USER hr CASCADE;

REM =======================================================
REM create user
REM three separate commands, so the create user command 
REM will succeed regardless of the existence of the 
REM DEMO and TEMP tablespaces 
REM =======================================================

CREATE USER hr IDENTIFIED BY hr;

ALTER USER hr DEFAULT TABLESPACE    TS_SA_SOURCE_01
              QUOTA UNLIMITED ON TS_SA_SOURCE_01;

ALTER USER hr TEMPORARY TABLESPACE temp;

GRANT create session
     , create table
     , create procedure 
     , create sequence
     , create trigger
     , create view
     , create synonym
     , alter session
TO hr;


