
  create view "orders"."staging"."stg_order_product__dbt_tmp" as (
    with source as (
	select * from "orders"."raw"."order_product"
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