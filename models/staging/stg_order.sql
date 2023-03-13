with source as (
	select * from {{ source('raw','order') }}
),
renamed as (
	select 
		id as order_id,
		user_id as customer_id,		
		order_date,
		total,
		shipping_address_id
	from source
)
select * 
from renamed
