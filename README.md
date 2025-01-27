Python Multi-Storage File Management API

This project provides a Python API for downloading a specific Google Drive file and storing it in different storage systems. The supported storage options include:

Local filesystem storage

AWS DynamoDB

Non-relational database (MongoDB)

The code uses an object-oriented approach, following the strategy pattern, with a unified interface for all storage systems.

Features

Download Google Drive Files:

Supports downloading public files from Google Drive.

Multiple Storage Systems:

Save files to the local filesystem.

Save files to AWS DynamoDB.

Save files to a MongoDB collection.

Extensible Architecture:

Easily add new storage systems by implementing the StorageSystem interface.

Requirements

Python Version

Python 3.7 or higher

Dependencies

Install the required libraries:

pip install boto3 pymongo requests

Setup and Configuration

1. AWS DynamoDB

Create a DynamoDB table in your AWS account:

Table name: DriveFiles

Primary key: file_id (String)

Configure your AWS credentials locally using the AWS CLI:

aws configure

Provide your Access Key ID, Secret Access Key, and the appropriate region.

Ensure the table exists in the specified region.

2. MongoDB

Set up a MongoDB instance:

Use a local MongoDB server or a cloud-based service like MongoDB Atlas.

Create a database called FileStorage and a collection called DriveFiles.

Update the MongoDB connection URI in the script.

3. Local Storage

Files will be saved in a directory called downloaded_files by default.

The directory is automatically created if it doesn’t exist.

Usage

Step 1: Download File from Google Drive

Replace <YOUR_FILE_ID> in the script with the Google Drive file ID of the file you want to download.

Step 2: Run the Script

Run the script to test saving the downloaded file in all storage systems:

python script_name.py

Step 3: Check Storage Systems

Local Storage: Verify that the file is saved in the downloaded_files directory.

DynamoDB: Check the DriveFiles table in your AWS Management Console.

MongoDB: Query the DriveFiles collection to verify the file metadata and content.

Code Structure

Abstract Storage Class

from abc import ABC, abstractmethod

class StorageSystem(ABC):
    @abstractmethod
    def save_file(self, file_id, file_name, content):
        pass

This abstract class enforces a unified interface for all storage implementations.

Local Storage

class LocalStorage(StorageSystem):
    def save_file(self, file_id, file_name, content):
        ...

Stores files in the local filesystem.

DynamoDB Storage

class DynamoDBStorage(StorageSystem):
    def save_file(self, file_id, file_name, content):
        ...

Stores file metadata and content in AWS DynamoDB.

MongoDB Storage

class NonRelationalDBStorage(StorageSystem):
    def save_file(self, file_id, file_name, content):
        ...

Stores file metadata and content in MongoDB.

Example Output

Successful File Download and Storage:

File downloaded successfully: example_file.txt
Testing storage: LocalStorage
File saved locally at: downloaded_files/example_file.txt
Testing storage: DynamoDBStorage
File metadata and content stored in DynamoDB for file: example_file.txt
Testing storage: NonRelationalDBStorage
File metadata and content stored in MongoDB for file: example_file.txt

Extending the API

To add a new storage system:

Create a new class inheriting from StorageSystem.

Implement the save_file method.

Add an instance of the new storage system to the storage_systems list in the main function.

Example:

class NewStorageSystem(StorageSystem):
    def save_file(self, file_id, file_name, content):
        # Custom logic to save file
        pass

Troubleshooting

DynamoDB Connection Issues:

Ensure AWS credentials are correctly configured.

Verify the table name and region.

MongoDB Connection Issues:

Confirm the MongoDB server is running.

Check the URI, database name, and collection name.

Google Drive File Download Errors:

Ensure the file ID is correct and the file is publicly accessible.

License

This project is licensed under the MIT License. Feel free to use and modify the code.

Author

Giuliano Crespe