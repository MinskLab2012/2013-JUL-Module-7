drop table DIM_LOCATIONS_SCD;

/*==============================================================*/
/* Table: DIM_LOCATIONS_SCD                                     */
/*==============================================================*/
create table DIM_LOCATIONS_SCD 
(
   geo_surr_id          NUMBER                         not null,
   geo_id               NUMBER                         null,
   geo_country_id       NUMBER                         null,
   country_id           NUMBER                         null,
   country_code_a2      varchar(5)                     null,
   country_code_a3      varchar(5)                     null,
   geo_country_name     varchar(80)                    null,
   geo_region_id        NUMBER                         null,
   geo_region_desc      varchar(50)                    null,
   geo_region_code      varchar(3)                     null,
   geo_part_id         NUMBER                         null,
   geo_part_desc       varchar(50)                       null,
   geo_part_code        varchar(30)                    null,
   level_code           varchar(30)                    null,
   valid_to             date                           null,
   valid_from           date                           null,
   constraint PK_DIM_LOCATIONS_SCD primary key (geo_surr_id)
);