with orders as (
	select * from "template1"."staging"."stg_order"
),
op as (
	select * from "template1"."staging"."stg_order_product"
),
final as (
	select 
		orders.order_id,
		orders.customer_id,
		orders.shipping_address_id,
		op.product_id,
		orders.order_date,
		op.purchased_price
	from orders
	left join op on orders.order_id = op.order_id
)
select * 
from final