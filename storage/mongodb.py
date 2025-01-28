from abstract import StorageSystem
from datetime import datetime
from dotenv import load_dotenv
import pandas as pd
import pymongo
import os

# ============================
# Mongo Database Storage Class (MongoDB)
# ============================

load_dotenv()
uri = "mongodb+srv://giulianocrespe:F7Bgh5allnqYyhKi@cluster0.7ucza.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"
path = os.join.path('C:/Users/Giuliano Crespe/Desktop/league-data/data/2025_LoL_esports_match_data.csv')

class MongoDBStorage(StorageSystem):
    
    def __init__(self, uri, database_name, collection_name):
        self.client = pymongo.MongoClient(uri)
        self.db = self.client.get_database(database_name)
        self.collection = self.db[collection_name]

    def save_file(self, file_id, file_name, content):
        df = pd.read_csv(path)
        document = {
            "file_id": file_id,
            "file_name": file_name,
            "content": content.decode("utf-8", errors="replace"),
            "timestamp": datetime.utcnow().isoformat(),
        }
        self.collection.insert_one(document)
        print(f"File metadata and content stored in MongoDB for file: {file_name}")