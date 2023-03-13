with source as (
	select * from {{ source('raw','product') }}
),
renamed as (
	select 
		id as product_id,
		name,
		base_price
	from source
)
select * 
from renamed
