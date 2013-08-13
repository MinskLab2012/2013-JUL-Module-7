drop view u_dw_stage.vl_countries;

--==============================================================
-- View: vl_countries                                           
--==============================================================
create or replace view u_dw_stage.vl_countries as
SELECT geo_id
     , country_id
     , country_code_a2
     , country_code_a3
     , country_desc
  FROM lc_countries;

 comment on table u_dw_stage.vl_countries is
'Localazible View: T_CONTINENTS';

comment on column u_dw_stage.vl_countries.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_stage.vl_countries.country_id is
'ID Code of Country';

comment on column u_dw_stage.vl_countries.country_code_a2 is
'Code of Countries - ALPHA 2';

comment on column u_dw_stage.vl_countries.country_code_a3 is
'Code of Countries - ALPHA 3';

comment on column u_dw_stage.vl_countries.country_desc is
'Description of Countries';


