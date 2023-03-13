with source as (
	select * from {{ source('raw','customer') }}
),
renamed as (
	select 
		id as customer_id,
		first_name,
		last_name,
		primary_phone,
		primary_email
	from source
)
select * 
from renamed
