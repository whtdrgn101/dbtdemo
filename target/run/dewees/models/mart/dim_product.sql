
  
    

  create  table "template1"."mart"."dim_product__dbt_tmp"
  as (
    with prod as (
	select * from "template1"."staging"."stg_product"
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
  