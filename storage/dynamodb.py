import boto3
import pandas as pd
from datetime import datetime
from decimal import Decimal
from abstract import StorageSystem

class DynamoDBStorage(StorageSystem):
    def __init__(self, table_name_prefix="LEAGUE_MATCHES_2024", region_name="us-east-1"):
        self.dynamodb = boto3.resource("dynamodb", region_name=region_name)
        self.table_name = table_name_prefix
        self.client = boto3.client("dynamodb", region_name=region_name)
        self.table = None

    def create_table(self, csv_data):
        
        """Create a DynamoDB table based on the CSV column names and types."""
        # Load the CSV data into a pandas dataframe
        df = pd.read_csv(csv_data)
        
        # Extract column names and infer types from the dataframe
        attributes = []
        key_schema = []
        attribute_definitions = []
        
        for column in df.columns:
            # For simplicity, let's assume all columns are strings except numerical ones
            attribute_type = "S"  # Default type is string
            if pd.api.types.is_numeric_dtype(df[column]):
                attribute_type = "N"  # Numeric type
            elif pd.api.types.is_datetime64_any_dtype(df[column]):
                attribute_type = "S"  # Date can be stored as string (ISO format)

            attributes.append((column, attribute_type))

            # Define the key schema - assuming "file_id" as the primary key
            if column == "file_id":
                key_schema.append({"AttributeName": column, "KeyType": "HASH"})

            attribute_definitions.append({
                "AttributeName": column,
                "AttributeType": attribute_type
            })
        
        # Create the table with the extracted schema
        try:
            print(f"Creating DynamoDB table: {self.table_name}")
            self.client.create_table(
                TableName=self.table_name,
                KeySchema=key_schema,
                AttributeDefinitions=attribute_definitions,
                ProvisionedThroughput={
                    "ReadCapacityUnits": 5,
                    "WriteCapacityUnits": 5
                }
            )
            print(f"Table {self.table_name} created successfully.")
            self.table = self.dynamodb.Table(self.table_name)
        except self.client.exceptions.ResourceInUseException:
            print(f"Table {self.table_name} already exists.")
            self.table = self.dynamodb.Table(self.table_name)

    def save_file(self, file_id, file_name, content):
        """Insert rows into DynamoDB, row by row."""
        # Decode the file content and load it into a pandas DataFrame
        content_str = content.decode("utf-8", errors="replace")
        df = pd.read_csv(pd.compat.StringIO(content_str))

        # Create the table if it doesn't exist
        self.create_table(content_str)
        
        # Iterate over each row and insert into DynamoDB
        for _, row in df.iterrows():
            self.insert_row(file_id, file_name, row)

    def insert_row(self, file_id, file_name, row):
        """Insert a single row into DynamoDB."""
        # Add metadata (file_id, file_name, timestamp)
        item = row.to_dict()
        item['file_id'] = file_id
        item['file_name'] = file_name
        item['timestamp'] = datetime.now(datetime.UTC).isoformat()

        # Convert float values to Decimal for DynamoDB compatibility
        for key, value in item.items():
            if isinstance(value, float):
                item[key] = Decimal(str(value))

        # Insert the row into DynamoDB
        self.table.put_item(Item=item)
        print(f"Row inserted into DynamoDB: {item}")