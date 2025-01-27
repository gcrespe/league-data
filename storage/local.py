import os
from .abstract import StorageSystem
from dotenv import load_dotenv

# ============================
# Local Storage Class
# ============================

class LocalStorage(StorageSystem):
    def __init__(self):
        self.save_path = os.path.join(os.getcwd(), "data")
        load_dotenv()
        return

    def save_file(self, content):
        os.makedirs(self.save_path, exist_ok=True)  # Ensure directory exists

        file_path = os.path.join(self.save_path, os.getenv('FILE_NAME'))

        with open(file_path, "wb") as f:
            f.write(content)

        print(f"File saved locally at: {file_path}")
