with op as (
	select * from {{ ref('stg_order_product') }}
),
orders as (
	select * from {{ ref('stg_order') }}
),
dt as (
	select * from {{ ref('dim_date') }}
),
prod as (
	select * from {{ ref('stg_product') }}
),
final as (
	select 
		op.product_id,
		dt.year,
		dt.quarter,
		dt.month,
		count(op.product_id) as volume,
		sum(prod.supplier_price) as cost,
		sum(op.purchased_price) as received,
		( sum(op.purchased_price) - sum(prod.supplier_price) ) as profit
	from op
	left join orders on op.order_id = orders.order_id
	left join prod on op.product_id = prod.product_id
	left join dt on orders.order_date = dt.date_key
	group by op.product_id, dt.year, dt.quarter, dt.month
)
select * 
from final 
