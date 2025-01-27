import pandas as pd
from dotenv import load_dotenv

load_dotenv()
df = pd.read_csv('2025_LoL_esports_match_data.csv')

def get_last_10_matches(league, year, split):
    filtered_df = df[(df['league'] == league) & (df['year'] == year) & (df['split'] == split) & ((df['participantid'] == '100') | (df['participantid'] == '200'))]
    sorted_df = filtered_df.sort_values(by='date', ascending=False)
    
    return sorted_df.head(10)

def get_all_leagues():
    return df['league'].dropna().unique()

def get_all_splits_from_league(league):
    league_df = df[df['league'] == league]
    return league_df['split'].dropna().unique()


