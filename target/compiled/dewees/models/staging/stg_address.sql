with source as (
	select * from "template1"."raw"."address"
),
renamed as (
	select 
		id as address_id,
		customer_id,
		address_line_1,
		address_line_2,
		address_line_3,
		city,
		state,
		postal_code
	from source
)
select * 
from renamed