from faker import Faker
import psycopg2
import os
from datetime import date
import datetime

CUST_SQL = """
            INSERT INTO 
                raw.customer (first_name, last_name, customer_since_date, primary_phone, primary_email) 
                VALUES (%s,%s,%s,%s,%s) RETURNING id"""
ADDRESS_SQL = """
        INSERT INTO
            raw.address (customer_id, name, address_line_1, city, state, postal_code)
            VALUES (%s,%s,%s,%s,%s,%s) RETURNING id"""
ORDER_SQL = """
        INSERT INTO
            raw.orders (customer_id, order_date, shipping_address_id, tax, total)
            values(%s,%s,%s,%s,%s) RETURNING id"""
ORDER_PRODUCT_SQL = """
        INSERT INTO
            raw.order_product (order_id, product_id, quantity, purchased_price, subtotal)
            VALUES(%s,%s,%s,%s,%s) RETURNING id"""

DB_PASS = os.environ['DBPASS']

def main():

    fake = Faker()

    conn = psycopg2.connect(f"dbname=orders user=postgres password={DB_PASS}")
    cur = conn.cursor()

    for c in range(1000):
        cur.execute(CUST_SQL, (
            fake.first_name(),
            fake.last_name(),
            fake.date_between(datetime.date(1965,1,1), date.today()) ,
            fake.phone_number(),
            fake.email()
            ))
        cust_id = cur.fetchone()[0] 
        print(f"Generated customer with id of [{cust_id}]")
        cur.execute(ADDRESS_SQL, (
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
            cur.execute(ORDER_SQL, (
                cust_id,
                fake.date_between(datetime.date((date.today().year - 1),1,1), date.today()),
                address_id,
                .065,
                7500.0
            ))
            order_id = cur.fetchone()[0]
            print(f"Generated order for customer_id {cust_id} with id of {order_id}")
            for p in range(1,3):
                cur.execute(ORDER_PRODUCT_SQL,(
                    order_id,
                    p,
                    10,
                    250.0,
                    2500.0
                ))

    conn.commit()
    conn.close()

if __name__ == "__main__":
    main()