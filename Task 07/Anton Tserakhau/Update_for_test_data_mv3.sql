UPDATE T_OPERATIONS
set total_price_dol=total_price_dol*2
where RESTAURANT_ID in 
(Select REST.RESTAURANT_ID 
from u_dw_references.lc_cities cities 
left join T_RESTAURANTS rest on REST.RESTAURANT_GEO_ID=CITIES.GEO_ID
left join T_OPERATIONS oper on OPER.RESTAURANT_ID=REST.RESTAURANT_ID
where CITY_DESC='Hardy');