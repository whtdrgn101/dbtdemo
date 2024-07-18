
  create view "orders"."staging"."stg_customer__dbt_tmp"
    
    
  as (
    with source as (
	select * from "orders"."raw"."customer"
),
renamed as (
	select 
		id as customer_id,
		first_name,
		last_name,
		customer_since_date,
		primary_phone,
		primary_email
	from source
)
select * 
from renamed
  );