with source as (
	select * from "template1"."raw"."orders"
),
renamed as (
	select 
		id as order_id,
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