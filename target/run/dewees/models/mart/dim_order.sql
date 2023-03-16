
  
    

  create  table "template1"."mart"."dim_order__dbt_tmp"
  as (
    with customers as (
	select * from "template1"."staging"."stg_customer"
),
addresses as (
	select * from "template1"."staging"."stg_address"
),
orders as (
	select * from "template1"."staging"."stg_order"
),
final as (
	select 
		orders.order_id as order_id,
		orders.customer_id as customer_id,
		orders.shipping_address_id as shipping_address_id,
		orders.order_date,
		orders.total,
		addresses.address_line_1 as shipping_address_line1,
		addresses.address_line_2 as shipping_address_line2,
		addresses.address_line_3 as shipping_address_line3,
		addresses.city as shipping_address_city,
		addresses.state as shipping_address_state,
		addresses.postal_code as shipping_address_postal_code
	from orders
	left join customers on orders.customer_id = customers.customer_id
	left join addresses on orders.shipping_address_id = addresses.address_id
)
select * 
from final
  );
  