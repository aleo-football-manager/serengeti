import pandas as pd
import subprocess
from dotenv import load_dotenv
import os

# Run this command to execute script (from scripts dir):
# python3 ../scripts/import_players.py

# Load the environment variables from .env file
load_dotenv()

# Your private key (loaded from .env file)
private_key = os.getenv('PRIVATE_KEY')

# Load the CSV file
csv_file_path = '../files/players_final_u8_100.csv'
df = pd.read_csv(csv_file_path)


# Loop through each row in the dataframe
for index, row in df.iterrows():
    # Constructing the CLI command
    cli_command = (
        f"snarkos developer execute \"cost_tests_calc_v006.aleo\" \"add_player\" "
        f"\"{{player_id: {row['player_uid']}field,team_id: {row['team_id']}field,position: {row['position']}field,"
        f"attack: {row['attack']}u128,defense: {row['defense']}u128,speed: {row['speed']}u128,"
        f"power: {row['power']}u128,stamina: {row['stamina']}u128,technique: {row['technique']}u128,"
        f"goalkeeping: {row['goalkeeping']}u128}}\" --private-key \"{private_key}\" "
        f"--query \"https://node.puzzle.online\" --broadcast \"https://node.puzzle.online/testnet3/transaction/broadcast\" "
        f"--priority-fee 0"
    )

    # print(cli_command)

    # Execute the CLI command
    subprocess.run(cli_command, shell=True)

print("All players have been processed.")
