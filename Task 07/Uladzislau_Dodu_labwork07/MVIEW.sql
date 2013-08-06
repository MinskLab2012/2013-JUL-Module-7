BEGIN
   dbms_mview.refresh ( 'v_agr_trans_3'
                      , 'c' );
END;