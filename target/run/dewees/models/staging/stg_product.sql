
  create view "orders"."staging"."stg_product__dbt_tmp" as (
    with source as (
	select * from "orders"."raw"."product"
),
renamed as (
	select 
		id as product_id,
		name,
		manufacturer,
		manufacturer_part_number,
		internal_part_number,
		supplier_price,
		base_price
	from source
)
select * 
from renamed
  );