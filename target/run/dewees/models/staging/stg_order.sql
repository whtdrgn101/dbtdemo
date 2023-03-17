
  create view "template1"."staging"."stg_order__dbt_tmp" as (
    with source as (
	select * from "template1"."raw"."orders"
),
renamed as (
	select 
		id as order_id,
		user_id as customer_id,		
		shipping_address_id,
		order_date,
		po_number,
		tax,
		total
	from source
)
select * 
from renamed
  );