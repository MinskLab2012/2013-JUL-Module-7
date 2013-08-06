select * from(  SELECT event_dt
       , company_name
       , avg(avg_pct) avg_pct
       , sum(sum_income) sum_income
       , count(count_trans) count_trans
    FROM u_dw_ext_references.agr_trans
GROUP BY ( event_dt, company_name )
)
model
dimension by (event_dt, company_name)
measures(avg_pct avg_pct , 0 sum_income, 0 count_trans)
rules (avg_pct[any,'Total'] = avg(avg_pct) over (partition by event_dt,company_name order by (company_name)),
sum_income[any,'Total'] = sum(sum_income)over (partition by event_dt,company_name order by (company_name)),
count_trans [ any,'Total'] = count(count_trans) over (partition by event_dt,company_name order by (company_name)))
order by 3

select * from u_dw_ext_references.agr_trans