
  create view "template1"."staging"."stg_order_product__dbt_tmp" as (
    with source as (
	select * from "template1"."raw"."order_product"
),
renamed as (
	select 
		order_id,
		product_id,
		purchased_price
	from source
)
select * 
from renamed
  );