with orders as (
	select * from "template1"."mart"."dim_order"
),
dt as (
	select * from "template1"."mart"."dim_date"
),
final as (
	select 
		orders.customer_id,
		dt.year,
		dt.quarter,
		dt.month,
		sum(orders.purchased_price)
	from orders
	left join dt on orders.order_date = dt.date_key
	group by customer_id, dt.year, dt.quarter, dt.month
)
select * 
from final