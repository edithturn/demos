import psycopg2

conn = psycopg2.connect(
    host="localhost",
    port="5432",
    database="postgres",
    user="postgres",
    password="password"
)

#create_table_query = """
#CREATE TABLE sharded_table (
#    id SERIAL PRIMARY KEY,
#    data TEXT
#)
#DISTRIBUTED BY (id);
#"""insert.py
#with conn.cursor() as cursor:
#    cursor.execute(create_table_query)
#conn.commit()


insert_query = "INSERT INTO companies VALUES (5000, 'Percona', 'https://randomurl/image.png', now(), now());"

with conn.cursor() as cursor:
    for i in range(100):
        cursor.execute(insert_query, (f"Data {i}",))
conn.commit()