with orders as (
	select * from {{ ref('stg_order') }}
),
final as (
	select 
		orders.order_id,
		orders.customer_id,
		orders.shipping_address_id,
		orders.order_date as date_key,
		orders.total
	from orders
)
select * 
from final 
