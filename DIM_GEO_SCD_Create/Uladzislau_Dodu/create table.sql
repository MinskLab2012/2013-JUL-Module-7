create table actions
(action_id number(10) primary key,
geo_id number(10),
type_id number(10),
value_new number (10),
action_dt date
)

select * from ACTIONS