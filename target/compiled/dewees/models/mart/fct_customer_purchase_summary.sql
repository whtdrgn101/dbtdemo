with orders as (
	select * from "template1"."staging"."stg_order"
),
op as (
	select * from "template1"."staging"."stg_order_product"
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
		sum(op.purchased_price)
	from orders
	left join op on op.order_id = orders.order_id
	left join dt on orders.order_date = dt.date_key
	group by customer_id, dt.year, dt.quarter, dt.month
)
select * 
from final