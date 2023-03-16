
  
    

  create  table "template1"."mart"."fct_order__dbt_tmp"
  as (
    with orders as (
	select * from "template1"."mart"."dim_order"
),
products as (
	select * from "template1"."mart"."dim_product"
),
final as (
	select 
		orders.order_id,
		orders.customer_id,
		products.product_id,
		orders.shipping_address_id,
		orders.order_date as date_key,
		orders.purchased_price,
		(1.0 - orders.purchased_price / products.base_price) as discount_pct
	from orders
	left join products on orders.product_id = products.product_id
)
select * 
from final
  );
  