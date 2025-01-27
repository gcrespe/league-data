from abc import ABC, abstractmethod

# ============================
# Abstract Storage Class
# ============================

class StorageSystem(ABC):
    @abstractmethod
    def save_file(self, content):
        """
        Abstract method to save a file into a storage system.
        Args:
            file_id (str): The unique identifier of the file.
            file_name (str): The name of the file.
            content (bytes): The content of the file.
        """
        pass