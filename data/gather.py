import requests

def download_public_google_drive_file(file_id):
    """
    Downloads a public Google Drive file by its file ID.

    Args:
        file_id (str): The Google Drive file ID.
        file_name (str): Optional. The name to save the file as. If not provided, it defaults to 'downloaded_file'.

    Returns:
        tuple: (file_name, file_content) where file_name is the saved file's name and file_content is its binary content.
    """
    # Construct the download URL for public files
    url = f"https://drive.google.com/uc?id={file_id}&export=download"

    # Send the GET request
    response = requests.get(url, stream=True)
    if response.status_code == 200:

        file_content = response.content
        print(f"File downloaded successfully: {file_id}")
        return file_content
    else:
        raise Exception(f"Failed to download file. Status code: {response.status_code}")