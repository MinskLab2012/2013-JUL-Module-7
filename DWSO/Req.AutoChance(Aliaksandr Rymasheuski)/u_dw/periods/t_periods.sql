/* Formatted on 12.08.2013 21:32:04 (QP5 v5.139.911.3011) */
CREATE TABLE periods
(
   per_id         NUMBER ( 5 )
 , per_desc       VARCHAR2 ( 50 )
 , per_begin      DATE
 , per_end        DATE
);


INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 1
            , 'winter'
            , TO_DATE ( '01-DEC-99 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-MAR-00 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 2
            , 'spring'
            , TO_DATE ( '01-MAR-00 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-JUN-00 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 3
            , 'summer'
            , TO_DATE ( '01-JUN-00 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-SEP-00 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 4
            , 'autumn'
            , TO_DATE ( '01-SEP-00 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-DEC-00 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 5
            , 'winter'
            , TO_DATE ( '01-DEC-00 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-MAR-01 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 6
            , 'spring'
            , TO_DATE ( '01-MAR-01 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-JUN-01 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 7
            , 'summer'
            , TO_DATE ( '01-JUN-01 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-SEP-01 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 8
            , 'autumn'
            , TO_DATE ( '01-SEP-01 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-DEC-01 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 9
            , 'winter'
            , TO_DATE ( '01-DEC-01 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-MAR-02 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 10
            , 'spring'
            , TO_DATE ( '01-MAR-02 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-JUN-02 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 11
            , 'summer'
            , TO_DATE ( '01-JUN-02 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-SEP-02 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 12
            , 'autumn'
            , TO_DATE ( '01-SEP-02 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-DEC-02 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 13
            , 'winter'
            , TO_DATE ( '01-DEC-02 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-MAR-03 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 14
            , 'spring'
            , TO_DATE ( '01-MAR-03 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-JUN-03 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 15
            , 'winter'
            , TO_DATE ( '01-JUN-03 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-SEP-03 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 16
            , 'spring'
            , TO_DATE ( '01-SEP-03 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-DEC-03 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 17
            , 'summer'
            , TO_DATE ( '01-DEC-03 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-MAR-04 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 18
            , 'autumn'
            , TO_DATE ( '01-MAR-04 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-JUN-04 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 19
            , 'winter'
            , TO_DATE ( '01-JUN-04 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-SEP-04 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 20
            , 'spring'
            , TO_DATE ( '01-SEP-04 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-DEC-04 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 21
            , 'summer'
            , TO_DATE ( '01-DEC-04 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-MAR-05 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 22
            , 'autumn'
            , TO_DATE ( '01-MAR-05 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-JUN-05 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 23
            , 'winter'
            , TO_DATE ( '01-JUN-05 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-SEP-05 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 24
            , 'spring'
            , TO_DATE ( '01-SEP-05 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-DEC-05 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 25
            , 'summer'
            , TO_DATE ( '01-DEC-05 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-MAR-06 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 26
            , 'autumn'
            , TO_DATE ( '01-MAR-06 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-JUN-06 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 27
            , 'winter'
            , TO_DATE ( '01-JUN-06 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-SEP-06 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 28
            , 'spring'
            , TO_DATE ( '01-SEP-06 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-DEC-06 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 29
            , 'winter'
            , TO_DATE ( '01-DEC-06 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-MAR-07 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 30
            , 'spring'
            , TO_DATE ( '01-MAR-07 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-JUN-07 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 31
            , 'summer'
            , TO_DATE ( '01-JUN-07 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-SEP-07 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 32
            , 'autumn'
            , TO_DATE ( '01-SEP-07 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-DEC-07 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 33
            , 'winter'
            , TO_DATE ( '01-DEC-07 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-MAR-08 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 34
            , 'spring'
            , TO_DATE ( '01-MAR-08 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-JUN-08 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 35
            , 'summer'
            , TO_DATE ( '01-JUN-08 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-SEP-08 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 36
            , 'autumn'
            , TO_DATE ( '01-SEP-08 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-DEC-08 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 37
            , 'winter'
            , TO_DATE ( '01-DEC-08 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-MAR-09 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 38
            , 'spring'
            , TO_DATE ( '01-MAR-09 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-JUN-09 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 39
            , 'summer'
            , TO_DATE ( '01-JUN-09 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-SEP-09 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 40
            , 'autumn'
            , TO_DATE ( '01-SEP-09 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-DEC-09 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 41
            , 'winter'
            , TO_DATE ( '01-DEC-09 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-MAR-10 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 42
            , 'spring'
            , TO_DATE ( '01-MAR-10 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-JUN-10 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 43
            , 'winter'
            , TO_DATE ( '01-JUN-10 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-SEP-10 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 44
            , 'spring'
            , TO_DATE ( '01-SEP-10 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-DEC-10 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 45
            , 'summer'
            , TO_DATE ( '01-DEC-10 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-MAR-11 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 46
            , 'autumn'
            , TO_DATE ( '01-MAR-11 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-JUN-11 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 47
            , 'winter'
            , TO_DATE ( '01-JUN-11 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-SEP-11 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 48
            , 'spring'
            , TO_DATE ( '01-SEP-11 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-DEC-11 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 49
            , 'summer'
            , TO_DATE ( '01-DEC-11 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-MAR-12 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 50
            , 'autumn'
            , TO_DATE ( '01-MAR-12 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-JUN-12 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 51
            , 'winter'
            , TO_DATE ( '01-JUN-12 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-SEP-12 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 52
            , 'spring'
            , TO_DATE ( '01-SEP-12 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-DEC-12 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 53
            , 'summer'
            , TO_DATE ( '01-DEC-12 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-MAR-13 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 54
            , 'autumn'
            , TO_DATE ( '01-MAR-13 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-JUN-13 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 55
            , 'winter'
            , TO_DATE ( '01-JUN-13 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-SEP-13 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 56
            , 'spring'
            , TO_DATE ( '01-SEP-13 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-DEC-13 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 57
            , 'winter'
            , TO_DATE ( '01-DEC-13 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-MAR-14 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 58
            , 'spring'
            , TO_DATE ( '01-MAR-14 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-JUN-14 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );

INSERT INTO periods ( per_id
                    , per_desc
                    , per_begin
                    , per_end )
     VALUES ( 59
            , 'summer'
            , TO_DATE ( '01-JUN-14 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' )
            , TO_DATE ( '01-SEP-14 00:00:00'
                      , 'DD-MON-RR HH24:MI:SS' ) );


COMMIT;

GRANT DELETE,INSERT,UPDATE,SELECT ON periods TO u_dw_cleansing;