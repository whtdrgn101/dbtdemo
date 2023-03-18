with orders as (
	select * from {{ ref('stg_order') }}
),
op as (
	select * from {{ ref('stg_order_product') }}
),
final as (
	select 
		orders.order_id,
		orders.customer_id,
		orders.shipping_address_id,
		orders.order_date,
		orders.po_number,
		op.product_id,
		op.quantity,
		op.purchased_price,
		orders.tax,
		op.subtotal,
		(orders.tax * op.subtotal) + op.subtotal as line_total
	from orders
	left join op on orders.order_id = op.order_id
)
select * 
from final 
