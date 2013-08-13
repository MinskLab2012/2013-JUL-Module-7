
CREATE OR REPLACE PACKAGE pkg_load_dwh
-- Package Reload Data From External Sources to DataBase - Geography objects
--
AS
   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 3
   PROCEDURE load_delivery;

   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 2
   PROCEDURE load_structures;

   -- Load All Countries from ISO 3166 to References
   PROCEDURE load_products;

   -- Extract Data from external source = External Table
   -- Load All Geography objects from ISO 3166
   PROCEDURE load_suppliers;

   -- Extract Data from external source = External Table
   -- Load All Geography objects from ISO 3166
   PROCEDURE load_clients;

   -- Load Geography System from ISO 3166 to References
   PROCEDURE load_facts;
END pkg_load_dwh;
/