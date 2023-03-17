
  create view "template1"."staging"."stg_order_product__dbt_tmp" as (
    with source as (
	select * from "template1"."raw"."order_product"
),
renamed as (
	select 
		order_id,
		product_id,
		quantity,
		purchased_price,
		subtotal
	from source
)
select * 
from renamed
  );