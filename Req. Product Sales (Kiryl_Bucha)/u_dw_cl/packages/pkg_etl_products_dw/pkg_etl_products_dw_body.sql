CREATE OR REPLACE PACKAGE BODY u_dw_cl.pkg_etl_products_dw
AS
   PROCEDURE load_cls_product_brands
   AS
   BEGIN
      EXECUTE IMMEDIATE 'truncate table cls_products_brand';

      INSERT INTO cls_products_brand
         SELECT ROWNUM AS id
              , t.product_brand
           FROM (  SELECT DISTINCT product_brand
                     FROM u_sa_data.orders
                 ORDER BY 1) t;

      COMMIT;
   END;

   PROCEDURE load_dw_product_brands
   AS
   BEGIN
      MERGE INTO u_dw_data.t_product_brands tt
           USING (SELECT id
                       , product_brand
                    FROM cls_products_brand) s
              ON ( tt.brand_id = s.id )
      WHEN MATCHED THEN
         UPDATE SET tt.brand_desc = s.product_brand
      WHEN NOT MATCHED THEN
         INSERT            ( brand_id
                           , brand_desc )
             VALUES ( s.id
                    , s.product_brand );

      COMMIT;
   END;

   PROCEDURE load_cls_product_groups
   AS
   BEGIN
      EXECUTE IMMEDIATE 'truncate table cls_product_groups';

      INSERT INTO cls_product_groups
         SELECT ROWNUM AS id
              , t.product_group
           FROM (  SELECT DISTINCT product_group
                     FROM u_sa_data.orders
                 ORDER BY 1) t;

      COMMIT;
   END;

   PROCEDURE load_dw_product_groups
   AS
   BEGIN
      MERGE INTO u_dw_data.t_product_groups tt
           USING (SELECT id
                       , product_group
                    FROM cls_product_groups) s
              ON ( tt.GROUP_ID = s.id )
      WHEN MATCHED THEN
         UPDATE SET tt.group_desc = s.product_group
      WHEN NOT MATCHED THEN
         INSERT            ( GROUP_ID
                           , group_desc )
             VALUES ( s.id
                    , s.product_group );

      COMMIT;
   END;

   PROCEDURE load_cls_product_links
   AS
   BEGIN
      EXECUTE IMMEDIATE 'truncate table cls_product_links';

      INSERT INTO cls_product_links
         SELECT ROWNUM AS id
              , t.product_name
              , t.product_group
              , t.product_brand
           FROM (  SELECT DISTINCT product_name
                                 , product_group
                                 , product_brand
                     FROM u_sa_data.orders
                 ORDER BY 1) t;

      COMMIT;
   END;

   PROCEDURE load_dw_products
   AS
      CURSOR crs
      IS
         ( SELECT --+USE_HASH(pr trg) full(pr) PARALLEL(pr 4)
                 pr.product_name
                , NVL ( trg.product_id, -1 ) AS product_id
             FROM ( SELECT DISTINCT product_name FROM cls_product_links) pr
                , u_dw_data.t_products trg
            WHERE trg.product_desc(+) = pr.product_name );

      lc             NUMBER := 1;
   BEGIN
      FOR c IN crs LOOP
         lc          := lc + 1;

         IF ( c.product_id < 0 ) THEN
            INSERT INTO u_dw_data.t_products
                 VALUES ( u_dw_data.sq_client_id.NEXTVAL
                        , c.product_name );
         ELSE
            UPDATE u_dw_data.t_products tt
               SET tt.product_desc = c.product_name
             WHERE c.product_id = tt.product_id;
         END IF;

         IF lc = 15 THEN
            lc          := 0;
            COMMIT;
         END IF;
      END LOOP;

      COMMIT;
   END;

   PROCEDURE load_dw_product_links
   AS
      TYPE tb_lnk IS TABLE OF u_dw_data.t_product_links%ROWTYPE;

      brand_lnk      tb_lnk;
      group_lnk      tb_lnk;

      CURSOR crs
      IS
         ( SELECT --+USE_HASH(lnk pr grp brd) PARALLEL(lnk 4)
                 NVL ( pr.product_id, -98 ) AS product_id
                , NVL ( grp.GROUP_ID, -98 ) AS GROUP_ID
                , NVL ( brd.brand_id, -98 ) AS brand_id
             FROM cls_product_links lnk
                , u_dw_data.t_products pr
                , u_dw_data.t_product_groups grp
                , u_dw_data.t_product_brands brd
            WHERE pr.product_desc(+) = lnk.product_name
              AND grp.group_desc(+) = lnk.product_group
              AND brd.brand_desc(+) = lnk.product_brand );

      --

      TYPE tb_links IS TABLE OF crs%ROWTYPE;

      links          tb_links := tb_links ( );
      flg_brand      NUMBER;
      flg_group      NUMBER;
      cntr_br        NUMBER := 1;
      cntr_gro       NUMBER := 1;
      
      bln boolean;
   BEGIN
      EXECUTE IMMEDIATE 'truncate table cls_product_links';
       
      brand_lnk   := tb_lnk ( );
      group_lnk   := tb_lnk ( );


       
      OPEN crs;

      LOOP
         FETCH crs
         BULK COLLECT INTO links
         LIMIT 13;

         brand_lnk.delete ( );
         group_lnk.delete ( );

        <<outer_lp>>
         FOR i IN 1 .. links.COUNT LOOP
            flg_brand   := -1;

            FOR j IN 1 .. brand_lnk.COUNT LOOP
               IF ( brand_lnk ( j ).obj_id = links ( i ).brand_id ) THEN
                  flg_brand   := links ( i ).brand_id;
                  CONTINUE outer_lp;
               END IF;
            END LOOP;

            IF flg_brand < 0 THEN
               flg_brand   := NVL ( brand_lnk.COUNT, 0 ) + 1;
               brand_lnk.EXTEND ( 1 );
               brand_lnk ( flg_brand ).product_id := links ( i ).product_id;
               brand_lnk ( flg_brand ).link_type_id := 1;
               brand_lnk ( flg_brand ).obj_id := links ( i ).brand_id;
            END IF;

            --
            flg_group   := -1;

            FOR j IN 1 .. group_lnk.COUNT LOOP
               IF ( group_lnk ( j ).obj_id = links ( i ).GROUP_ID ) THEN
                  flg_group   := links ( i ).GROUP_ID;
                  CONTINUE outer_lp;
               END IF;
            END LOOP;

            IF flg_group < 0 THEN
               flg_group   := group_lnk.COUNT + 1;
               group_lnk.EXTEND ( 1 );
               group_lnk ( flg_group ).product_id := links ( i ).product_id;
               group_lnk ( flg_group ).link_type_id := 2;
               group_lnk ( flg_group ).obj_id := links ( i ).GROUP_ID;
            END IF;
         END LOOP;

         FORALL i IN 1 .. brand_lnk.COUNT -- use FORALL statement
            INSERT INTO u_dw_data.t_product_links
                 VALUES brand_lnk ( i );
                 
         FORALL i IN 1 .. group_lnk.COUNT -- use FORALL statement
            INSERT INTO u_dw_data.t_product_links
                 VALUES group_lnk ( i );        
         
         COMMIT;
         
         EXIT WHEN crs%NOTFOUND;
      END LOOP;

      dbms_output.enable;
      dbms_output.put_line ( 'brand_lnk is ' || brand_lnk.COUNT );
      dbms_output.put_line ( 'group_lnk is ' || group_lnk.COUNT );
   END;
END pkg_etl_products_dw;