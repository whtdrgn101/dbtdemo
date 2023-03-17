with source as (
	select * from "template1"."raw"."product"
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