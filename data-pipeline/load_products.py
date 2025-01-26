import requests
import pandas as pd
import pandas_gbq  # Import the pandas_gbq module
from google.cloud import bigquery
from google.oauth2 import service_account

# Step 1: Fetch data from the API
url = 'https://fakestoreapi.com/products'
response = requests.get(url)
data = response.json()

# Step 2: Convert the data into a Pandas DataFrame
df = pd.DataFrame(data)

# Step 3: Set up BigQuery client (explicit authentication)
key_path = '/Users/rowanpersson/Downloads/symbolic-base-447322-b6-fcd88c3ad057.json'
credentials = service_account.Credentials.from_service_account_file(key_path)
client = bigquery.Client(credentials=credentials, project=credentials.project_id)

# Step 4: Specify the dataset and table to load the data into
dataset_id = 'symbolic-base-447322-b6.store_schema'
table_id = f'{dataset_id}.products'  # Table name will be "products"

# Step 5: Load data to BigQuery using pandas_gbq to automatically create the table
pandas_gbq.to_gbq(df, destination_table=table_id, project_id='symbolic-base-447322-b6', if_exists='replace')  # 'replace' will create the table and overwrite any existing data

print(f"Loaded {len(df)} rows to {table_id}")