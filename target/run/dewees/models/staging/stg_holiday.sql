
  create view "orders"."staging"."stg_holiday__dbt_tmp"
    
    
  as (
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
  );