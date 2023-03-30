with source as (
	select * from {{ source('raw','orders') }}
),
renamed as (
	select 
		id as orders_id,
		customer_id,		
		shipping_address_id,
		order_date,
		po_number,
		tax,
		total
	from source
)
select * 
from renamed
