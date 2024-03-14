import pandas as pd
import subprocess
from dotenv import load_dotenv
import os
import time

# Run this command to execute script (from scripts dir):
# python3 ../scripts/test_formation.py

# Load the environment variables from .env file
load_dotenv()

# Your private key (loaded from .env file)
private_key = os.getenv('PRIVATE_KEY')

# contract name
contract = "formation_tests_v002.aleo"

# Load the CSV file
csv_file_path = '../files/players_final_u8_short.csv'
df = pd.read_csv(csv_file_path)


# Loop through each row in the dataframe
for index, row in df.iterrows():
    # Constructing the CLI command
    cli_command = (
        f"snarkos developer execute \"{contract}\" \"add_player\" "
        f"\"{{player_id: {row['player_uid']}u8,team_id: {row['team_id']}u8,position: {row['position']}field,"
        f"attack: {row['attack']}u8,defense: {row['defense']}u8,speed: {row['speed']}u8,"
        f"power: {row['power']}u8,stamina: {row['stamina']}u8,technique: {row['technique']}u8,"
        f"goalkeeping: {row['goalkeeping']}u8}}\" --private-key \"{private_key}\" "
        f"--query \"https://node.puzzle.online\" --broadcast \"https://node.puzzle.online/testnet3/transaction/broadcast\" "
        f"--priority-fee 0"
    )
    # Execute the CLI command
    subprocess.run(cli_command, shell=True)
print("All players have been processed. Sleeping for 2 minutes before testing formation.")
time.sleep(120)

var1 = "[1u8,4u8,5u8,6u8,7u8,8u8,9u8,10u8,11u8,12u8,13u8]"

cli_command = (
    f"snarkos developer execute \"{contract}\" \"validate_formation\" "
    f"\"{var1}\" --private-key \"{private_key}\" "
    f"--query \"https://node.puzzle.online\" --broadcast \"https://node.puzzle.online/testnet3/transaction/broadcast\" "
    f"--priority-fee 0"
)
    # Execute the CLI command    
subprocess.run(cli_command, shell=True)


var1 = "[1u8,4u8,5u8,6u8,7u8,8u8,9u8,10u8,11u8,12u8,13u8]"

cli_command = (
    f"snarkos developer execute \"{contract}\" \"validate_formation\" "
    f"\"{var1}\" --private-key \"{private_key}\" "
    f"--query \"https://node.puzzle.online\" --broadcast \"https://node.puzzle.online/testnet3/transaction/broadcast\" "
    f"--priority-fee 0"
)
    # Execute the CLI command    
subprocess.run(cli_command, shell=True)

print("Script completed.")
