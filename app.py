import os
from data.gather import download_public_google_drive_file
from storage.local import LocalStorage
from dotenv import load_dotenv
from .data import get_all_leagues
from .data import get_all_splits_from_league
from .data import get_last_10_matches
load_dotenv()

def main():

    try:

        storage = os.getenv('STORAGE_METHOD')

        match(storage):
            case 'local':
                file = download_public_google_drive_file(os.getenv('FILE_ID'))
                localStorage = LocalStorage()
                localStorage.save_file(file)
            case 'mongodb':
                return
            case 'dynamodb':
                return
            case _:
                file = download_public_google_drive_file(os.getenv('FILE_ID'))
                localStorage = LocalStorage()
                localStorage.save_file(file)

        league = 'LFL2'  # Example league
        year = '2025'  # Example year
        split = 'Winter'  # Example split

        last_10_matches = get_last_10_matches(league, year, split)
        print("Last 10 matches in the league:", last_10_matches)

        all_leagues = get_all_leagues()
        print("\nAll Leagues:", all_leagues)

        all_splits = get_all_splits_from_league(league)

        print("\nAll Splits for the league:", all_splits)
        
    except Exception as e:

        print(f"An error occurred: {e}")


if __name__ == "__main__":
    main()
