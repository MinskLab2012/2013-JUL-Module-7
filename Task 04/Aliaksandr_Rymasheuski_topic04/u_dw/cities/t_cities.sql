--ALTER TABLE CITIES
--   DROP CONSTRAINT FK_CITIES_REFERENCE_T_GEO_OB;
--
--ALTER TABLE CUSTOMERS
--   DROP CONSTRAINT FK_CUSTOMER_REFERENCE_CITIES;
--
--ALTER TABLE OFFICES
--   DROP CONSTRAINT FK_OFFICES_REFERENCE_CITIES;

DROP TABLE CITIES CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: CITIES                                             */
/*==============================================================*/
CREATE TABLE CITIES 
(
   CITY_ID            NUMBER(20)           NOT NULL,
    CITY_DESC          VARCHAR(50),
   COUNTRY_GEO_ID     NUMBER(22,0),
      INSERT_DT          DATE,
   UPDATE_DT          DATE,
     CONSTRAINT PK_CITIES PRIMARY KEY (CITY_ID)
);

COMMENT ON COLUMN CITIES.COUNTRY_GEO_ID IS
'Unique ID for All Geography objects';

ALTER TABLE CITIES
   ADD CONSTRAINT FK_CITIES_REFERENCE_T_GEO_OB FOREIGN KEY (COUNTRY_GEO_ID)
      REFERENCES U_DW_REFERENCES.T_GEO_OBJECTS (GEO_ID);
      
      
      GRANT DELETE,INSERT,UPDATE,SELECT ON CITIES TO u_dw_cleansing;
      
      
 
    
SELECT DISTINCT city_desc 
FROM u_dw.cities
MINUS
(SELECT DISTINCT office_city 
FROM u_sa_data.contracts
UNION 
SELECT DISTINCT customer_city 
FROM u_sa_data.contracts);
      
