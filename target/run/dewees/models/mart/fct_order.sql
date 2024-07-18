
  
    

  create  table "orders"."mart"."fct_order__dbt_tmp"
  
  
    as
  
  (
    with orders as (
	select * from "orders"."mart"."dim_order"
),
products as (
	select * from "orders"."mart"."dim_product"
),
final as (
	select 
		orders.order_id,
		orders.customer_id,
		products.product_id,
		orders.shipping_address_id,
		orders.order_date as date_key,
		orders.subtotal,
		(1.0 - round( cast((products.base_price / orders.purchased_price) as numeric), cast(2 as smallint)) ) as discount_pct
	from orders
	left join products on orders.product_id = products.product_id
)
select * 
from final
  );
  