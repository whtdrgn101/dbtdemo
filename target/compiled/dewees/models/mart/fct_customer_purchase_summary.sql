with orders as (
	select * from "orders"."mart"."dim_order"
),
dt as (
	select * from "orders"."mart"."dim_date"
),
final as (
	select 
		orders.customer_id,
		dt.year,
		dt.quarter,
		dt.month,
		sum(orders.line_total)
	from orders
	left join dt on orders.order_date = dt.date_key
	group by customer_id, dt.year, dt.quarter, dt.month
)
select * 
from final