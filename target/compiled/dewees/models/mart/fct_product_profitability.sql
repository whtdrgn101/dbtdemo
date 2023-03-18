with orders as (
	select * from "template1"."mart"."dim_order"
),
dt as (
	select * from "template1"."mart"."dim_date"
),
prod as (
	select * from "template1"."mart"."dim_product"
),
final as (
	select 
		orders.product_id,
		dt.year,
		dt.quarter,
		dt.month,
		sum(orders.quantity) as volume,
		sum(prod.supplier_price * orders.quantity) as cost,
		sum(orders.subtotal) as received,
		( sum(orders.subtotal) - sum(prod.supplier_price * orders.quantity) ) as profit
	from orders
	left join prod on orders.product_id = prod.product_id
	left join dt on orders.order_date = dt.date_key
	group by orders.product_id, dt.year, dt.quarter, dt.month
)
select * 
from final