
  create view "orders"."staging"."stg_order__dbt_tmp"
    
    
  as (
    with source as (
	select * from "orders"."raw"."orders"
),
renamed as (
	select 
		id as order_id,
		customer_id,		
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