import psycopg2

# Replace these values with your actual Citus Coordinator credentials
host = "localhost"
port = 5432
database = "postgres"
user = "postgres"
password = "password"

# Connect to the Citus Coordinator
connection = psycopg2.connect(
    host=host,
    port=port,
    database=database,
    user=user,
    password=password
)

# Create a cursor to execute queries
cursor = connection.cursor()

# Query data from the sharded table
query = "SELECT * FROM companies"
cursor.execute(query)

# Fetch and print the results
results = cursor.fetchall()
for row in results:
    print(row)

# Close the cursor and the connection
cursor.close()
connection.close()

# Another example of such an operation would be to run transactions which span multiple tables. Let’s say you want to delete a campaign and all its associated ads, you could do it atomically by running:
# Example https://docs.citusdata.com/en/v11.3/get_started/tutorial_multi_tenant.html#data-model-and-sample-data

""" Delete
BEGIN;
DELETE FROM campaigns WHERE id = 46 AND company_id = 5;
DELETE FROM ads WHERE campaign_id = 46 AND company_id = 5;
COMMIT;

# Select
SELECT name, cost_model, state, monthly_budget
FROM campaigns
WHERE company_id = 5
ORDER BY monthly_budget DESC
LIMIT 10;
"""

# library
#pip install psycopg2


