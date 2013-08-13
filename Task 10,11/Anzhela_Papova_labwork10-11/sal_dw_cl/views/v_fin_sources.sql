/* Formatted on 10.08.2013 13:52:14 (QP5 v5.139.911.3011) */
CREATE OR REPLACE VIEW v_fin_sources
AS
   SELECT fin_source_id
        , fin_source_code
        , fin_source_desc
     FROM dw.t_fin_sources;