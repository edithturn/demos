select_query = "SELECT * FROM sharded_table WHERE id = %s"

with conn.cursor() as cursor:
    cursor.execute(select_query, (5,))
    result = cursor.fetchone()
    print(result)