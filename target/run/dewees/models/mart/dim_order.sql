
  
    

  create  table "template1"."mart"."dim_order__dbt_tmp"
  as (
    with orders as (
	select * from "template1"."staging"."stg_order"
),
op as (
	select * from "template1"."staging"."stg_order_product"
),
final as (
	select 
		orders.order_id,
		orders.customer_id,
		orders.shipping_address_id,
		orders.order_date,
		orders.po_number,
		orders.tax,
		op.quantity,
		op.product_id,
		op.purchased_price,
		op.subtotal
	from orders
	left join op on orders.order_id = op.order_id
)
select * 
from final
  );
  