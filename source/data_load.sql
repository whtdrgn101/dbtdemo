--
-- raw.customer data load
--
TRUNCATE TABLE raw.customer CASCADE;

ALTER SEQUENCE raw.customer_id_seq RESTART WITH 1;

COPY raw.customer(first_name, last_name, customer_since_date, primary_phone, primary_email)
FROM '/tmp/raw.customer.csv'
DELIMITER ','
CSV HEADER;

ALTER SEQUENCE raw.address_id_seq RESTART WITH 1;

COPY raw.address(customer_id,name,address_line_1,address_line_2,address_line_3,city,state,postal_code)
FROM '/tmp/raw.address.csv'
DELIMITER ','
CSV HEADER;

TRUNCATE TABLE raw.product CASCADE;
TRUNCATE TABLE raw.orders CASCADE;

ALTER SEQUENCE raw.product_id_seq RESTART WITH 1;

COPY raw.product(name,manufacturer,manufacturer_part_number,internal_part_number,supplier_price,base_price)
FROM '/tmp/raw.product.csv'
DELIMITER ','
CSV HEADER;

TRUNCATE TABLE raw.holiday;

ALTER SEQUENCE raw.holiday_id_seq RESTART WITH 1;

COPY raw.holiday(date_key,name,is_work_day)
FROM '/tmp/raw.holiday.csv'
DELIMITER ','
CSV HEADER;


ALTER SEQUENCE raw.order_id_seq RESTART WITH 1;

COPY raw.orders(user_id,order_date,shipping_address_id,po_number,tax,total)
FROM '/tmp/raw.orders.csv'
DELIMITER ','
CSV HEADER;

COPY raw.order_product(order_id,product_id,quantity,purchased_price,subtotal)
FROM '/tmp/raw.order_product.csv'
DELIMITER ','
CSV HEADER;
