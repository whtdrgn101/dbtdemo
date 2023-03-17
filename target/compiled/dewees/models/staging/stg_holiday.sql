with source as (
	select * from "template1"."raw"."holiday"
),
renamed as (
	select 
		date_key,		
		name,	
		description,
		is_work_day
	from source
)
select * 
from renamed