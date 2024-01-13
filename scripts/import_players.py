import pandas as pd
import subprocess
from dotenv import load_dotenv
import os

# Run this command to execute script (from scripts dir):
# python3 /home/arjanjohan/git/aleo/serengeti/scripts/import_players.py

# Load the environment variables from .env file
load_dotenv()

# Your private key (loaded from .env file)
private_key = os.getenv('PRIVATE_KEY_MAIN')

# Load the CSV file
csv_file_path = '../files/players_final_u8_short.csv'
df = pd.read_csv(csv_file_path)


# Loop through each row in the dataframe
for index, row in df.iterrows():
    # Constructing the CLI command
    cli_command = (
        f"snarkos developer execute \"football_random_v011.aleo\" \"add_player\" "
        f"\"{{player_id: {row['player_uid']}u8,team_id: {row['team_id']}u8,position: {row['position']}field,"
        f"attack: {row['attack']}u8,defense: {row['defense']}u8,speed: {row['speed']}u8,"
        f"power: {row['power']}u8,stamina: {row['stamina']}u8,technique: {row['technique']}u8,"
        f"goalkeeping: {row['goalkeeping']}u8}}\" --private-key \"{private_key}\" "
        f"--query \"https://api.explorer.aleo.org/v1\" --broadcast \"https://api.explorer.aleo.org/v1/testnet3/transaction/broadcast\" "
        f"--priority-fee 1000000"
    )

    # print(cli_command)

    # Execute the CLI command
    subprocess.run(cli_command, shell=True)

print("All players have been processed.")
