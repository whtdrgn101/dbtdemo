
      
        
            delete from "orders"."mart"."dim_order"
            using "dim_order__dbt_tmp102908456005"
            where (
                
                    "dim_order__dbt_tmp102908456005".order_id = "orders"."mart"."dim_order".order_id
                    and 
                
                    "dim_order__dbt_tmp102908456005".product_id = "orders"."mart"."dim_order".product_id
                    
                
                
            );
        
    

    insert into "orders"."mart"."dim_order" ("order_id", "customer_id", "shipping_address_id", "order_date", "po_number", "product_id", "quantity", "purchased_price", "tax", "subtotal", "line_total")
    (
        select "order_id", "customer_id", "shipping_address_id", "order_date", "po_number", "product_id", "quantity", "purchased_price", "tax", "subtotal", "line_total"
        from "dim_order__dbt_tmp102908456005"
    )
  