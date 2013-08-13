CREATE TABLE tmp_transactions_info AS 
SELECT t.event_dt    
 , t.transaction_id 
 , cust_send_id
 , s_c.CUST_FIRST_NAME CUST_SEND_F_N
 , s_c.CUST_LAST_NAME CUST_SEND_L_N
 , s_c.CUST_GENDER CUST_SEND_GEN
 , s_c.CUST_LEVEL_INCOME CUST_SEND_LEV
 , s_c.CUST_BIRTH_YEAR CUST_SEND_BIRTH
 , s_c.CUST_COUNTRY_DESC CUST_SEND_CNTR
 , s_c.CUST_PASS_NUMBER CUST_SEND_PASS_NUM
 , s_c.CUST_BALANCE CUST_SEND_BAL
 , r_c.CUST_FIRST_NAME CUST_REC_F_N
 , r_c.CUST_LAST_NAME CUST_REC_L_N
 , r_c.CUST_GENDER CUST_REC_GEN
 , r_c.CUST_LEVEL_INCOME CUST_REC_LEV
 , r_c.CUST_BIRTH_YEAR CUST_REC_BIRTH
 , r_c.CUST_COUNTRY_DESC CUST_REC_CNTR
 , r_c.CUST_PASS_NUMBER CUST_REC_PASS_NUM
 , r_c.CUST_BALANCE CUST_REC_BAL
 , cust_rec_id    
 , t.cntr_send_desc   
 , t.cntr_rec_desc   
 , t.currency_code
 , curr.currency_name
 , curr.currency_desc
 , curr.currency_to_dollar
 , curr.currency_type_name
 , t.tariff_code
 , tar.tariff_name
 , tar.tariff_type
 , tar.tariff_payment_sum
 , tar.tariff_max_payment
 , tar.tariff_min_payment
 , t.operation_id
 , op.operation_name
 , op.operation_max_amount
 , op.operation_min_amount
 , t.operation_method_id
 , m.operation_method_name
 , m.operation_method_type
 , t.payment_sum
  
FROM u_dw_ext_references.tmp_transactions t LEFT OUTER JOIN
     U_DW_EXT_REFERENCES.tmp_customers s_c ON (t.cust_send_id = s_c.cust_id)
     LEFT OUTER JOIN
     U_DW_EXT_REFERENCES.tmp_customers r_c ON (t.cust_rec_id = r_c.cust_id)
     LEFT OUTER JOIN
     U_DW_EXT_REFERENCES.tmp_currency curr ON (t.currency_code = curr.currency_code)
     LEFT OUTER JOIN
     U_DW_EXT_REFERENCES.tmp_tariffs tar ON (t.tariff_code = tar.tariff_code)
     LEFT OUTER JOIN
     U_DW_EXT_REFERENCES.tmp_operations op ON (t.operation_id = op.operation_id)
     LEFT OUTER JOIN
     U_DW_EXT_REFERENCES.tmp_methods m ON (t.operation_method_id = m.operation_method_id);