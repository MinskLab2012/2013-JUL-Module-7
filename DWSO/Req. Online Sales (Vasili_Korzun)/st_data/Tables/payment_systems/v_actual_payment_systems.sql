CREATE OR REPLACE VIEW v_actual_payment_systems
AS
select * from
(
   SELECT payment_system_id,
          payment_system_code,
          payment_system_desc,
          payment_system_type_id,
          payment_system_type_desc,
          action_dt,
          DECODE (MAX (action_dt) OVER (PARTITION BY payment_system_id),
                  action_dt, 1,
                  0)
             AS is_actual
     FROM (SELECT payment_systems.payment_system_id,
                  payment_system_code,
                  payment_system_desc,
                  payment_systems_types.payment_system_type_id,
                  payment_system_type_desc,
                  action_date AS action_dt
             FROM payment_systems
                  LEFT JOIN payment_systems_types
                     ON payment_systems.payment_system_type_id =
                           payment_systems_types.payment_system_type_id
                  LEFT JOIN payment_systems_actions
                     ON payment_systems.payment_system_id =
                           payment_systems_actions.payment_system_id)
                           ) where is_actual = 1;