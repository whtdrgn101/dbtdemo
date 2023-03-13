with source as (
	select * from {{ source('raw','order_product') }}
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
