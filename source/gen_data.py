from faker import Faker
import psycopg2
import os
from datetime import date
import datetime

fake = Faker()

dbpass = os.environ['DBPASS']

cust_sql = """
        INSERT INTO 
            raw.customer (first_name, last_name, customer_since_date, primary_phone, primary_email) 
            VALUES (%s,%s,%s,%s,%s) RETURNING id"""
address_sql = """
        INSERT INTO
            raw.address (customer_id, name, address_line_1, city, state, postal_code)
            VALUES (%s,%s,%s,%s,%s,%s) RETURNING id"""
order_sql = """
        INSERT INTO
            raw.orders (customer_id, order_date, shipping_address_id, tax, total)
            values(%s,%s,%s,%s,%s) RETURNING id"""
order_product_sql = """
        INSERT INTO
            raw.order_product (order_id, product_id, quantity, purchased_price, subtotal)
            VALUES(%s,%s,%s,%s,%s) RETURNING id"""

conn = psycopg2.connect(f"dbname=orders user=postgres password={dbpass}")
cur = conn.cursor()

for c in range(100):
    cur.execute(cust_sql, (
        fake.first_name(),
        fake.last_name(),
        fake.date_between(datetime.date(1965,1,1), date.today()) ,
        fake.phone_number(),
        fake.email()
        ))
    cust_id = cur.fetchone()[0] 
    print(f"Generated customer with id of [{cust_id}]")
    cur.execute(address_sql, (
        cust_id,
        "primary",
        fake.street_address(),
        fake.city(),
        fake.state_abbr(),
        fake.postalcode()
        ))
    address_id = cur.fetchone()[0]
    print(f"Generated address for cust_id {cust_id} with id of {address_id}")
    for o in range(100):
        cur.execute(order_sql, (
            cust_id,
            fake.date_between(datetime.date((date.today().year - 1),1,1), date.today()),
            address_id,
            .065,
            75.0
        ))
        order_id = cur.fetchone()[0]
        print(f"Generated order for customer_id {cust_id} with id of {order_id}")
        for p in range(1,3):
            cur.execute(order_product_sql,(
                order_id,
                p,
                1,
                25.0,
                25.0
            ))
        
