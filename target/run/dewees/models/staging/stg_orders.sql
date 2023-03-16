
  
    

  create  table "template1"."public_staging"."stg_orders__dbt_tmp"
  as (
    

with source as (
	select * from "template1"."raw"."order"
),
renamed as (
	select 
		id as order_id,
		user_id as customer_id,		
		order_date,
		total,
		shipping_address_id
	from source
)
select * 
from renamed
  );
  