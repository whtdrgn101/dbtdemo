with source as (
	select * from "orders"."raw"."holiday"
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