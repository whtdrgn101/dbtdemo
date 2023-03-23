
  
    

  create  table "orders"."mart"."dim_product__dbt_tmp"
  as (
    with prod as (
	select * from "orders"."staging"."stg_product"
),
final as (
	select 
		prod.product_id,
		prod.name,
		prod.supplier_price,
		prod.base_price
	from prod
)
select * 
from final
  );
  