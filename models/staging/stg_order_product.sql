with source as (
	select * from {{ source('raw','order_product') }}
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
