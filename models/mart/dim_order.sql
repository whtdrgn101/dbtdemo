with customers as (
	select * from {{ ref('stg_customer') }}
),
addresses as (
	select * from {{ ref('stg_address') }}
),
orders as (
	select * from {{ ref('stg_order') }}
),
final as (
	select 
		orders.order_id as order_id,
		orders.customer_id as customer_id,
		orders.shipping_address_id as shipping_address_id,
		orders.order_date,
		orders.total
	from orders
	left join customers on orders.customer_id = customers.customer_id
	left join addresses on orders.shipping_address_id = addresses.address_id
)
select * 
from final 
