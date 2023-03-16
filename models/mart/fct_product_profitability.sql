with orders as (
	select * from {{ ref('dim_order') }}
),
dt as (
	select * from {{ ref('dim_date') }}
),
prod as (
	select * from {{ ref('dim_product') }}
),
final as (
	select 
		orders.product_id,
		dt.year,
		dt.quarter,
		dt.month,
		count(orders.product_id) as volume,
		sum(prod.supplier_price) as cost,
		sum(orders.purchased_price) as received,
		( sum(orders.purchased_price) - sum(prod.supplier_price) ) as profit
	from orders
	left join prod on orders.product_id = prod.product_id
	left join dt on orders.order_date = dt.date_key
	group by orders.product_id, dt.year, dt.quarter, dt.month
)
select * 
from final 
