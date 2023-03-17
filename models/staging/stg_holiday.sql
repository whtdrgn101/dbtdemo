with source as (
	select * from {{ source('raw','holiday') }}
),
renamed as (
	select 
		date_key,		
		name,	
		is_work_day
	from source
)
select * 
from renamed
