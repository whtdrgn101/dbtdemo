
  
    

  create  table "template1"."mart"."fct_order__dbt_tmp"
  as (
    with orders as (
	select * from "template1"."staging"."stg_order"
),
products as (
	select * from "template1"."staging"."stg_product"
),
op as (
	select * from "template1"."staging"."stg_order_product"
),
final as (
	select 
		orders.order_id,
		orders.customer_id,
		products.product_id,
		orders.shipping_address_id,
		orders.order_date as date_key,
		op.purchased_price,
		(1.0 - op.purchased_price / products.base_price) as discount_pct
	from orders
	left join op on op.order_id = orders.order_id
	left join products on op.product_id = products.product_id
)
select * 
from final
  );
  