with orders as (
	select * from {{ ref('dim_order') }}
),
products as (
	select * from {{ ref('dim_product') }}
),
final as (
	select 
		orders.order_id,
		orders.customer_id,
		products.product_id,
		orders.shipping_address_id,
		orders.order_date as date_key,
		orders.subtotal,
		(1.0 - orders.purchased_price / products.base_price) as discount_pct
	from orders
	left join products on orders.product_id = products.product_id
)
select * 
from final 
