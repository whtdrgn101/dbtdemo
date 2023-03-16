with source as (
	select * from "template1"."raw"."product"
),
renamed as (
	select 
		id as product_id,
		name,
		supplier_price,
		base_price
	from source
)
select * 
from renamed