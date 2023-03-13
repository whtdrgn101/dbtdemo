with customers as (
	select * from {{ ref('stg_customer') }}
),
addresses as (
	select * from {{ ref('stg_address') }}
),
final as (
	select 
		customers.customer_id,
		addresses.address_id,
		customers.first_name,
		customers.last_name,
		customers.primary_phone,
		customers.primary_email,
		addresses.address_line_1 as shipping_address_line1,
		addresses.address_line_2 as shipping_address_line2,
		addresses.address_line_3 as shipping_address_line3,
		addresses.city as shipping_address_city,
		addresses.state as shipping_address_state,
		addresses.postal_code as shipping_address_postal_code
	from customers
	left join addresses on addresses.customer_id = customers.customer_id
)
select * 
from final 
